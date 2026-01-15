# Raid Report Generator - How To Guide

## Overview

This document explains how to pull raid data from Warcraft Logs and generate performance reports for the guild "Make Azeroth Great Again".

---

## Quick Links

### GitHub Pages (Live Reports)
- **Main Site:** https://glitchv0.github.io/raidreview/
- **Custom Domain:** https://glitchv0.com/raidreview/

### GitHub Repository
- **Reports Repository:** https://github.com/glitchv0/raidreview

### Report Structure (HTML)
Reports generate as static HTML with Bootstrap styling and Wowhead tooltips:
```
reports/
├── index.html                    # Master raid list
├── static/style.css              # WoW-themed dark CSS
├── .nojekyll                     # Disable Jekyll processing
└── <date>_<difficulty>_<code>/
    ├── index.html                # Raid summary with player cards
    ├── meta.json                 # Metadata for indexing
    └── players/
        ├── Oldbaldy_fire_mage.html
        ├── Plotarmored_protection_paladin.html
        ├── Nybura_mistweaver_monk.html
        └── ...
```

---

## WCL API Credentials

Credentials are stored in `~/.wcl_credentials` (not in repo). Format:
```
WCL_CLIENT_ID=your_client_id
WCL_CLIENT_SECRET=your_client_secret
```

Token Endpoint: https://classic.warcraftlogs.com/oauth/token
API Endpoint: https://classic.warcraftlogs.com/api/v2/client

---

## Step 1: Get OAuth Token

The token expires periodically. Always refresh before running queries.

```bash
./refresh_token.sh
```

Token is saved to `/tmp/wcl_token.txt` and read automatically by the Python scripts.

---

## Step 2: Get Report Info (Fights & Players)

Replace `REPORT_CODE` with the code from the WCL URL (e.g., `DkgR89WBa47FJd1C`).

### Query: Get All Fights and Players

Write query to file, then execute:
```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { fights { id name kill difficulty encounterID startTime endTime } masterData { actors(type: \"Player\") { id name type subType } } } } }"}' > /home/jeremy/wcl_query.json

curl -s -X POST "https://classic.warcraftlogs.com/api/v2/client" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d @/home/jeremy/wcl_query.json
```

### Key Fields

| Field | Description |
|-------|-------------|
| fights.id | Fight ID for queries |
| fights.kill | true = boss kill, false = wipe |
| fights.difficulty | 3=10N, 4=25N, 5=10H, 6=25H |
| fights.encounterID | Boss ID for rankings |
| masterData.actors | All players with id, name, spec |

---

## Step 3: Get Rankings for a Fight

**IMPORTANT**: The default rankings query returns a COMBINED parse that includes healer DPS. This is NOT the healing-only parse!

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { rankings(fightIDs: [FIGHT_ID]) } } }"}' > /home/jeremy/wcl_query.json
```

### Rankings Response Structure

```json
{
  "roles": {
    "healers": {
      "characters": [
        {
          "name": "PlayerName",
          "spec": "Restoration",
          "amount": 30993,      // This is DPS contribution, NOT HPS!
          "rankPercent": 78,    // This is COMBINED parse (includes DPS)
          "bracketPercent": 85
        }
      ]
    }
  }
}
```

---

## CRITICAL: Healer Parse Types

### Getting Parse Percentiles with playerMetric

**IMPORTANT:** The default `rankings()` query returns DPS parse even for healers! You MUST use the `playerMetric` parameter:

```graphql
# For healing parse (healers):
rankings(fightIDs: [FIGHT_ID], playerMetric: hps)

# For damage parse (DPS/tanks):
rankings(fightIDs: [FIGHT_ID], playerMetric: dps)
```

**For healers, pull BOTH parses:**
```python
# HPS parse - the main metric for healers
hps_query = '''{ reportData { report(code: "CODE") {
  rankings(fightIDs: [FIGHT_ID], playerMetric: hps)
}}}'''

