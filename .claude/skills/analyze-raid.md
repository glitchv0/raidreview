# Analyze Raid (Full Pipeline)

Complete raid analysis pipeline - fetches data, generates comparisons, and builds final report.

## Usage
```
/analyze-raid <report_code> <raid_date> <raid_size>
```

Example:
```
/analyze-raid DkgR89WBa47FJd1C 2026-01-10 25M
```

## Pipeline

### Step 1: Fetch Data
```bash
./fetch_report_players.sh <report_code>
./fetch_player_casts.sh <report_code>
./fetch_all_top_performers.sh <report_code>
```

### Step 2: Generate Comparisons
For each DPS player in `raw/<report_code>/report_info.json`:
```bash
./gen_comparison_table.sh <player_id> <spec_key> <report_code>
```

### Step 3: Build Report
1. Read all comparison tables from `raw/<report_code>/comparisons/`
2. Query rankings for parse percentiles
3. Analyze patterns and generate suggestions
4. Write `reports/<date>_<size>_<code>/dps.md`

### Step 4: Upload
```bash
git add reports/<date>_<size>_<code>/dps.md
git commit -m "Add/update DPS analysis for <date> <size>"
git push origin main
```

## Output Files
- `raw/<report_code>/` - all raw API data (gitignored)
- `reports/<date>_<size>_<code>/dps.md` - final report (committed)

## Notes
- Top performer data is cached - won't re-fetch if already exists
- Same encounter IDs work for all Throne of Thunder raids
- Different raids may need different encounter ID mappings
