#!/usr/bin/env python3
"""Generate complete healer analysis report for a raid."""

import json
import requests
import sys
from pathlib import Path

# Key abilities per spec
SPEC_ABILITIES = {
    "discipline_priest": ["Penance", "Power Word: Shield", "Prayer of Mending", "Spirit Shell", "Pain Suppression", "Power Word: Barrier"],
    "holy_priest": ["Circle of Healing", "Prayer of Mending", "Lightwell", "Divine Hymn", "Guardian Spirit"],
    "restoration_druid": ["Rejuvenation", "Wild Growth", "Lifebloom", "Swiftmend", "Tranquility", "Ironbark"],
    "restoration_shaman": ["Riptide", "Chain Heal", "Healing Rain", "Healing Stream Totem", "Spirit Link Totem", "Healing Tide Totem"],
    "holy_paladin": ["Holy Shock", "Word of Glory", "Eternal Flame", "Beacon of Light", "Lay on Hands"],
    "mistweaver_monk": ["Renewing Mist", "Uplift", "Soothing Mist", "Enveloping Mist", "Revival", "Life Cocoon"],
}

# Spec mapping from icon
SUBTYPE_TO_SPEC = {
    "Discipline": "discipline_priest",
    "Holy": "holy_priest",  # or paladin - need class context
    "Restoration": "restoration_druid",  # or shaman - need class context
    "Mistweaver": "mistweaver_monk",
}

def get_token():
    token_file = Path("/tmp/wcl_token.txt")
    if token_file.exists():
        return token_file.read_text().strip()
    return None

def wcl_query(query: str, token: str) -> dict:
    response = requests.post(
        "https://classic.warcraftlogs.com/api/v2/client",
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        json={"query": query}
    )
    return response.json()

def get_spec_from_icon(icon: str) -> str:
    """Convert icon like 'Priest-Discipline' to spec key."""
    parts = icon.split("-")
    if len(parts) != 2:
        return None
    class_name, spec_name = parts

    if spec_name == "Holy":
        if class_name == "Priest":
            return "holy_priest"
        elif class_name == "Paladin":
            return "holy_paladin"
    elif spec_name == "Restoration":
        if class_name == "Druid":
            return "restoration_druid"
        elif class_name == "Shaman":
            return "restoration_shaman"

    return SUBTYPE_TO_SPEC.get(spec_name)