# DPS parse - secondary metric for healers (fistweaving, atonement)
dps_query = '''{ reportData { report(code: "CODE") {
  rankings(fightIDs: [FIGHT_ID], playerMetric: dps)
}}}'''
```

### Combined Parse vs Healing Parse

WCL has TWO different parse types for healers:

| Parse Type | Query Parameter | Use For |
|------------|-----------------|---------|
| HPS Only | `playerMetric: hps` | **Primary healer evaluation** |
| DPS Only | `playerMetric: dps` | Secondary (fistweaving/atonement) |
| Combined/Default | No parameter | NOT recommended |

**Example from our raid:**
- Nybura (Mistweaver): 0% HPS parse, 35% DPS parse
- This shows they were DPSing (fistweaving) but not healing effectively

### How to Get True Healing Performance

1. **Pull raw healing data:**
```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { table(dataType: Healing, fightIDs: [FIGHT_ID], hostilityType: Friendlies) } } }"}' > /home/jeremy/wcl_query.json
```

2. **Calculate HPS**: Total Healing / Fight Duration

3. **Get HPS parse from rankings:**
```graphql
rankings(fightIDs: [FIGHT_ID], playerMetric: hps)
# Extract rankPercent from the player's entry
```

### Healer Ranking Guidelines

**Always rank healers by:**
1. HPS (healing per second)
2. Healing parse (compared to other healers of same spec)
3. Cooldown usage efficiency
4. Overheal percentage (lower is better)

**DPS is secondary** - only matters after healing duties are covered.

---

## Step 4: Get Damage/Healing Tables

### Damage Done (All Players)

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { table(dataType: DamageDone, fightIDs: [FIGHT_ID]) } } }"}' > /home/jeremy/wcl_query.json
```

### Healing Done (All Players)

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { table(dataType: Healing, fightIDs: [FIGHT_ID], hostilityType: Friendlies) } } }"}' > /home/jeremy/wcl_query.json
```

### Per-Player Breakdown (Damage + Healing + Casts + Buffs)

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") {
  damage: table(dataType: DamageDone, sourceID: PLAYER_ID, fightIDs: [FIGHT_ID])
  healing: table(dataType: Healing, sourceID: PLAYER_ID, fightIDs: [FIGHT_ID])
  casts: table(dataType: Casts, sourceID: PLAYER_ID, fightIDs: [FIGHT_ID])
  buffs: table(dataType: Buffs, sourceID: PLAYER_ID, fightIDs: [FIGHT_ID])
} } }"}' > /home/jeremy/wcl_query.json
```

---

## Step 5: Compare to Top Players

### Get Top Rankings for an Encounter

**For DPS:**
```bash
echo '{"query": "{ worldData { encounter(id: ENCOUNTER_ID) { characterRankings(specName: \"SPEC\", className: \"CLASS\", difficulty: DIFFICULTY, metric: dps, page: 1) } } }"}' > /home/jeremy/wcl_query.json
```

**For Healers (HPS only):**
```bash
echo '{"query": "{ worldData { encounter(id: ENCOUNTER_ID) { characterRankings(specName: \"SPEC\", className: \"CLASS\", difficulty: DIFFICULTY, metric: hps, page: 1) } } }"}' > /home/jeremy/wcl_query.json
```

### Find Similar Kill Time

Filter by `duration` in response to find players with similar fight lengths for fair comparison.

### Encounter IDs (Throne of Thunder)

| Boss | Encounter ID |
|------|--------------|
| Jin'rokh | 51577 |
| Horridon | 51575 |
| Council of Elders | 51570 |
| Tortos | 51565 |
| Megaera | 51578 |
| Ji-Kun | 51573 |
| Durumu | 51572 |
| Primordius | 51574 |
| Dark Animus | 51576 |
| Iron Qon | 51559 |
| Twin Consorts | 51560 |
| Lei Shen | 51579 |
| Ra-den | 51580 |

### Difficulty IDs

| ID | Difficulty |
|----|------------|
| 3 | Normal |
| 4 | Heroic |

Note: Raid size (10 vs 25) is determined by player count, not difficulty ID.

---

## Step 6: Get Player Summary (Talents, Glyphs, Gear)

