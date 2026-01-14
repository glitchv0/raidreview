#!/usr/bin/env python3
"""
Generate rotation comparison reports by dynamically discovering abilities from WCL data.
No hardcoded ability lists - discovers what matters from actual damage breakdown.
"""

import json
import requests
import sys
import re
from pathlib import Path

# Abilities to exclude (passive procs, auto-attacks, pets, etc.)
EXCLUDE_PATTERNS = [
    r'^Melee$', r'^Auto Shot$', r'^Auto Attack$',
    r'Shadowy Apparition', r'Venomous Wound', r'Deep Wounds',
    r'Opportunity Strike', r'^Seal of', r'Censure', r'Stormlash',
    r'Lightning Arrow', r'Improved Serpent Sting', r'Death by Voodoo',
    r'^Crit \(', r'Legendary', r'Capacitor Totem', r'Ancestral Guidance',
    r'Blade Flurry', r'^Cleave$', r'^Whirlwind$', r'Searing Flames',
    r'Flametongue Attack', r'Windfury Attack', r'Stormstrike Off-Hand',
    r'Lava Lash Off-Hand', r'Main Gauche', r'Poison', r'Lightning Shield',
    r'Elemental Overload', r'Mastery:', r'Echo of the Elements',
    r'Fel Flame', r'Wild Imp', r'Shadowflame', r'Immolation Aura',
    # Pet summons and procs
    r'^Summon ', r'Thunderhawk', r'Wrathguard', r'Terrorguard', r'Abyssal',
    # Boss-specific abilities (Primordius mutations, etc.)
    r'Corrupted', r'Mutated',
]

# Boss encounter IDs to names
ENC_TO_BOSS = {
    51577: "Jinrokh", 51575: "Horridon", 51570: "Council_of_Elders",
    51565: "Tortos", 51578: "Megaera", 51573: "Ji-Kun",
    51572: "Durumu", 51574: "Primordius", 51576: "Dark_Animus",
    51559: "Iron_Qon", 51560: "Twin_Empyreans", 51579: "Lei_Shen",
}

# Abbreviations for common abilities
ABBREVIATIONS = {
    "Shadow Word: Pain": "SWP", "Shadow Word: Death": "SWD",
    "Vampiric Touch": "VT", "Devouring Plague": "DP",
    "Mind Blast": "MB", "Mind Flay": "MF", "Mind Flay (Insanity)": "MFI",
    "Shadowfiend": "SFnd", "Mortal Strike": "MS", "Colossus Smash": "CS",
    "Explosive Shot": "ES", "Black Arrow": "BA", "Serpent Sting": "SrS",
    "Cobra Shot": "CoS", "Arcane Shot": "AS", "Kill Shot": "KS",
    "A Murder of Crows": "AMoC", "Glaive Toss": "GT",
    "Soul Fire": "SF", "Shadow Bolt": "ShB", "Hand of Gul'dan": "HoG",
    "Touch of Chaos": "ToC", "Corruption": "Corr", "Doom": "Doom",
    "Mutilate": "Mut", "Envenom": "Env", "Rupture": "Rup",
    "Dispatch": "Disp", "Revealing Strike": "RS", "Sinister Strike": "SS",
    "Eviscerate": "Evis", "Killing Spree": "KSpree",
    "Chaos Bolt": "CB", "Conflagrate": "Conf", "Incinerate": "Inc",
    "Immolate": "Immo", "Shadowburn": "SBurn",
    "Lava Burst": "LvB", "Lightning Bolt": "LB", "Flame Shock": "FS",
    "Earth Shock": "ES", "Chain Lightning": "CL",
    "Stormstrike": "SS", "Lava Lash": "LL",
    "Fireball": "FBall", "Pyroblast": "Pyro", "Living Bomb": "LvBomb",
    "Combustion": "Comb", "Inferno Blast": "InfB",
    "Frostbolt": "FrB", "Ice Lance": "IL", "Frozen Orb": "FOrb",
    "Crusader Strike": "CrS", "Judgment": "Jud", "Templar's Verdict": "TV",
    "Exorcism": "Exo", "Hammer of Wrath": "HoW",
    "Obliterate": "Oblit", "Frost Strike": "FrS", "Howling Blast": "HB",
    "Soul Reaper": "SR", "Scourge Strike": "ScS", "Festering Strike": "FsS",
    "Death Coil": "DC", "Wrath": "Wr", "Starfire": "StF",
    "Starsurge": "SSurge", "Moonfire": "MoF", "Sunfire": "SuF",
    "Shred": "Shred", "Rake": "Rake", "Rip": "Rip",
    "Ferocious Bite": "FB", "Savage Roar": "SvR",
    "Jab": "Jab", "Tiger Palm": "TP", "Blackout Kick": "BoK",
    "Rising Sun Kick": "RSK", "Fists of Fury": "FoF",
    "Malefic Grasp": "MG", "Unstable Affliction": "UA",
    "Agony": "Agony", "Haunt": "Haunt",
}


