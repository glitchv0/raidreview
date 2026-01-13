# Generate Comparison Tables

Generates per-boss rotation comparison tables for all DPS players.

## Usage
```
/gen-comparisons <report_code>
```

## Prerequisites
Must have already run `/fetch-raid-data <report_code>` first.

## Steps

1. Read `raw/<report_code>/report_info.json` to get player list
2. For each DPS player (exclude healers/tanks):
   - Determine their spec from subType
   - Run `./gen_comparison_table.sh <player_id> <spec_key> <report_code>`
   - Save to `raw/<report_code>/comparisons/<player_name>_comparison.md`

## Spec Mapping
- Shadow → shadow_priest
- Arms → arms_warrior
- Fury → fury_warrior
- Frost (DK) → frost_dk
- Survival → survival_hunter
- BeastMastery → bm_hunter
- Destruction → destro_warlock
- Demonology → demo_warlock
- Elemental → elemental_shaman
- Enhancement → enhance_shaman
- Fire → fire_mage
- Subtlety → subtlety_rogue
- Retribution → ret_paladin
- Balance → balance_druid
- Feral → feral_druid

## Output
- `raw/<report_code>/comparisons/*.md` - comparison table per player