Use the Summary dataType to get a player's full build information:

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { table(dataType: Summary, fightIDs: [FIGHT_ID], sourceID: PLAYER_ID) } } }"}' > /home/jeremy/wcl_query.json
```

### Response Structure

```json
{
  "combatantInfo": {
    "stats": { "Intellect": {...}, "Haste": {...}, ... },
    "talents": [
      { "name": "Void Tendrils", "guid": 108920, "type": 1, "abilityIcon": "..." },
      // 6 talents (one per tier)
    ],
    "artifact": [
      { "name": "Glyph of Fade", "guid": 55684, "type": 1, "abilityIcon": "..." },
      // Glyphs are stored in "artifact" field, NOT "glyphs"
    ],
    "gear": [
      { "id": 94280, "slot": 0, "name": "...", "itemLevel": 522, "gems": [...], "permanentEnchant": 4806 },
      // Full gear with enchants and gems
    ]
  }
}
```

**Important**: Glyphs are stored in the `artifact` array, not a `glyphs` field.

---

## Step 7: Generate Reports (Recommended Method)

Use the Python scripts for automatic per-player HTML report generation.

### Generate All Player Reports (One Command)

```bash
./gen_all_reports.py <report_code>
```

This script:
1. Fetches all players and fights from the raid
2. Prefetches top performer data (talents, damage, healing tables)
3. For each player, generates `players/{Name}_{spec}.html` with:
   - Per-boss performance with fight duration
   - Parse percentiles (HPS for healers, DPS for DPS/tanks)
   - Ability rotation comparison vs top performers
   - Talent/glyph differences with Wowhead tooltips
   - Consumable audit (flask, food, potions, engineering)
   - Auto-generated suggestions
4. Generates `index.html` with raid summary and player cards
5. Generates root `index.html` listing all raids
6. Saves `meta.json` with guild name, boss count, player count

### Generate Single Player Report

```bash
./gen_player_report.py <report_code> <player_id> <player_name> <spec_key> <role>
```

Where role is: `dps`, `tank`, or `healer`

### Dynamic Ability Discovery (How It Works)

The `gen_rotation_report.py` script uses the WCL `DamageDone` table instead of hardcoded ability lists:

```python
# Queries this endpoint:
table(dataType: DamageDone, fightIDs: [fight_id], sourceID: player_id)

# Extracts from response:
- uptime field → DoT uptime %
- uses or hitCount → CPM for casts
```

**Benefits:**
- Works for all 34 DPS specs without configuration
- Discovers what player actually used
- Shows both initial hit and DoT (like WCL)
- Full ability names (no abbreviations)

**Auto-excluded abilities:**
- Auto attacks (Melee, Auto Shot)
- Passive procs (Shadowy Apparition, Deep Wounds)
- Pet summons (Summon Wrathguard)
- Boss mechanics (Corrupted, Mutated)

### Manual Rotation Query (Alternative)

If you need raw cast data:

```bash
echo '{"query": "{ reportData { report(code: \"REPORT_CODE\") { table(dataType: Casts, fightIDs: [FIGHT_ID], sourceID: PLAYER_ID) } } }"}' > /home/jeremy/wcl_query.json
```

### Key Rotation Issues to Flag

| Gap % | Severity | Action |
|-------|----------|--------|
| >50% fewer | **Critical** | Ability likely missing from rotation |
| 25-50% fewer | Warning | Needs improvement |
| ±25% | Normal | Within acceptable variance |
| >50% more | Check | May indicate priority error |

---

## Step 8: Raw Data Storage

Store all API responses in organized folders to avoid overwrites and enable re-analysis.

### Folder Structure

```
/home/jeremy/raidreport/raw/<report_code>/
├── report_info.json        # Fights + masterData (players)
├── rankings.json           # All fight rankings
├── damage_done.json        # Raid-wide damage table
├── healing_done.json       # Raid-wide healing table
├── summary/                # Per-player summary data
│   ├── player_1.json       # Player ID 1's talents/glyphs/gear
│   ├── player_3.json
│   └── ...
├── casts/                  # Per-player cast data
│   ├── player_1.json       # Player ID 1's cast counts
│   ├── player_4.json
│   └── ...
└── top_performers/         # Comparison data from worldData
    ├── shadow_priest.json
    ├── resto_druid.json
    ├── arms_warrior_casts.json  # Top performer cast data
    └── ...
```

### Workflow

1. **Create folder**: `mkdir -p /home/jeremy/raidreport/raw/<report_code>/summary`
2. **Save each query**: Redirect output to appropriate file
3. **Read from files**: When generating reports, read from raw/ instead of re-querying

### Example

```bash
REPORT_CODE="ZvBgMjA8y64TxDak"
RAW_DIR="/home/jeremy/raidreport/raw/$REPORT_CODE"
mkdir -p "$RAW_DIR/summary" "$RAW_DIR/top_performers"