def get_token():
    """Get WCL API token from file."""
    token_file = Path("/tmp/wcl_token.txt")
    if token_file.exists():
        return token_file.read_text().strip()
    return None


def wcl_query(query: str, token: str) -> dict:
    """Execute a WCL GraphQL query."""
    response = requests.post(
        "https://classic.warcraftlogs.com/api/v2/client",
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        json={"query": query}
    )
    return response.json()


def get_damage_table(report_code: str, fight_id: int, source_id: int, token: str) -> dict:
    """Fetch DamageDone table for a specific fight and player."""
    query = f'''{{
        reportData {{
            report(code: "{report_code}") {{
                table(dataType: DamageDone, fightIDs: [{fight_id}], sourceID: {source_id})
            }}
        }}
    }}'''
    return wcl_query(query, token)


def should_exclude(ability_name: str) -> bool:
    """Check if ability should be excluded from tracking."""
    for pattern in EXCLUDE_PATTERNS:
        if re.search(pattern, ability_name, re.IGNORECASE):
            return True
    return False


def abbreviate(name: str) -> str:
    """Format ability name (no abbreviations for clarity)."""
    return name


def extract_abilities(table_data: dict, fight_duration_ms: int, limit: int = 10) -> list:
    """
    Extract top abilities from damage table.
    Returns list of {name, type, value, damage} sorted by damage.
    Keeps all entries like WCL does (initial hit vs DoT are separate).
    """
    if not table_data or "data" not in table_data:
        return []

    try:
        entries = table_data["data"]["reportData"]["report"]["table"]["data"]["entries"]
    except (KeyError, TypeError):
        return []

    abilities = []
    for entry in entries:
        name = entry.get("name", "")
        if not name or should_exclude(name):
            continue

        total_damage = entry.get("total", 0)
        if total_damage <= 0:
            continue

        uptime = entry.get("uptime")
        uses = entry.get("uses") or entry.get("hitCount", 0)

        if uptime and uptime > 0:
            # DoT - calculate uptime percentage
            value = round(uptime * 100 / fight_duration_ms, 1)
            ability_type = "dot"
        elif uses and uses > 0:
            # Cast ability - calculate CPM
            value = round(uses * 60000 / fight_duration_ms, 1)
            ability_type = "cast"
        else:
            continue

        abilities.append({
            "name": name,
            "type": ability_type,
            "value": value,
            "damage": total_damage
        })

    # Sort by damage and take top N
    abilities.sort(key=lambda x: x["damage"], reverse=True)
    return abilities[:limit]


def calculate_gap(player_val: float, top_val: float, ability_type: str) -> str:
    """Calculate gap between player and top performer."""
    if top_val == 0:
        return "-"

    if ability_type == "dot":
        gap = player_val - top_val
        if gap > 0:
            return f"+{gap:.1f}%"
        return f"{gap:.1f}%"
    else:
        gap_pct = (player_val - top_val) * 100 / top_val
        if gap_pct > 0:
            return f"+{gap_pct:.0f}%"
        return f"{gap_pct:.0f}%"


