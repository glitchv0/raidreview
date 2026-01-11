# Make Azeroth Great Again - Full Raid Performance Analysis

**Log**: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C
**Raid**: Throne of Thunder 25N | **Bosses**: Jin'rokh through Megaera
**Primary Analysis Fight**: Jin'rokh the Breaker (276 seconds)

---

# EXECUTIVE SUMMARY

| Category | Critical | Needs Work | Good |
|----------|----------|------------|------|
| DPS | 4 players | 5 players | 4 players |
| Tanks | 1 player | 1 player | 0 players |
| Healers | 4 players | 1 player | 0 players |

**Potential Raid DPS Gain: +529,000 DPS** (equivalent to 2-3 extra DPS)
**Potential Raid HPS Gain: +243,000 HPS** (+58% healing output)

---

# PART 1: DPS ANALYSIS

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

# PART 2: TANK ANALYSIS

---

## Xamby (Brewmaster Monk) - 17% Parse

**DPS**: 140k | **ilvl**: 517

| Issue | Current | Expected |
|-------|---------|----------|
| Keg Smash casts | 18 | 35+ (8s CD) |
| Shuffle uptime | 82% | 95%+ |
| Guard uses | 6 | 8-10 |

**Action Items**: Keg Smash on CD, maintain 95% Shuffle, use Guard more

**Expected Improvement**: +30-40% DPS, better survivability

---

## Zegadin (Protection Paladin) - 4% Parse [CRITICAL]

**DPS**: 100k | **ilvl**: 525 (highest in raid!)

| Issue | Current | Expected |
|-------|---------|----------|
| Shield of Righteous uptime | 23% | 60%+ |
| Avenger's Shield casts | 13 | 20+ |

**THIS IS A RAID SURVIVABILITY ISSUE** - 23% SotR uptime means healers are working much harder than necessary.

**Action Items**:
```
1. SHIELD OF RIGHTEOUS: Use at 3 Holy Power, maintain 60%+ uptime
2. AVENGER'S SHIELD: Use on cooldown, watch for Grand Crusader procs
3. ROTATION: CS > J > AS > HW > Cons
```

**Expected Improvement**: +50-70% DPS, significantly better survivability

---

# PART 3: HEALER ANALYSIS (Ranked by HPS)

**IMPORTANT**: Healers are ranked by HEALING output, not combined parse.

---

## HEALER SUMMARY

| Rank | Player | Spec | HPS | Healing Parse | Tier |
|------|--------|------|-----|---------------|------|
| 1 | Mightlive | Holy Paladin | 111k | ~15-20% | CRITICAL |
| 2 | Chaewonsham | Resto Shaman | 101k | ~30-35% | Needs Work |
| 3 | Missypriest | Disc Priest | 89k | ~15-20% | CRITICAL |
| 4 | Poeshammykun | Resto Shaman | 64k | ~10% | CRITICAL |
| 5 | Chubzilla | Resto Druid | 52k | ~5-10% | CRITICAL |

**All 5 healers are below median for their spec.**

