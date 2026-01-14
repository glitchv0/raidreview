#!/usr/bin/env python3
"""Generate complete tank analysis report for a raid."""

import json
import requests
import sys
from pathlib import Path

# Defensive ability tracking per spec
SPEC_DEFENSIVES = {
    "brewmaster_monk": ["Shuffle", "Guard", "Elusive Brew", "Fortifying Brew", "Dampen Harm", "Zen Meditation"],
    "protection_paladin": ["Shield of the Righteous", "Sacred Shield", "Divine Protection", "Ardent Defender", "Guardian of Ancient Kings"],
    "protection_warrior": ["Shield Block", "Shield Barrier", "Shield Wall", "Last Stand", "Demoralizing Shout"],
    "blood_dk": ["Blood Shield", "Bone Shield", "Vampiric Blood", "Icebound Fortitude", "Anti-Magic Shell"],
    "guardian_druid": ["Savage Defense", "Frenzied Regeneration", "Barkskin", "Survival Instincts"],
}

# Spec mapping from icon
SUBTYPE_TO_SPEC = {
    "Brewmaster": "brewmaster_monk",
    "Protection": "protection_paladin",  # or warrior - need class context
    "Blood": "blood_dk",
    "Guardian": "guardian_druid",
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
    """Convert icon like 'Paladin-Protection' to spec key."""
    parts = icon.split("-")
    if len(parts) != 2:
        return None
    class_name, spec_name = parts

    if spec_name == "Protection":
        if class_name == "Paladin":
            return "protection_paladin"
        elif class_name == "Warrior":
            return "protection_warrior"

    return SUBTYPE_TO_SPEC.get(spec_name)

def generate_tank_report(report_code: str):
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
    lines.append("# Tank Performance Analysis")
    lines.append("")
    lines.append(f"**Raid:** {title}")
    lines.append(f"**Date:** {date}")
    lines.append(f"**Difficulty:** {diff_name}")
    lines.append(f"**Log:** [{report_code}](https://classic.warcraftlogs.com/reports/{report_code})")
    lines.append("")

    try:
        tanks = player_data["data"]["reportData"]["report"]["playerDetails"]["data"]["playerDetails"]["tanks"]
    except (KeyError, TypeError):
        tanks = []

    if not tanks:
        lines.append("No tanks found in this report.")
        with open(output_dir / "tanks.md", "w") as f:
            f.write("\n".join(lines))
        print(f"Report generated: {output_dir}/tanks.md")
        return

    for tank in tanks:
        tank_id = tank["id"]
        name = tank["name"]
        icon = tank.get("icon", "")
        spec = get_spec_from_icon(icon)

        lines.append("---")
        lines.append(f"### {name} ({icon})")
        lines.append("")
        lines.append("#### Per-Boss Defensive Analysis")
        lines.append("")
        lines.append("| Boss | Metric | Value |")
        lines.append("|------|--------|-------|")

        defensives = SPEC_DEFENSIVES.get(spec, [])

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

            # Get buffs data for defensive uptimes
            buffs_query = f'''{{
                reportData {{
                    report(code: "{report_code}") {{
                        table(dataType: Buffs, fightIDs: [{fight_id}], sourceID: {tank_id})
                    }}
                }}
            }}'''

            buffs_data = wcl_query(buffs_query, token)

            # Get damage taken for DTPS
            dtps_query = f'''{{
                reportData {{
                    report(code: "{report_code}") {{
                        table(dataType: DamageTaken, fightIDs: [{fight_id}], sourceID: {tank_id})
                    }}
                }}
            }}'''

            dtps_data = wcl_query(dtps_query, token)

            first_row = True

            # Extract defensive uptimes
            try:
                entries = buffs_data["data"]["reportData"]["report"]["table"]["data"]["auras"]
                for entry in entries:
                    ability_name = entry.get("name", "")
                    if any(d.lower() in ability_name.lower() for d in defensives):
                        uptime = entry.get("totalUptime", 0)
                        uptime_pct = round(uptime * 100 / duration_ms, 1)

                        boss_col = f"**{boss_name}**" if first_row else ""
                        first_row = False
                        lines.append(f"| {boss_col} | {ability_name} | {uptime_pct}% |")
            except (KeyError, TypeError):
                pass

            # Calculate DTPS
            try:
                total_damage = dtps_data["data"]["reportData"]["report"]["table"]["data"]["totalDamage"]
                dtps = int(total_damage * 1000 / duration_ms)
                boss_col = f"**{boss_name}**" if first_row else ""
                lines.append(f"| {boss_col} | DTPS | {dtps:,} |")
            except (KeyError, TypeError):
                pass

        lines.append("")
        lines.append("*DTPS = Damage Taken Per Second*")
        lines.append("")

    with open(output_dir / "tanks.md", "w") as f:
        f.write("\n".join(lines))

    print(f"Report generated: {output_dir}/tanks.md")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: ./gen_full_tank_report.py <report_code>")
        sys.exit(1)

    generate_tank_report(sys.argv[1])
