# DPS Performance Analysis

**Log**: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C
**Fight**: Jin'rokh 25N (276 seconds)

---

## DPS SUMMARY

| Tier | Count | Players |
|------|-------|---------|
| Critical (<15%) | 4 | Lockycharmzs, Sertotems, Vaelindra, Bonessenpai |
| Needs Work (15-40%) | 5 | Unsanctioned, Nybszerk, Boviden, Stassie, Rentagar |
| Good (40%+) | 4 | Kamaprayer, Zolranth, Tpump, Sahvahanna |

**Potential Raid DPS Gain: +529,000 DPS** (equivalent to 2-3 extra DPS players)

---

## TIER 1: CRITICAL DPS ISSUES

---

### Lockycharmzs (Destruction Warlock) - 3% Parse

**DPS**: 111k | **ilvl**: 521 | **Fight**: 276s

#### Damage Breakdown vs Top Destro Lock (Lomes - 199k, 275s, ilvl 513)

| Ability | Lockycharmzs | Lomes | Difference |
|---------|--------------|-------|------------|
| Incinerate | 61 casts (9.6M) | 111 casts (22M) | **-45% casts** |
| Chaos Bolt | 9 casts (9M) | 12 casts (13.6M) | **-25% casts** |
| Conflagrate | 13 casts (2.1M) | 20 casts (4M) | **-35% casts** |
| Immolate | 14 casts (4.6M) | 18 casts (8.1M) | Less uptime |
| Shadowburn | **0 casts (0)** | 7 casts (6.4M) | **Missing 6.4M damage!** |
| **Total** | **30.6M** | **54.8M** | **-44%** |

#### Cooldown & Consumable Usage

| Buff | Lockycharmzs | Lomes | Issue |
|------|--------------|-------|-------|
| Potion | 1 use (25s) | 2 uses (49s) | **Missing pre-pot** |
| Dark Soul | 1 use (20s) | 2 uses (40s) | **Missing 2nd cast** |
| Backdraft | 28% uptime (77s) | 41% uptime (112s) | **-13% uptime** |

#### Root Cause Analysis

1. **Not Using Shadowburn (Execute)**: Missing 6.4M damage. Shadowburn is a massive execute ability that should be spammed below 20% HP. Lockycharmzs has 0 casts.

2. **Half the Incinerates**: 61 vs 111 casts means severe downtime or GCD waste.

3. **Poor Conflagrate Usage**: 13 vs 20 casts. Should be used on cooldown for Backdraft + Ember generation.

4. **Single Potting**: Only 1 pot vs 2. Missing 5-8% DPS.

5. **Only 1 Dark Soul**: Should use twice in a 276s fight.

#### Action Items

```
1. SHADOWBURN: Spam below 20% HP
2. CONFLAGRATE: Use on cooldown
3. INCINERATE: Fill every GCD
4. DARK SOUL: Use twice (pull + 2min)
5. DOUBLE POT: Pre-pot + during lust
```

**Expected Improvement**: +80-90% DPS (111k → 200k+)

---

### Sertotems (Elemental Shaman) - 0% Parse

**DPS**: 58k | **ilvl**: 508 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Expected | Issue |
|---------|-------|--------|----------|-------|
| Lava Burst | 22 | 6.6M | 35-40+ | **-40% casts** |
| Lightning Bolt | 26 | 2.3M | 60+ | **-55% casts** |
| Flame Shock | 4 | 1.2M | 8-10 | **Poor uptime** |
| Earth Shock | 4 | 0.3M | 8+ | **Wasting stacks** |
| Fire Elemental | - | 2.3M | 3M+ | OK |
| **Total** | - | **16M** | 35M+ | **-54%** |

#### Root Cause Analysis

1. **Massive Downtime**: Only 22 Lava Bursts and 26 Lightning Bolts in 276s is impossibly low.
2. **Poor Flame Shock Uptime**: Only 4 casts = ~50% uptime. Should be 95%+.
3. **Only 1 Ascendance**: Missing half the damage from biggest cooldown.

#### Action Items

```
1. FLAME SHOCK: Keep up 95%+ uptime
2. LAVA BURST: Use on cooldown
3. EARTH SHOCK: At 7 Lightning Shield stacks
4. LIGHTNING BOLT: Filler
5. ASCENDANCE: Use twice
```

**Expected Improvement**: +150-200% DPS (58k → 150k+)

---

### Vaelindra (Marksmanship Hunter) - 0% Parse

**DPS**: 83k | **ilvl**: 498 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Expected | Issue |
|---------|-------|--------|----------|-------|
| Aimed Shot | 12 | 3.9M | 30+ | **-60% casts** |
| Chimaera Shot | 10 | 3.7M | 28+ | **-64% casts** |
| Steady Shot | 32 | 1.2M | 80+ | **-60% casts** |
| Auto Shot | 37 | 1.7M | 100+ | **-63% shots** |
| Stampede | 1 | 4.5M | - | OK |

#### Root Cause Analysis

1. **Zero Potions**: No potions used at all.
2. **Massive Downtime**: All ability counts are ~60% lower than expected.
3. **Only 1 Rapid Fire**: Should be used twice.
4. **Wrong Spec**: MM is significantly weaker than Survival in ToT.

#### Action Items

```
1. RESPEC SURVIVAL: +20-30% DPS alone
2. USE POTIONS: Pre-pot + second pot
3. RAPID FIRE: Use on cooldown
4. STAY IN RANGE: Auto Shot should be 100+
5. ABC: Always Be Casting
```

