# Tank Performance Analysis

**Log**: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C
**Fight**: Jin'rokh 25N (276 seconds)

---

## TANK SUMMARY

| Player | Spec | Parse | ilvl | DPS | Main Issue |
|--------|------|-------|------|-----|------------|
| Xamby | Brewmaster Monk | 17% | 517 | 140k | Low Keg Smash, 82% Shuffle |
| Zegadin | Protection Paladin | 4% | 525 | 100k | **23% SotR uptime - CRITICAL** |

---

## Xamby (Brewmaster Monk) - 17% Parse

**DPS**: 140k | **ilvl**: 517 | **Fight**: 276s

### Damage Breakdown

| Ability | Damage | Casts | Notes |
|---------|--------|-------|-------|
| Niuzao (Statue) | 9.2M | 1 | Good usage |
| Melee | 8.4M | 217 | OK |
| Blackout Kick | 6.7M | 39 | OK |
| Chi Wave | 4.6M | 12 | Good |
| Tiger Palm | 4.2M | 74 | OK |
| Keg Smash | 3.2M | 18 | **Low - should be 35+** |
| Jab | 1.3M | 48 | Filler |
| **Total** | **38.8M** | - | - |

### Defensive Cooldown Usage

| Ability | Uptime | Uses | Expected | Assessment |
|---------|--------|------|----------|------------|
| Shuffle | 82% (227s) | 8 | 95%+ | **Could be higher** |
| Guard | 26% (73s) | 6 | 8-10 | **Low usage** |
| Fortifying Brew | 7% (20s) | 1 | 1-2 | OK |

### Issues Identified

1. **Low Keg Smash Casts**: 18 casts in 276s = 1 every 15.3s. Keg Smash is 8s CD, should be ~35 casts.

2. **Shuffle Uptime 82%**: Should be 95%+. Every Blackout Kick and Keg Smash extends Shuffle. Missing uptime = taking more damage.

3. **Guard Underused**: 6 uses in 276s = 1 every 46s. Guard is 30s CD, should be used more often.

### Comparison to Top Brewmaster

| Metric | Xamby | Top 5 Avg | Difference |
|--------|-------|-----------|------------|
| DPS | 140k | 342k | -59% |
| Fight Length | 276s | 159s | +74% longer |
| Expected DPS (adjusted) | ~200k | - | Still -30% low |

### Action Items

```
1. KEG SMASH ON CD: 8 second cooldown, should be ~35 casts in 276s
2. SHUFFLE UPTIME: Target 95%+, never let it drop
3. GUARD MORE: Use on cooldown for damage smoothing
4. ELUSIVE BREW: Track uptime, should be high
5. EXPEL HARM: Use for energy generation + healing
```

**Expected Improvement**: +30-40% DPS, better survivability

---

## Zegadin (Protection Paladin) - 4% Parse [CRITICAL]

**DPS**: 100k | **ilvl**: 525 (highest in raid!) | **Fight**: 276s

### Damage Breakdown

| Ability | Damage | Casts | Notes |
|---------|--------|-------|-------|
| Judgment | 6.9M | 52 | OK |
| Melee | 5.2M | 154 | OK |
| Consecration | 3.1M | 21 | OK |
| Holy Wrath | 2.9M | 15 | OK |
| Shield of the Righteous | 2.9M | 21 | **Low - should be 30+** |
| Avenger's Shield | 2.8M | 13 | **Low - should be 20+** |
| Crusader Strike | 2.1M | 48 | OK |
| Hammer of Wrath | 1.4M | 8 | Execute phase |
| **Total** | **27.8M** | - | - |

### Defensive Cooldown Usage

| Ability | Uptime | Uses | Assessment |
|---------|--------|------|------------|
| Shield of the Righteous | **23%** (63s) | 15 | **CRITICAL - target 60%+** |
| Sacred Shield | 67% (186s) | 10 | OK |
| Divine Protection | 11% (30s) | 3 | OK |
| Alabaster Shield | 43% (119s) | 22 | OK |

### Issues Identified

1. **Shield of the Righteous Uptime 23%**: This is critically low. SotR is your main active mitigation, should have 60%+ uptime. Only 21 casts in 276s = 1 every 13s. Should be using on cooldown with 3 Holy Power.

2. **Low Avenger's Shield Usage**: 13 casts in 276s = 1 every 21s. AS is 15s CD (reset by Grand Crusader procs), should be 20+ casts.

3. **4% Parse Despite ilvl 525**: This is the highest ilvl tank but the lowest parse. Indicates serious rotation/mitigation issues.

### Comparison to Top Prot Paladin

| Metric | Zegadin | Top 5 Avg | Difference |
|--------|---------|-----------|------------|
| DPS | 100k | 365k | -73% |
| ilvl | 525 | ~530 | Similar |
| SotR uptime | 23% | 60%+ | **-37%** |

### Action Items

```
1. SHIELD OF THE RIGHTEOUS: Use at 3 Holy Power, maintain 60%+ uptime
2. AVENGER'S SHIELD: Use on cooldown, watch for Grand Crusader procs
3. ROTATION: CS > J > AS > HW > Cons (priority for HP generation)
4. HOLY POWER: Never cap, spend at 3-5 on SotR
5. DIVINE PROTECTION: Use more liberally for magic damage
```

**Expected Improvement**: +50-70% DPS, significantly better survivability

---

## RAID SURVIVABILITY IMPACT

**Zegadin's 23% SotR uptime is a raid-wide issue:**

- Healers are working harder than necessary to keep tank alive
- Higher healer mana usage
- Less healer attention available for raid
- Increased risk of tank deaths on high damage phases

Fixing tank mitigation will indirectly improve healer performance and raid stability.

---

## TANK PRIORITY ACTION LIST

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 1 | Zegadin | 60%+ Shield of Righteous uptime | **Tank survival + healer relief** |
| 2 | Zegadin | Avenger's Shield on CD | +30% DPS |
| 3 | Xamby | Keg Smash every 8 seconds | +20% DPS |
| 4 | Xamby | 95%+ Shuffle uptime | Better survivability |
| 5 | Both | Use defensive CDs proactively | Smoother damage intake |

---

## TANK ACTIVE MITIGATION REFERENCE

| Class | Key Ability | Target Uptime | Notes |
|-------|-------------|---------------|-------|
| Paladin | Shield of the Righteous | 60%+ | Physical DR |
| Monk | Shuffle | 95%+ | Parry + Stagger |
| Warrior | Shield Block | 60%+ | Block chance |
| DK | Death Strike | On demand | Self-healing |
| Druid | Savage Defense | 60%+ | Dodge |

---

*Analysis generated from Warcraft Logs API*
*Fight: Jin'rokh 25N (276s)*