def get_top_performer_value(top_table: dict, ability_name: str, ability_type: str, fight_duration_ms: int) -> float:
    """Get the top performer's value for a specific ability."""
    if not top_table:
        return 0

    try:
        entries = top_table["data"]["reportData"]["report"]["table"]["data"]["entries"]
    except (KeyError, TypeError):
        return 0

    for entry in entries:
        if entry.get("name") == ability_name:
            if ability_type == "dot":
                uptime = entry.get("uptime", 0)
                if uptime:
                    return round(uptime * 100 / fight_duration_ms, 1)
            else:
                uses = entry.get("uses") or entry.get("hitCount", 0)
                if uses:
                    return round(uses * 60000 / fight_duration_ms, 1)
    return 0


def generate_rotation_report(player_id: int, spec: str, report_code: str, player_name: str = None):
    """Generate rotation comparison report for a player."""
    token = get_token()
    if not token:
        print("Error: No WCL token found at /tmp/wcl_token.txt")
        sys.exit(1)

    report_info_path = Path(f"raw/{report_code}/report_info.json")
    if not report_info_path.exists():
        print(f"Error: Report info not found at {report_info_path}")
        sys.exit(1)

    with open(report_info_path) as f:
        report_info = json.load(f)

    fights = report_info["data"]["reportData"]["report"]["fights"]

    # Collect all gaps for saving to comparison file
    all_gaps = []

    print("#### Per-Boss Rotation Analysis vs Top Performers")
    print()
    print("| Boss | Ability | You | Top | Gap |")
    print("|------|---------|-----|-----|-----|")

    for fight in fights:
        if not fight.get("kill") or not fight.get("encounterID"):
            continue

        fight_id = fight["id"]
        enc_id = fight["encounterID"]
        boss_name = ENC_TO_BOSS.get(enc_id, fight["name"].replace(" ", "_"))

        start_time = fight["startTime"]
        end_time = fight["endTime"]
        fight_duration = end_time - start_time

        if fight_duration <= 0:
            continue

        # Get player damage table
        player_table = get_damage_table(report_code, fight_id, player_id, token)

        # Get top performer data
        top_file = Path(f"raw/{report_code}/top_performers_by_boss/{spec}/{boss_name}_damage.json")
        top_table = None
        top_duration = fight_duration

        if top_file.exists():
            with open(top_file) as f:
                top_table = json.load(f)
            try:
                top_duration = top_table["data"]["reportData"]["report"]["table"]["data"]["totalTime"]
            except (KeyError, TypeError):
                top_duration = fight_duration

        # Extract top abilities
        abilities = extract_abilities(player_table, fight_duration)

        first_ability = True
        for ability in abilities:
            name = ability["name"]
            ability_type = ability["type"]
            player_value = ability["value"]

            # Get top performer value
            top_value = get_top_performer_value(top_table, name, ability_type, top_duration)

            # Calculate gap
            gap = calculate_gap(player_value, top_value, ability_type)

            # Format display
            short_name = abbreviate(name)
            if ability_type == "dot":
                player_display = f"{player_value}%"
                top_display = f"{top_value}%" if top_value else "-"
            else:
                player_display = f"{player_value}"
                top_display = f"{top_value}" if top_value else "-"

            # Boss name only on first row
            boss_display = f"**{boss_name}**" if first_ability else ""
            first_ability = False

            print(f"| {boss_display} | {short_name} | {player_display} | {top_display} | {gap} |")

    print()
    print("*CPM = Casts Per Minute, % = Uptime. Top 10 abilities by damage shown.*")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: ./gen_rotation_report.py <player_id> <spec> [report_code]")
        sys.exit(1)

    player_id = int(sys.argv[1])
    spec = sys.argv[2]
    report_code = sys.argv[3] if len(sys.argv) > 3 else "ZvBgMjA8y64TxDak"

    generate_rotation_report(player_id, spec, report_code)
