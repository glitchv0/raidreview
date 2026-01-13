# Fetch Raid Data

Fetches all data needed for raid analysis from Warcraft Logs API.

## Usage
```
/fetch-raid-data <report_code>
```

## Steps

1. Run `./fetch_report_players.sh <report_code>` to get player list and fight info
2. Run `./fetch_player_casts.sh <report_code>` to get cast data per fight
3. Run `./fetch_all_top_performers.sh <report_code>` to get top performer comparison data

## Output
- `raw/<report_code>/report_info.json` - fights and player list
- `raw/<report_code>/casts_by_fight/` - cast data per boss
- `raw/<report_code>/top_performers_by_boss/` - top performer data per spec

## Example
```
/fetch-raid-data DkgR89WBa47FJd1C
```