# Save report info
curl ... -d @query.json > "$RAW_DIR/report_info.json"

# Save player summary
curl ... -d '{"query": "...sourceID: 1..."}' > "$RAW_DIR/summary/player_1.json"
```

---

## Suggestion Tiers

When analyzing players, provide suggestions for ALL players based on performance tier:

| Parse % | Tier | Suggestion Style |
|---------|------|------------------|
| <25% | Critical | Numbered priority fixes, rotation guides, links |
| 25-50% | Needs Work | 2-3 specific improvements |
| 50-75% | Good | 1-2 optimization tips, minor tweaks |
| 75%+ | Excellent | Positive reinforcement, optional min-max tips |

### Always Check

1. **Consumables**: Pre-pot + second pot?
2. **Cooldowns**: All major CDs used optimally?
3. **Talents**: Match fight type (ST vs cleave)?
4. **Glyphs**: All beneficial glyphs equipped?
5. **Rotation**: Any ability underuse?
6. **Gear**: Missing enchants/gems?

---

## Quick Start for Next Week

### 1. Get the new log code from WCL URL

```
https://classic.warcraftlogs.com/reports/XXXXXXXXXXXXXXXX
                                        ^^^^^^^^^^^^^^^^
                                        This is the code
```

### 2. Refresh token

```bash
bash /home/jeremy/get_token.sh
# Token saved to /tmp/wcl_token.txt
```

### 3. Generate All Reports (One Command)

```bash
./gen_all_reports.py XXXXXXXXXXXXXXXX
```

This generates:
- `reports/<date>_<difficulty>_<code>/index.html` - Raid summary with player cards
- `reports/<date>_<difficulty>_<code>/players/*.html` - Individual player reports
- `reports/index.html` - Updated master raid list
- `index.html` - Root index for GitHub Pages

### 4. Push to GitHub

```bash
git add reports/ index.html
git commit -m "Add raid report: <date> <difficulty>"
git push
```

Reports are automatically available on GitHub Pages after push.

### Or Just Ask Claude

```
Analyze raid log https://classic.warcraftlogs.com/reports/NEWCODE
```

## Script Reference

### Main Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `gen_all_reports.py` | Generate all player HTML reports | `./gen_all_reports.py <code>` |
| `gen_player_report.py` | Generate single player HTML report | `./gen_player_report.py <code> <id> <name> <spec> <role>` |

### Supporting Scripts

| Script | Purpose |
|--------|---------|
| `html_templates.py` | HTML generation functions with Wowhead integration |
| `fetch_top_talents_by_boss.py` | Prefetch top performer data |
| `suggestion_generator.py` | Generate suggestions from performance gaps |

---

## Final Output

### Report Folder Structure

```
reports/
├── index.html                    # Master raid list
├── static/style.css              # WoW-themed dark CSS
├── .nojekyll                     # Disable Jekyll processing
└── <date>_<difficulty>_<code>/
    ├── index.html                # Raid summary with player cards
    ├── meta.json                 # Metadata (guild, bosses, players)
    └── players/
        ├── Oldbaldy_fire_mage.html
        ├── Plotarmored_protection_paladin.html
        ├── Nybura_mistweaver_monk.html
        └── ...
```

### Raid Index Contents

- Raid summary (date, difficulty, bosses killed)
- Player cards organized by role (DPS, Tanks, Healers)
- Parse color-coded badges
- WCL log link

### Per-Player Report Contents

Each player file (`players/{Name}_{spec}.html`) contains:

1. **Per-Boss Sections** with:
   - Fight duration
   - Parse percentile (HPS for healers, DPS for DPS/tanks)
   - For healers: both HPS and DPS parse

2. **Ability Comparison vs Top Performers**
   - DPS: damage ability rotation (CPM, uptime)
   - Healers: healing ability rotation + DPS abilities for fistweaving/atonement specs
   - Tanks: active mitigation and defensive abilities

3. **Talent/Glyph Differences** - highlighted when different from top performer

4. **Consumable Audit**
   - Flask: which flask used
   - Food: 300/275/250 stat food tier
   - Pre-pot: used before pull
   - Combat pot: used during fight
   - Engineering: Synapse Springs uses vs expected (for engineers)

5. **Overheal Comparison** (healers only) - your overheal % vs top performer

6. **Auto-Generated Suggestions** - based on performance gaps

---

## Upload to GitHub

Reports are published to GitHub Pages for raid members to access.

**Repository:** https://github.com/glitchv0/raidreview
**Live Site:** https://glitchv0.github.io/raidreview/

### Upload New Report

After running `gen_all_reports.py`:

```bash
git add reports/ index.html
git commit -m "Add raid report: <date> <difficulty>"
git push
```

Reports are automatically deployed to GitHub Pages after push.

### View Reports Online

- **GitHub Pages:** https://glitchv0.github.io/raidreview/
- **Custom Domain:** https://glitchv0.com/raidreview/

---

## Files in This Folder

### Uploaded to GitHub (Published)
| File/Folder | Description |
|-------------|-------------|
| **index.html** | Root index for GitHub Pages |
| **reports/index.html** | Master raid list |
| **reports/static/style.css** | WoW-themed dark CSS |
| **reports/.nojekyll** | Disable Jekyll processing |
| reports/DATE_DIFF_CODE/index.html | Raid summary with player cards |
| reports/DATE_DIFF_CODE/meta.json | Raid metadata |
| reports/DATE_DIFF_CODE/players/*.html | Individual player reports |

### Local Only (not uploaded)
| File | Description |
|------|-------------|
| HOWTO.md | This guide (local reference) |
| gen_all_reports.py | Main HTML report generator |
| gen_player_report.py | Per-player HTML report generator |
| html_templates.py | HTML/Wowhead template functions |
| suggestion_generator.py | Suggestion generation |
| raw/ | Cached API data (gitignored) |

---

## Common Issues

### Token Expired
Error: `{"error":"Unauthenticated"}`
Fix: Refresh token using `bash /home/jeremy/get_token.sh`

### Player ID Not Found
Error: `Unknown argument sourceName`
Fix: Get player ID from masterData.actors first, then use sourceID parameter

### Empty Rankings
The fight might be a wipe (kill: false) or unranked difficulty
Fix: Check fights.kill = true

### Healer Parse Looks Wrong
The default parse includes DPS contribution.
Fix: Calculate HPS manually and compare to top HPS rankings with `metric: hps`

---

## Useful jq Commands

### Extract player names and IDs
```bash
jq '.data.reportData.report.masterData.actors[] | {id, name, subType}'
```

### Get fight list
```bash
jq '.data.reportData.report.fights[] | select(.kill==true) | {id, name, difficulty}'
```

### Get healer rankings (from rankings response)
```bash
jq '.data.reportData.report.rankings.data[0].roles.healers.characters[] | {name, spec, amount, rankPercent}'
```

### Sum healing for a player
```bash
jq '[.data.reportData.report.table.data.entries[].total] | add'
```

### Get healing by ability
```bash
jq '.data.reportData.report.table.data.entries[] | {name: .name, healing: .total, uses: .uses, overheal: .overheal}'
```

---

## Class/Spec Reference (MoP)

### DPS Specs to Watch
| Class | Best Spec | Common Mistake |
|-------|-----------|----------------|
| Death Knight | DW Frost | Playing 2H Frost (-50% DPS) |
| Hunter | Survival | Playing MM |
| Warlock | Destro/Afflic | Not using Shadowburn in execute |
| Warrior | Arms | Overpower spam during CS (should Slam) |
| Shaman | Elemental | Low Lava Burst casts, low Flame Shock uptime |

### Tank Active Mitigation
| Class | Key Ability | Target Uptime |
|-------|-------------|---------------|
| Paladin | Shield of Righteous | 60%+ |
| Monk | Shuffle | 95%+ |
| Warrior | Shield Block | 60%+ |
| DK | Death Strike timing | On demand |
| Druid | Savage Defense | 60%+ |

### Healer Ability Benchmarks (4-5 min fight)

| Class | Key Abilities | Expected |
|-------|---------------|----------|
| Resto Druid | Wild Growth | 34+ casts (8s CD) |
| Resto Druid | Swiftmend | 18+ casts (15s CD) |
| Resto Shaman | Chain Heal | 30+ casts |
| Resto Shaman | Ascendance | 2 uses |
| Holy Paladin | Avenging Wrath | 2 uses |
| Holy Paladin | Divine Favor | 2 uses |
| Disc Priest | Spirit Shell | 2-3 uses |
| Disc Priest | Prayer of Mending | 27+ casts (10s CD) |

### Healer HPS Benchmarks (Jin'rokh 25N)

| Spec | Top HPS | Median HPS | Below 20% Parse |
|------|---------|------------|-----------------|
| Resto Druid | 212k | 141k | <70k |
| Resto Shaman | 215k | 167k | <80k |
| Holy Paladin | 312k | 176k | <100k |
| Disc Priest | 220k | 150k | <80k |

---

## Lessons Learned

1. **Healer combined parse is misleading** - A healer with 78% combined parse can have 10% healing parse if they're DPSing too much

2. **Compare similar kill times** - A 150s kill will have higher DPS/HPS than a 300s kill

3. **Check consumables** - Many players use 0 or 1 potion when they should use 2

4. **Ability counts matter** - Low cast counts indicate rotation issues or downtime

5. **Cooldown tracking** - Most major CDs can be used twice in a 4-5 minute fight

6. **Spec matters** - 2H Frost DK vs DW Frost is a 50%+ DPS difference

---

## Consumable Tracking

Reports automatically detect consumable usage from the WCL buffs table.

### Tracked Consumables

| Category | What's Checked | Expected |
|----------|----------------|----------|
| Flask | MoP flasks (Warm Sun, Spring Blossoms, etc.) | 100% uptime |
| Food | 300/275/250 stat food | Any tier acceptable |
| Pre-pot | Potion used before pull | 1 use |
| Combat pot | Potion used during fight | 1 use |
| Engineering | Synapse Springs | 1 use per minute |

### Food Buff Tiers

| Tier | Examples | Status |
|------|----------|--------|
| 300 | Black Pepper Ribs, Sea Mist Rice Noodles | Best |
| 275 | Eternal Blossom Fish, Chun Tian Spring Rolls | Good |
| 250 | Valley Stir Fry, Sauteed Carrots | Acceptable |

### Engineering Detection

- Synapse Springs are detected from the buffs table (buff ID 96230)
- Expected uses = floor(fight_duration / 60) + 1
- Shows "3 uses" if meeting expected, or "4 of 8 possible uses" if underusing

---

*Last Updated: January 15, 2026*

## Changelog

### 2026-01-15 (HTML + GitHub Pages)
- **NEW: HTML reports** - Replaced Markdown with static HTML
- **NEW: GitHub Pages hosting** - Reports live at https://glitchv0.github.io/raidreview/
- **NEW: Wowhead tooltips** - Spells, talents, glyphs, consumables show tooltips on hover
- **NEW: WoW-themed styling** - Dark background, gold accents, parse colors matching WarcraftLogs
- **NEW: Bootstrap 5** - Responsive layout with card-based design
- **NEW: Master raid index** - Root index.html lists all raids with guild name, boss count, player count
- **NEW: meta.json** - Stores raid metadata for indexing
- **NEW: html_templates.py** - Centralized HTML generation functions
- Parse colors now match WarcraftLogs exactly (tan/pink/orange/purple/blue/green/gray)

### 2026-01-14 (Per-Player Reports)
- **NEW: Per-player report structure** - Each player gets their own file (`players/{Name}_{spec}.html`)
- **NEW: `gen_all_reports.py`** - Single command to generate all reports
- **NEW: Consumable tracking** - Flask, food tiers (300/275/250), potions, engineering gloves
- **NEW: Parse percentiles** - Using correct `playerMetric` parameter (hps for healers, dps for DPS/tanks)
- **NEW: Healer healing rotation** - Compare healing ability usage vs top performers
- **NEW: Overheal comparison** - Compare overheal % vs top healers
- **NEW: Dual parse for healers** - Show both HPS parse and DPS parse
- **NEW: Fight duration** - Shown for each boss section
- Deprecated old combined reports (dps.md, tanks.md, healers.md)

### 2026-01-14 (Earlier)
- Added `gen_rotation_report.py` for dynamic ability discovery (no hardcoded ability lists)
- Added `gen_full_tank_report.py` for complete tank analysis
- Added `gen_full_healer_report.py` for complete healer analysis
- Reports now show full ability names instead of abbreviations
- Fixed raid difficulty detection (10N/25N/10H/25H)
- Standardized tank report filename to `tanks.md`