**Top Healer HPS Benchmarks (Jin'rokh 25N):**
- Top Resto Druid: 212k | Median: 141k
- Top Holy Paladin: 312k | Median: 176k
- Top Disc Priest: 220k | Median: 150k
- Top Resto Shaman: 215k | Median: 167k

---

## Mightlive (Holy Paladin) - 111k HPS - CRITICAL

**Healing Parse**: ~15-20% | **Total Healing**: 30.7M

Despite highest raw HPS, still well below median (176k).

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Illuminated Healing | 11.4M | - | 6% |
| Light of Dawn | 5.5M | 40 | 57% |
| Holy Radiance | 3.1M | 37 | 53% |
| Eternal Flame | 2.3M | 17 | 58% |
| Holy Shock | 1.8M | 45 | 62% |

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Avenging Wrath | 1 | 2 | **MISSING 2nd** |
| Divine Favor | 1 | 2 | **MISSING 2nd** |
| Potion | 0 | 2 | **NO POTIONS** |

**Action Items**:
```
1. AVENGING WRATH: Use twice (pull + ~3 min)
2. DIVINE FAVOR: Use twice
3. USE POTIONS
4. ETERNAL FLAME: Blanket more targets
5. REDUCE OVERHEAL: Target low-health players
```

**Expected Improvement**: 111k → 160k+ HPS (+44%)

---

## Chaewonsham (Resto Shaman) - 101k HPS - Needs Improvement

**Healing Parse**: ~30-35% | **Total Healing**: 28.0M

Best healer by parse, but still below median (167k).

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Healing Rain | 9.4M | 7 | 66% |
| Healing Tide | 5.3M | 1 | 17% |
| Chain Heal | 4.6M | 33 | 32% |
| Healing Stream | 4.2M | 14 | 25% |

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Ascendance | 1 | 2 | **MISSING 2nd** |
| Mana Tide | 0 | 1-2 | **NOT USED** |

**Action Items**:
```
1. ASCENDANCE: Use twice
2. HEALING RAIN: Better positioning (66% overheal)
3. MANA TIDE: Use for mana return
```

**Expected Improvement**: 101k → 140k+ HPS (+39%)

---

## Missypriest (Disc Priest) - 89k HPS - CRITICAL

**Healing Parse**: ~15-20% | **Total Healing**: 24.7M | **DPS**: 45k (good)

High DPS from Atonement but healing output is low.

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Divine Aegis | 6.9M | - | 37% |
| Power Word: Shield | 5.4M | 39 | 16% |
| Halo | 4.1M | 6 | 81% |
| Atonement | 5.3M | - | ~20% |
| Prayer of Mending | 0.8M | 6 | 12% |

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Archangel | 8 | 8+ | Good! |
| Spirit Shell | 0 | 2-3 | **NOT USED - CRITICAL** |
| Potion | 1 | 2 | Single pot |

**Critical Issue**: Zero Spirit Shell usage. This is Disc's biggest throughput CD (15s of absorb conversion).

**Action Items**:
```
1. SPIRIT SHELL: Use before Ionization - CRITICAL
2. PRAYER OF MENDING: Cast on CD (10s CD = 27+ casts)
3. HALO TIMING: Use BEFORE damage (81% overheal = bad timing)
4. DOUBLE POT
```

**Expected Improvement**: 89k → 140k+ HPS (+57%)

---

## Poeshammykun (Resto Shaman) - 64k HPS - CRITICAL

**Healing Parse**: ~10% | **Total Healing**: 17.7M | **DPS**: 31k

High DPS but at cost of healing. Same spec/ilvl as Chaewonsham but 37% less healing.

#### Comparison to Chaewonsham

| Metric | Poeshammykun | Chaewonsham | Difference |
|--------|--------------|-------------|------------|
| Total Healing | 17.7M | 28.0M | **-37%** |
| HPS | 64k | 101k | **-37%** |
| DPS | 31k | 17k | +82% |
| Chain Heal casts | 12 | 33 | **-64%** |

**Problem**: DPSing too much, not healing enough.

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Healing Rain | 6.4M | 10 | 77% |
| Healing Tide | 4.7M | 1 | 16% |
| Chain Heal | 0.7M | 12 | 59% |
| Riptide | 0.5M | 7 | 56% |

**Action Items**:
```
1. MORE CHAIN HEAL: 12 is way too low, aim for 30+
2. LESS DPS: Healing comes first
3. ASCENDANCE: Use twice
4. HEALING RAIN: Better positioning (77% overheal)
```

**Expected Improvement**: 64k → 100k+ HPS (+56%)

---

## Chubzilla (Resto Druid) - 52k HPS - CRITICAL

**Healing Parse**: ~5-10% | **Total Healing**: 14.4M | **DPS**: 0

Lowest healer by a significant margin. Critical rotation issues.

| Ability | Healing | Uses | Expected | Issue |
|---------|---------|------|----------|-------|
| Rejuvenation | 5.4M | 70 | - | OK |
| Wild Growth | 2.8M | 12 | 34+ | **CRITICAL** |
| Efflorescence | 2.4M | - | - | OK |
| Wild Mushroom | 1.7M | 2 | 10+ | Very low |
| Swiftmend | 0.1M | 7 | 18+ | Very low |

**Critical Issue**: Only 12 Wild Growth casts. WG is 8s CD = should be 34+ casts in 276s.
- Current: 1 WG every 23 seconds
- Expected: 1 WG every 8 seconds
- **Missing 22+ Wild Growth casts = millions of missing healing**

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Tranquility | 1 | 1 | OK |
| Incarnation | 0 | 1-2 | **NOT USED** |
| Nature's Vigil | 0 | 2 | **NOT USED** |

**Action Items**:
```
1. WILD GROWTH: Use on cooldown (8s CD) - THIS IS CRITICAL
2. SWIFTMEND: Use on cooldown (15s CD)
3. WILD MUSHROOM: Place and bloom more
4. INCARNATION: Use for burst healing
5. NATURE'S VIGIL: Use for healing + damage
6. DPS: Wrath during low damage phases (currently 0 DPS)
```

**Expected Improvement**: 52k → 120k+ HPS (+130%)

---

## HEALER POTENTIAL GAIN

| Player | Current HPS | Target HPS | Gain |
|--------|-------------|------------|------|
| Chubzilla | 52k | 120k+ | +68k (+130%) |
| Poeshammykun | 64k | 100k+ | +36k (+56%) |
| Missypriest | 89k | 140k+ | +51k (+57%) |
| Chaewonsham | 101k | 140k+ | +39k (+39%) |
| Mightlive | 111k | 160k+ | +49k (+44%) |
| **TOTAL** | **417k** | **660k+** | **+243k (+58%)** |

---

# PART 4: CONSUMABLES AUDIT

| Status | Players |
|--------|---------|
| **ZERO POTS** | Vaelindra, Bonessenpai, Stassie, Mightlive |
| Single Pot | Lockycharmzs, Sertotems, Unsanctioned, Boviden, Missypriest |
| Double Pot | Rentagar |

**Double potting provides 5-8% free DPS/HPS!**

### How to Double Pot

```
1. PRE-POT: Use potion 1 second before pull timer hits 0
2. SECOND POT: Use during Bloodlust/Heroism OR execute phase
3. TIMING: Stack with major cooldowns for maximum value
```

---

# PART 5: RAID-WIDE IMPACT

## Potential DPS Gain

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

**That's equivalent to adding 2-3 extra DPS players.**

---

## Priority Action List

### THIS WEEK (Before Next Raid)

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 1 | Bonessenpai | Get 2x 1H weapons for DW Frost | +70k DPS |
| 2 | Vaelindra | Respec to Survival Hunter | +100k DPS |
| 3 | Everyone | Double pot every pull | +5-8% each |
| 4 | Lockycharmzs | Learn Shadowburn execute | +90k DPS |
| 5 | Chubzilla | Wild Growth every 8 seconds | +130% HPS |

### NEXT RAID

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 6 | Zegadin | 60%+ Shield of Righteous uptime | Tank survival |
| 7 | Poeshammykun | More Chain Heal, less DPS | +56% HPS |
| 8 | Missypriest | Spirit Shell before Ionization | +57% HPS |
| 9 | Mightlive | AW + DF twice, use potions | +44% HPS |
| 10 | Sertotems | ABC - Always Be Casting | +150% DPS |

---

## Tank Survivability Note

Zegadin's 23% SotR uptime means healers are working harder than necessary. Fixing tank mitigation will:
- Reduce healer mana usage
- Allow healers to focus on raid instead of tank
- Reduce risk of tank deaths

---

# APPENDIX: FIGHT MECHANICS

## Jin'rokh the Breaker

| Mechanic | What to Do |
|----------|------------|
| Conductive Waters | Stand in pools for +damage buff |
| Ionization | Spread out, healer CD here |
| Thundering Throw | Tank swap, creates pool |
| Focused Lightning | Run away from raid |

**Healer CDs for Ionization**: Spirit Shell, Tranquility, Healing Tide, Spirit Link

---

*Analysis generated from Warcraft Logs API*
*Fight: Jin'rokh 25N (276s)*
*Log: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C*