**Expected Improvement**: +120-150% DPS (83k → 180k+)

---

### Bonessenpai (Frost Death Knight) - 9% Parse

**DPS**: 130k | **ilvl**: 519 | **Fight**: 276s

#### The Problem: 2H vs Dual-Wield

| Metric | Bonessenpai (2H) | Top 10 DK (DW) |
|--------|------------------|----------------|
| Melee swings/sec | 0.38 | 1.53 |
| Killing Machine procs/sec | 0.14 | 0.31 |
| Frost Strike OH damage | 0 | 6.0M |
| Total DPS | 130k | 340k+ |

#### Why DW is Superior

1. **More Killing Machine Procs**: DW gets 2.2x more KM procs
2. **Off-Hand Damage**: Every Frost Strike hits with off-hand (+6-7M damage)
3. **Better Runic Power Generation**: More melee = more RP = more Frost Strikes
4. **Razorice Stacking**: Two weapons = faster stacks

#### Action Items

```
1. GET TWO 1H WEAPONS: 2.6 speed slow weapons
2. ENCHANT: Fallen Crusader MH, Razorice OH
3. DOUBLE POT: Pre-pot + during Pillar of Frost
4. ROTATION: Same priority, just faster
```

**Expected Improvement**: +50-70% DPS (130k → 200k+)

---

## TIER 2: NEEDS IMPROVEMENT

---

### Unsanctioned (Elemental Shaman) - 7% ST / 98% Cleave

**DPS**: 125k | **ilvl**: 511

Excels at cleave (98% on Council) but struggles on single target. Missing second Ascendance and double pot.

**Action Items**: Ascendance x2, double pot, better Flame Shock uptime

**Expected Improvement**: +40-50% DPS (125k → 175k+)

---

### Nybszerk (Arms Warrior) - 6% ST / 89% Cleave

**DPS**: 115k | **ilvl**: 516

Spamming Overpower during Colossus Smash instead of Slam. 28 Slams vs 55+ expected.

**Action Items**: Slam during CS windows, pool rage before CS, Execute spam below 20%

**Expected Improvement**: +40-50% DPS (115k → 165k+)

---

### Boviden (Arms Warrior) - 28% Parse

**DPS**: 174k | **ilvl**: 517

Good Slam usage (55 casts) but single potting and low Execute usage.

**Action Items**: Double pot, Execute spam below 20%

**Expected Improvement**: +20-30% DPS (174k → 210k+)

---

### Stassie (Survival Hunter) - 7% Parse

**DPS**: 155k | **ilvl**: 513

Rotation is mostly fine but **ZERO POTIONS**.

**Action Items**: Use potions (pre-pot + second)

**Expected Improvement**: +30-40% DPS (155k → 200k+)

---

### Rentagar (Elemental Shaman) - 15% Parse

**DPS**: 152k | **ilvl**: 506

**Doing everything right!** Low parse is purely due to ilvl 506 vs average 520+. This is a gear problem, not skill.

**Action Items**: Upgrade gear (especially weapon)

---

## GOOD DPS PERFORMERS

| Player | Spec | Parse | Notes |
|--------|------|-------|-------|
| Kamaprayer | Shadow Priest | 86% | Excellent |
| Zolranth | Ret Paladin | 75% | Solid |
| Tpump | Sub Rogue | 60% | Good |
| Sahvahanna | Destro Lock | 60% | Decent |

---

## CONSUMABLES AUDIT

| Status | Players |
|--------|---------|
| **ZERO POTS** | Vaelindra, Bonessenpai, Stassie |
| Single Pot | Lockycharmzs, Sertotems, Unsanctioned, Boviden |
| Double Pot | Rentagar |

**Double potting provides 5-8% free DPS!**

### How to Double Pot

```
1. PRE-POT: Use potion 1 second before pull timer hits 0
2. SECOND POT: Use during Bloodlust/Heroism OR execute phase
3. TIMING: Stack with major cooldowns for maximum value
```

---

## POTENTIAL DPS GAIN

| Player | Current | Potential | Gain |
|--------|---------|-----------|------|
| Vaelindra | 83k | 180k | +97k |
| Sertotems | 58k | 150k | +92k |
| Lockycharmzs | 111k | 200k | +89k |
| Bonessenpai | 130k | 200k | +70k |
| Nybszerk | 115k | 165k | +50k |
| Unsanctioned | 125k | 175k | +50k |
| Stassie | 155k | 200k | +45k |
| Boviden | 174k | 210k | +36k |
| **TOTAL** | - | - | **+529k DPS** |

---

## PRIORITY ACTION LIST

### THIS WEEK (Before Next Raid)

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 1 | Bonessenpai | Get 2x 1H weapons for DW Frost | +70k DPS |
| 2 | Vaelindra | Respec to Survival Hunter | +100k DPS |
| 3 | Everyone | Double pot every pull | +5-8% each |
| 4 | Lockycharmzs | Learn Shadowburn execute | +90k DPS |

### NEXT RAID

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 5 | Sertotems | ABC - Always Be Casting | +150% DPS |
| 6 | Nybszerk | Slam during CS windows | +50% DPS |
| 7 | Unsanctioned | Ascendance x2 | +40% DPS |

---

*Analysis generated from Warcraft Logs API*
*Fight: Jin'rokh 25N (276s)*