def generate_healer_report(report_code: str):
    token = get_token()
    if not token:
        print("Error: No WCL token found")
        sys.exit(1)

    report_info_path = Path(f"raw/{report_code}/report_info.json")
    if not report_info_path.exists():
        print(f"Error: Report info not found")
        sys.exit(1)

    with open(report_info_path) as f:
        report_info = json.load(f)

    # Get report metadata
    report_data = report_info["data"]["reportData"]["report"]
    title = report_data.get("title", "Raid")
    start_time = report_data.get("startTime", 0)

    from datetime import datetime
    date = datetime.fromtimestamp(start_time / 1000).strftime("%Y-%m-%d")

    # Get difficulty
    fights = report_data["fights"]
    difficulty = 3
    for fight in fights:
        if fight.get("kill") and fight.get("encounterID"):
            difficulty = fight.get("difficulty", 3)
            break

    diff_names = {3: "10N", 4: "25N", 5: "10H", 6: "25H"}
    diff_name = diff_names.get(difficulty, "Unknown")

    # Output directory
    output_dir = Path(f"reports/{date}_{diff_name}_{report_code}")
    output_dir.mkdir(parents=True, exist_ok=True)

    # Get first fight ID for player details
    first_fight_id = None
    for fight in fights:
        if fight.get("kill") and fight.get("encounterID"):
            first_fight_id = fight["id"]
            break

    if not first_fight_id:
        print("No kills found")
        sys.exit(1)

    # Get player details
    query = f'''{{
        reportData {{
            report(code: "{report_code}") {{
                playerDetails(fightIDs: [{first_fight_id}])
            }}
        }}
    }}'''

    player_data = wcl_query(query, token)

    lines = []
    lines.append("# Healer Performance Analysis")
    lines.append("")
    lines.append(f"**Raid:** {title}")
    lines.append(f"**Date:** {date}")
    lines.append(f"**Difficulty:** {diff_name}")
    lines.append(f"**Log:** [{report_code}](https://classic.warcraftlogs.com/reports/{report_code})")
    lines.append("")

    try:
        healers = player_data["data"]["reportData"]["report"]["playerDetails"]["data"]["playerDetails"]["healers"]
    except (KeyError, TypeError):
        healers = []

    if not healers:
        lines.append("No healers found in this report.")
        with open(output_dir / "healers.md", "w") as f:
            f.write("\n".join(lines))
        print(f"Report generated: {output_dir}/healers.md")
        return

    for healer in healers:
        healer_id = healer["id"]
        name = healer["name"]
        icon = healer.get("icon", "")
        spec = get_spec_from_icon(icon)

        lines.append("---")
        lines.append(f"### {name} ({icon})")
        lines.append("")
        lines.append("#### Per-Boss Healing Analysis")
        lines.append("")
        lines.append("| Boss | HPS | Overheal % | Top Ability | Casts |")
        lines.append("|------|-----|------------|-------------|-------|")

        total_casts_by_ability = {}

        for fight in fights:
            if not fight.get("kill") or not fight.get("encounterID"):
                continue

            fight_id = fight["id"]
            boss_name = fight["name"].replace(" ", "_")
            start_time = fight["startTime"]
            end_time = fight["endTime"]
            duration_ms = end_time - start_time

            if duration_ms <= 0:
                continue

            # Get healing data
            heal_query = f'''{{
                reportData {{
                    report(code: "{report_code}") {{
                        table(dataType: Healing, fightIDs: [{fight_id}], sourceID: {healer_id})
                    }}
                }}
            }}'''

            heal_data = wcl_query(heal_query, token)

            try:
                entries = heal_data["data"]["reportData"]["report"]["table"]["data"]["entries"]

                total_healing = sum(e.get("total", 0) for e in entries)
                total_overheal = sum(e.get("overheal", 0) for e in entries)

                hps = int(total_healing * 1000 / duration_ms)
                overheal_pct = round(total_overheal * 100 / (total_healing + total_overheal), 1) if (total_healing + total_overheal) > 0 else 0

                # Find top ability
                top_ability = ""
                top_casts = 0
                for entry in entries:
                    ability_name = entry.get("name", "")
                    casts = entry.get("uses", 0) or entry.get("hitCount", 0)
                    if entry.get("total", 0) > 0:
                        if not top_ability:
                            top_ability = ability_name
                            top_casts = casts

                    # Track total casts
                    if ability_name not in total_casts_by_ability:
                        total_casts_by_ability[ability_name] = 0
                    total_casts_by_ability[ability_name] += casts

                lines.append(f"| **{boss_name}** | {hps:,} | {overheal_pct}% | {top_ability} | {top_casts} |")

            except (KeyError, TypeError):
                pass

        lines.append("")
        lines.append("*HPS = Healing Per Second*")
        lines.append("")

        # Key ability usage summary
        lines.append("#### Key Ability Usage")
        lines.append("")
        lines.append("| Ability | Total Casts |")
        lines.append("|---------|-------------|")

        key_abilities = SPEC_ABILITIES.get(spec, [])
        for ability in key_abilities:
            casts = total_casts_by_ability.get(ability, 0)
            lines.append(f"| {ability} | {casts} |")

        lines.append("")

    with open(output_dir / "healers.md", "w") as f:
        f.write("\n".join(lines))

    print(f"Report generated: {output_dir}/healers.md")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: ./gen_full_healer_report.py <report_code>")
        sys.exit(1)

    generate_healer_report(sys.argv[1])
