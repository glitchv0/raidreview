# Build DPS Report

Generates the final dps.md report with per-boss rotation comparisons vs top performers.

## Usage
```
/build-dps-report <report_code> <raid_date> <raid_size>
```

## Prerequisites
Must have already run:
1. `/fetch-raid-data <report_code>`
2. `/gen-comparisons <report_code>`

## Steps

1. Read `raw/<report_code>/report_info.json` for raid info and player list
2. Query WCL API for rankings data: `table(dataType: DamageDone)` per fight
3. For each DPS player:
   - Get their parse percentiles from rankings
   - Read their comparison table from `raw/<report_code>/comparisons/<name>_comparison.md`
   - Identify key issues (gaps > 30%)
   - Generate suggestions based on patterns

4. Group players by performance tier:
   - Excellent (75%+)
   - Good (50-74%)
   - Average (25-49%)
   - Needs Work (<25%)
   - Critical (<10%)

5. Write final report to `reports/<date>_<size>_<code>/dps.md`

## Report Format

```markdown
# DPS Performance Analysis

**Raid:** [Raid Name]
**Date:** [Date]
**Log:** [link]

## Performance Summary
| Rating | Count | Players |

## [TIER NAME]
### [Player] ([Spec]) - [Avg Parse]%

| Boss | Parse | DPS |
...

#### Per-Boss Rotation Analysis vs Top Performers
| Boss | Ability | You | Top | Gap |
...

**Key Issues:**
- Issue 1
- Issue 2

#### Suggestions
- Suggestion 1
- Suggestion 2
```

## Key Analysis Points

1. **Rotation gaps >30%** = critical issue, bold in table
2. **Consistent low ability** across fights = fundamental rotation problem
3. **Single fight crash** = likely death, check death log
4. **Spec mismatch** (e.g., 2H vs DW Frost) = gear/build issue
5. **Execute abilities low** (Shadowburn, Soul Reaper, etc.) = missing damage phase
