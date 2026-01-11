# Make Azeroth Great Again - Full Raid Performance Analysis

**Log**: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C
**Raid**: Throne of Thunder 25N | **Bosses**: Jin'rokh through Megaera
**Primary Analysis Fight**: Jin'rokh the Breaker (276 seconds)

---

# EXECUTIVE SUMMARY

| Category | Critical | Needs Work | Good |
|----------|----------|------------|------|
| DPS | 4 players | 5 players | 5 players |
| Tanks | 1 player | 1 player | 0 players |
| Healers | 3 players | 1 player | 2 players |

**Potential Raid DPS Gain if fixes are made: +493,000 DPS** (equivalent to adding 2 extra DPS players)

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

2. **Half the Incinerates**: 61 vs 111 casts means severe downtime or GCD waste. Either standing still doing nothing, or wasting GCDs on wrong abilities.

3. **Poor Conflagrate Usage**: 13 vs 20 casts. Conflagrate should be used on cooldown to:
   - Generate Backdraft stacks
   - Generate Burning Embers for Chaos Bolt

4. **Single Potting**: Only 1 pot vs 2. Missing 5-8% DPS.

5. **Only 1 Dark Soul**: 20s uptime vs 40s. Dark Soul: Instability has a 2 min CD, should use twice in a 276s fight.

#### Action Items

```
1. SHADOWBURN: Spam Shadowburn below 20% HP (costs 1 Burning Ember, refunds if kills)
2. CONFLAGRATE: Use on cooldown for Backdraft + Ember generation
3. INCINERATE: Fill every GCD with Incinerate when not doing above
4. DARK SOUL: Use on pull + at ~2:00 mark (stack with Bloodlust if possible)
5. DOUBLE POT: Pre-pot before pull, 2nd pot during Bloodlust/execute
6. BACKDRAFT: Always cast Incinerate/Chaos Bolt during Backdraft
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

#### Cooldown & Consumable Usage

| Buff | Uses | Expected | Issue |
|------|------|----------|-------|
| Ascendance | 1 (15s) | 2 (30s) | **Missing 2nd use** |
| Potion | 1 (25s) | 2 (50s) | **Single pot** |

#### Root Cause Analysis

1. **Massive Downtime**: Only 22 Lava Bursts and 26 Lightning Bolts in 276s is impossibly low. Either:
   - Dead for significant portion of fight
   - Standing around not casting
   - Severe connectivity/lag issues

2. **Poor Flame Shock Uptime**: Only 4 casts means ~50% uptime max. Flame Shock should be 95%+ uptime - it's required for Lava Burst to crit.

3. **Only 1 Ascendance**: Missing half the damage from your biggest cooldown.

#### Ele Shaman Rotation Priority

```
1. FLAME SHOCK: Keep up at all times (95%+ uptime)
2. LAVA BURST: Use on cooldown (always crits with Flame Shock up)
3. EARTH SHOCK: Use at 7 Lightning Shield stacks (Fulmination)
4. LIGHTNING BOLT: Filler between Lava Bursts
5. ASCENDANCE: Use on pull, again at ~3 min
6. FIRE ELEMENTAL: Use on pull with cooldowns
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
| **Total** | - | **23M** | 45M+ | **-49%** |

#### Cooldown & Consumable Usage

| Buff | Uses | Expected | Issue |
|------|------|----------|-------|
| Rapid Fire | 1 (15s) | 2-3 (45s) | **Missing 1-2 casts** |
| Potion | **0** | 2 | **NO POTIONS** |

#### Root Cause Analysis

1. **Zero Potions**: Vaelindra used no potions at all. This is inexcusable.

2. **Massive Downtime**: All ability counts are ~60% lower than expected. This suggests:
   - Dead for large portion of fight
   - Standing far away not auto-attacking
   - Severe movement/positioning issues

3. **Only 1 Rapid Fire**: 2-minute CD, should be used twice in 276s.

4. **Wrong Spec**: Marksmanship is significantly weaker than Survival in MoP ToT. Even with perfect play, MM will parse lower.

#### Why Switch to Survival?

| Factor | MM | Survival |
|--------|-----|----------|
| Execute | Weak | Kill Shot spam |
| AoE | Poor | Excellent |
| Mobility | Must stand still | Mobile |
| Scaling | Mediocre | Excellent |

#### Action Items

```
1. RESPEC SURVIVAL: This alone is +20-30% DPS
2. USE POTIONS: Pre-pot + second pot
3. RAPID FIRE: Use on cooldown (or save for Bloodlust)
4. STAY IN RANGE: Auto Shot should be 100+ in 276s
5. ABC (Always Be Casting): No empty GCDs
```

**Expected Improvement**: +120-150% DPS with spec change (83k → 180k+)

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

1. **More Killing Machine Procs**: DW gets 2.2x more KM procs due to faster swing speed
2. **Off-Hand Damage**: Every Frost Strike hits with off-hand too (+6-7M damage)
3. **Better Runic Power Generation**: More melee = more RP = more Frost Strikes
4. **Razorice Stacking**: Two weapons = faster Razorice stacks

#### Ability Comparison

| Ability | Bonessenpai | Top DK | Difference |
|---------|-------------|--------|------------|
| Frost Strike | 63 casts | 85 casts | -26% |
| Obliterate | 38 casts | 45 casts | -15% |
| Howling Blast | 31 casts | 40 casts | -23% |
| Off-Hand damage | **0** | 7.4M | **Missing entirely** |

#### Consumables

| Item | Uses | Issue |
|------|------|-------|
| Potion | **0** | **NO POTIONS** |

#### Action Items

```
1. GET TWO 1H WEAPONS: 2.6 speed slow weapons (NOT daggers)
2. ENCHANT: Fallen Crusader MH, Razorice OH
3. DOUBLE POT: Pre-pot + pot during Pillar of Frost
4. ROTATION: Same priority, just faster
5. STAT PRIORITY: Same as 2H
```

**Expected Improvement**: +50-70% DPS (130k → 200k+)

---

## TIER 2: NEEDS IMPROVEMENT

---

### Unsanctioned (Elemental Shaman) - 7% ST / 98% Cleave

**DPS**: 125k | **ilvl**: 511 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Notes |
|---------|-------|--------|-------|
| Lava Burst | 33 | 11.5M | OK but could be higher |
| Lightning Bolt | 70 | 9.4M | OK |
| Flame Shock | 7 | 1.8M | **Low uptime** |
| Fire Elemental | 1 | 1.1M | **Low damage** |

#### Cooldown Usage

| Buff | Uses | Expected | Issue |
|------|------|----------|-------|
| Ascendance | 1 (15s) | 2 (30s) | **Missing 2nd use** |
| Potion | 1 (25s) | 2 (50s) | **Single pot** |

#### Why 98% on Council but 7% on Jin'rokh?

Unsanctioned excels at cleave fights because Chain Lightning/Earthquake shine on multiple targets. ST requires tighter rotation execution.

#### Action Items

```
1. ASCENDANCE: Use twice (pull + ~3 min)
2. DOUBLE POT: Pre-pot + second pot
3. FLAME SHOCK: Better uptime (95%+)
4. FIRE ELEMENTAL: Ensure full duration + buff stacking
```

**Expected Improvement**: +40-50% DPS (125k → 175k+)

---

### Nybszerk (Arms Warrior) - 6% ST / 89% Cleave

**DPS**: 115k | **ilvl**: 516 | **Fight**: 276s

#### The Problem: Colossus Smash Windows

During Colossus Smash (6 seconds of +100% armor pen), priority should be:
1. **Slam** (high damage)
2. Mortal Strike
3. Overpower (only if nothing else)

Nybszerk was spamming Overpower during CS instead of Slam.

#### Comparison

| Metric | Nybszerk | Top Arms |
|--------|----------|----------|
| Slam casts | 28 | 55+ |
| Overpower casts | 67 | 40 |
| CS window efficiency | Low | High |

#### Action Items

```
1. SLAM DURING CS: Prioritize Slam over Overpower in CS window
2. DOUBLE POT: Check potion usage
3. EXECUTE PHASE: Spam Execute below 20%
4. SAVE RAGE: Pool rage before CS window
```

**Expected Improvement**: +40-50% DPS (115k → 165k+)

---

### Boviden (Arms Warrior) - 28% Parse

**DPS**: 174k | **ilvl**: 517 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Notes |
|---------|-------|--------|-------|
| Slam | 55 | 15.6M | **Good Slam usage!** |
| Mortal Strike | 32 | 6.0M | OK |
| Overpower | 43 | 4.8M | Could be lower |
| Colossus Smash | 17 | 1.6M | OK |
| Execute | 4 | 1.3M | **Low** |

#### Cooldown Usage

| Buff | Uses | Notes |
|------|------|-------|
| Recklessness | 2 (24s) | **Good!** |
| Skull Banner | 3 (31s) | **Good!** |
| Potion | 1 (25s) | **Single pot** |

#### Analysis

Boviden's rotation is actually decent (55 Slams is good). Main issues:

1. **Single Potting**: Missing pre-pot
2. **Low Execute damage**: Only 4 Executes in execute phase
3. **Too many Overpowers**: 43 is high, some could be Slams

#### Action Items

```
1. DOUBLE POT: Pre-pot before pull
2. EXECUTE SPAM: Below 20%, Execute > everything
3. LESS OVERPOWER: Convert some to Slams
```

**Expected Improvement**: +20-30% DPS (174k → 210k+)

---

### Stassie (Survival Hunter) - 7% Parse

**DPS**: 155k | **ilvl**: 513 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Notes |
|---------|-------|--------|-------|
| Explosive Shot | 50 | 13.6M | Could be higher |
| Stampede | 1 | 7.3M | OK |
| Auto Shot | 104 | 4.3M | OK |
| Black Arrow | 9 | 2.7M | OK |
| Arcane Shot | 31 | 3.2M | OK |

#### Cooldown Usage

| Buff | Uses | Notes |
|------|------|-------|
| Rapid Fire | 2 (30s) | **Good!** |
| Potion | **0** | **NO POTIONS!** |

#### Analysis

Rotation is mostly fine, but **ZERO POTIONS** is a huge issue.

#### Action Items

```
1. USE POTIONS: Pre-pot + second pot = +10-15% DPS
2. MORE EXPLOSIVE SHOTS: Better Lock and Load usage
3. SERPENT STING: Ensure 100% uptime
```

**Expected Improvement**: +30-40% DPS (155k → 200k+)

---

### Rentagar (Elemental Shaman) - 15% Parse

**DPS**: 152k | **ilvl**: 506 | **Fight**: 276s

#### Ability Breakdown

| Ability | Casts | Damage | Notes |
|---------|-------|--------|-------|
| Lava Burst | 44 | 12.2M | **Good!** |
| Lightning Bolt | 90 | 10.9M | **Good!** |
| Flame Shock | 10 | 2.2M | OK |
| Fire Elemental | 2 | 1.4M | **Good!** |

#### Cooldown Usage - CORRECT!

| Buff | Uses | Notes |
|------|------|-------|
| Ascendance | 2 (30s) | **Correct!** |
| Potion | 2 (50s) | **Double pot!** |
| Fire Elemental | 2 | **Correct!** |

#### Analysis

**Rentagar is doing everything right!** The low parse is purely due to ilvl 506 vs average of 520+.

This is a **gear problem, not a skill problem**.

#### Action Items

```
1. PRIORITY: Upgrade gear (especially weapon)
2. MAINTAIN: Current rotation is correct
3. TARGET: ilvl 515+ to see 40%+ parses
```

---

## GOOD DPS PERFORMERS

| Player | Spec | Avg Parse | Notes |
|--------|------|-----------|-------|
| Kamaprayer | Shadow Priest | 86% | Excellent - rotation and CD usage on point |
| Poeshammykun | Resto Shaman | 78% | Best healer performance |
| Zolranth | Ret Paladin | 75% | Solid execution |
| Tpump | Sub Rogue | 60% | Good |
| Sahvahanna | Destro Lock | 60% | Decent, can learn from this player |

---

# PART 2: TANK ANALYSIS

---

## Xamby (Brewmaster Monk) - 17% Parse

**DPS**: 140k | **ilvl**: 517 | **Fight**: 276s

#### Damage Breakdown

| Ability | Damage | Casts | Notes |
|---------|--------|-------|-------|
| Niuzao (Statue) | 9.2M | 1 | Good usage |
| Melee | 8.4M | 217 | OK |
| Blackout Kick | 6.7M | 39 | OK |
| Chi Wave | 4.6M | 12 | Good |
| Tiger Palm | 4.2M | 74 | OK |
| Keg Smash | 3.2M | 18 | **Low - should be 28+** |
| Jab | 1.3M | 48 | Filler |
| **Total** | **38.8M** | - | - |

#### Defensive Cooldown Usage

| Ability | Uptime | Uses | Expected | Assessment |
|---------|--------|------|----------|------------|
| Shuffle | 82% (227s) | 8 | 95%+ | **Could be higher** |
| Guard | 26% (73s) | 6 | 8-10 | **Low usage** |
| Fortifying Brew | 7% (20s) | 1 | 1-2 | OK |
| Elusive Brew | Not tracked | - | Should be high | Check uptime |

#### Issues Identified

1. **Low Keg Smash Casts**: 18 casts in 276s = 1 every 15.3s. Keg Smash is 8s CD, should be ~35 casts. This suggests either:
   - Missing GCDs (not pressing buttons)
   - Energy issues (not using Expel Harm for energy)

2. **Shuffle Uptime 82%**: Should be 95%+. Every Blackout Kick and Keg Smash extends Shuffle. Missing uptime = taking more damage.

3. **Guard Underused**: 6 uses in 276s = 1 every 46s. Guard is 30s CD, should be used more often for absorb.

#### Comparison to Top Brewmaster

| Metric | Xamby | Top 5 Avg | Difference |
|--------|-------|-----------|------------|
| DPS | 140k | 342k | -59% |
| Fight Length | 276s | 159s | +74% longer |
| Expected DPS (adjusted) | ~200k | - | Still -30% low |

**Note**: Longer fights naturally have lower DPS due to less CD value. But even adjusted, Xamby is underperforming.

#### Action Items

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

**DPS**: 100k | **ilvl**: 525 | **Fight**: 276s

#### Damage Breakdown

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

#### Defensive Cooldown Usage

| Ability | Uptime | Uses | Assessment |
|---------|--------|------|------------|
| Shield of the Righteous | 23% (63s) | 15 | **CRITICAL - target 60%+** |
| Sacred Shield | 67% (186s) | 10 | OK |
| Divine Protection | 11% (30s) | 3 | OK |
| Alabaster Shield | 43% (119s) | 22 | OK |

#### Issues Identified

1. **Shield of the Righteous Uptime 23%**: This is critically low. SotR is your main active mitigation, should have 60%+ uptime. Only 21 casts in 276s = 1 every 13s. Should be using on cooldown with 3 Holy Power.

2. **Low Avenger's Shield Usage**: 13 casts in 276s = 1 every 21s. AS is 15s CD (reset by Grand Crusader procs), should be 20+ casts.

3. **4% Parse Despite ilvl 525**: This is the highest ilvl tank but the lowest parse. Indicates serious rotation/mitigation issues.

#### Comparison to Top Prot Paladin

| Metric | Zegadin | Top 5 Avg | Difference |
|--------|---------|-----------|------------|
| DPS | 100k | 365k | -73% |
| ilvl | 525 | ~530 | Similar |
| SotR uptime | 23% | 60%+ | **-37%** |

#### Action Items

```
1. SHIELD OF THE RIGHTEOUS: Use at 3 Holy Power, maintain 60%+ uptime
2. AVENGER'S SHIELD: Use on cooldown, watch for Grand Crusader procs
3. ROTATION: CS > J > AS > HW > Cons (priority for HP generation)
4. HOLY POWER: Never cap, spend at 3-5 on SotR
5. DIVINE PROTECTION: Use more liberally for magic damage
```

**Expected Improvement**: +50-70% DPS, significantly better survivability

**THIS IS A RAID SURVIVABILITY ISSUE** - Healers are having to work harder because tank mitigation is low.

---

# PART 3: HEALER ANALYSIS

---

## Poeshammykun (Resto Shaman) - 78% Parse [GOOD]

**HPS**: ~65k | **ilvl**: 515 | **Fight**: 276s

#### Healing Breakdown

| Ability | Healing | Casts | Notes |
|---------|---------|-------|-------|
| Healing Rain | 6.4M | 10 | Good |
| Healing Tide | 4.7M | 1 | Good |
| Healing Stream | 2.8M | 5 | OK |
| Chain Heal | 0.7M | 12 | Low |
| Riptide | 0.5M | 7 | Low |
| Earth Shield | 0.5M | - | On tank |

#### Cooldown Usage

| Cooldown | Uses | Expected | Notes |
|----------|------|----------|-------|
| Ascendance | 1 | 2 | **Missing 2nd use** |
| Healing Tide | 1 | 1 | Good |
| Spirit Link | 1 | 1-2 | OK |

#### Assessment

Poeshammykun is your **best healer** at 78% parse. Doing most things right.

**Minor Improvements:**
1. Use Ascendance twice (3 min CD, fight is 4.6 min)
2. More Chain Heal usage during raid damage
3. More Riptide for Tidal Waves procs

---

## Chaewonsham (Resto Shaman) - 51% Parse

**HPS**: ~101k | **ilvl**: 515 | **Fight**: 276s

#### Healing Breakdown

| Ability | Healing | Casts | Notes |
|---------|---------|-------|-------|
| Healing Rain | 9.4M | 7 | Good |
| Healing Tide | 5.3M | 1 | Good |
| Chain Heal | 4.6M | 33 | **Good!** |
| Healing Stream | 4.2M | 14 | Good |
| Riptide | 0.6M | 11 | OK |

#### Cooldown Usage

| Cooldown | Uses | Notes |
|----------|------|-------|
| Ascendance | 1 | **Missing 2nd use** |
| Healing Tide | 1 | Good |

#### Assessment

Solid healer at 51% parse. Actually has higher raw HPS than Poeshammykun but lower parse - likely due to overhealing or timing issues.

**Improvements:**
1. Use Ascendance twice
2. Better cooldown timing (stack with damage phases)

---

## Missypriest (Discipline Priest) - 18% Parse [CRITICAL]

**HPS**: ~88k | **ilvl**: 520 | **Fight**: 276s

#### Healing Breakdown

| Ability | Healing | Casts | Notes |
|---------|---------|-------|-------|
| Divine Aegis | 6.9M | - | Passive shields |
| Power Word: Shield | 5.4M | 39 | OK |
| Halo | 4.1M | 6 | **Low - should be 10+** |
| Atonement | 5.3M | - | Good |
| Prayer of Mending | 0.8M | 6 | **Low - should be 15+** |

#### Cooldown Usage

| Cooldown | Uses | Uptime | Assessment |
|----------|------|--------|------------|
| Archangel | 8 | 47% (131s) | **Good!** |
| Power Infusion | 3 | 16% (44s) | OK |
| Spirit Shell | 0 | 0% | **NOT USED!** |
| Potion | 1 | 8% | Single pot |

#### Issues Identified

1. **Spirit Shell Not Used**: Spirit Shell is Disc's biggest throughput cooldown. Convert all healing to absorbs for 15s. Should be used 2-3 times during heavy damage (like Ionization).

2. **Low Halo Usage**: 6 casts in 276s = 1 every 46s. Halo is 40s CD, should be 7 casts minimum.

3. **Low Prayer of Mending**: Only 6 casts. PoM should be used on cooldown (10s CD) = 27+ casts.

4. **Single Potting**: Using Jade Serpent pot, but only 1 use.

#### Comparison to Top Disc Priest

| Metric | Missypriest | Top 5 Avg | Difference |
|--------|-------------|-----------|------------|
| HPS | 88k | 204k | -57% |
| Spirit Shell | 0 uses | 2-3 uses | Missing CD |
| PoM casts | 6 | 25+ | **-76%** |

#### Action Items

```
1. SPIRIT SHELL: Use before big damage (Ionization)
2. PRAYER OF MENDING: On cooldown, bounces 5 times
3. HALO: Every 40 seconds
4. PENANCE: Use on CD for Atonement healing
5. DOUBLE POT: Pre-pot + second pot
```

**Expected Improvement**: +50-80% HPS

---

## Mightlive (Holy Paladin) - 13% Parse [CRITICAL]

**HPS**: ~110k | **ilvl**: 518 | **Fight**: 276s

#### Healing Breakdown

| Ability | Healing | Casts | Notes |
|---------|---------|-------|-------|
| Illuminated Healing | 11.4M | - | Mastery shields |
| Light of Dawn | 5.5M | 40 | OK |
| Holy Radiance | 3.1M | 37 | OK |
| Eternal Flame | 2.3M | 17 | **Low** |
| Holy Shock | 1.8M | 45 | OK |
| Beacon of Light | 1.3M | 1 | OK |

#### Cooldown Usage

| Cooldown | Uses | Uptime | Assessment |
|----------|------|--------|------------|
| Avenging Wrath | 1 | 7% (20s) | **Only 1 use!** |
| Guardian of Ancient Kings | 1 | 5% (15s) | OK |
| Divine Favor | 1 | 7% (20s) | **Only 1 use!** |
| Divine Plea | 1 | 3% (9s) | OK |

#### Issues Identified

1. **Only 1 Avenging Wrath**: 3 min CD, should use twice in 276s fight. Missing 20s of +20% healing.

2. **Only 1 Divine Favor**: 3 min CD, should use twice. Missing +20% crit/haste window.

3. **Low Eternal Flame Usage**: 17 casts is low for a 276s fight. EF should be blanketed on the raid.

4. **No Potion Detected**: Not using mana potion or throughput potion.

#### Comparison to Top Holy Paladin

| Metric | Mightlive | Top 5 Avg | Difference |
|--------|-----------|-----------|------------|
| HPS | 110k | 260k | -58% |
| Avenging Wrath | 1 use | 2+ uses | Missing CD |
| EF uptime | Low | High | Missing HoTs |

#### Action Items

```
1. AVENGING WRATH: Use twice (pull + ~3 min)
2. DIVINE FAVOR: Use twice, stack with AW if possible
3. ETERNAL FLAME: Maintain on tanks + spread to raid
4. HOLY SHOCK: Use on CD for Holy Power
5. BEACON: Ensure always on active tank
6. USE POTIONS: Mana or throughput
```

**Expected Improvement**: +60-80% HPS

---

## Chubzilla (Resto Druid) - 20% Parse [CRITICAL]

**HPS**: ~53k | **ilvl**: 516 | **Fight**: 276s

#### Healing Breakdown

| Ability | Healing | Casts | Notes |
|---------|---------|-------|-------|
| Rejuvenation | 5.4M | 70 | OK |
| Wild Growth | 2.8M | 12 | **Low - should be 34+** |
| Efflorescence | 2.4M | - | OK |
| Wild Mushroom | 1.7M | 2 | **Very low** |
| Tranquility | 0.9M | 1 | OK |
| Swiftmend | 0.1M | 7 | **Very low** |

#### Cooldown Usage

| Cooldown | Uses | Assessment |
|----------|------|------------|
| Tranquility | 1 | OK |
| Incarnation | 0? | **Check if talented** |
| Nature's Swiftness | ? | Should be using |
| Innervate | 1 | OK |

#### Issues Identified

1. **Low Wild Growth Usage**: 12 casts in 276s = 1 every 23s. WG is 8s CD, should be 34+ casts. **This is your primary raid healing spell!**

2. **Very Low Swiftmend**: Only 7 casts. Swiftmend is 15s CD (reduced by haste), should be 18+ casts. Also places Efflorescence.

3. **Wild Mushroom Underused**: Only 2 blooms. Should be placing mushrooms on melee and detonating frequently.

4. **Low Overall Output**: 53k HPS when top druids do 180k+ indicates major rotation issues.

#### Comparison to Top Resto Druid

| Metric | Chubzilla | Top 5 Avg | Difference |
|--------|-----------|-----------|------------|
| HPS | 53k | 188k | -72% |
| Wild Growth | 12 casts | 30+ casts | **-60%** |
| Swiftmend | 7 casts | 18+ casts | **-61%** |

#### Action Items

```
1. WILD GROWTH: Use on cooldown (8s CD), primary AoE heal
2. SWIFTMEND: Use on cooldown for Efflorescence placement
3. REJUVENATION: Blanket the raid before damage
4. WILD MUSHROOM: Place on melee, bloom when stacked
5. LIFEBLOOM: Maintain 3 stacks on tank at all times
6. NATURE'S SWIFTNESS: Use for instant Healing Touch
```

**Expected Improvement**: +100-150% HPS

---

# PART 4: CONSUMABLES AUDIT

---

## Potion Usage Summary

| Status | Players |
|--------|---------|
| **ZERO POTS** | Vaelindra, Bonessenpai, Stassie |
| Single Pot | Lockycharmzs, Sertotems, Unsanctioned, Boviden, Missypriest |
| Double Pot | Rentagar |

**Double potting provides 5-8% free DPS/HPS!**

### How to Double Pot

```
1. PRE-POT: Use potion 1 second before pull timer hits 0
2. SECOND POT: Use during Bloodlust/Heroism OR during execute phase
3. TIMING: Stack with major cooldowns for maximum value
```

---

# PART 5: RAID-WIDE IMPACT ANALYSIS

---

## Potential DPS Gain If Issues Fixed

| Player | Current | Potential | Gain |
|--------|---------|-----------|------|
| Vaelindra | 83k | 180k | +97k |
| Lockycharmzs | 111k | 200k | +89k |
| Sertotems | 58k | 150k | +92k |
| Bonessenpai | 130k | 200k | +70k |
| Stassie | 155k | 200k | +45k |
| Unsanctioned | 125k | 175k | +50k |
| Nybszerk | 115k | 165k | +50k |
| Boviden | 174k | 210k | +36k |
| **TOTAL** | - | - | **+529k DPS** |

**That's equivalent to adding 2-3 extra DPS players to your raid.**

---

## Priority Action List

### THIS WEEK (Before Next Raid)

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 1 | Bonessenpai | Get 2x 1H weapons for DW Frost | +70k DPS |
| 2 | Vaelindra | Respec to Survival Hunter | +100k DPS |
| 3 | Everyone | Double pot every pull | +5-8% each |
| 4 | Lockycharmzs | Learn Shadowburn execute rotation | +90k DPS |

### NEXT RAID (Rotation/CD Fixes)

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 5 | Zegadin | Maintain 60%+ Shield of Righteous | Tank survivability |
| 6 | Chubzilla | Wild Growth every 8 seconds | +100% HPS |
| 7 | Missypriest | Use Spirit Shell before Ionization | +50% HPS |
| 8 | Mightlive | Avenging Wrath + Divine Favor twice | +60% HPS |
| 9 | Sertotems | ABC - Always Be Casting | +150% DPS |

### ONGOING

| Action | Who |
|--------|-----|
| Review logs weekly with class leads | Officers |
| Set minimum parse expectations (30%+ average) | Raid Lead |
| Mentor underperformers with class-specific help | Class Leads |

---

## Tank Survivability Note

Zegadin's 23% SotR uptime means healers are working harder than necessary. Fixing tank mitigation will:
- Reduce healer mana usage
- Allow healers to focus on raid instead of tank
- Reduce risk of tank deaths on high damage phases

---

# APPENDIX: FIGHT MECHANICS REFERENCE

---

## Jin'rokh the Breaker

| Mechanic | What to Do |
|----------|------------|
| Conductive Waters | Stand in pools for +damage buff |
| Ionization | Spread out, healer CD here |
| Thundering Throw | Tank swap, creates pool |
| Focused Lightning | Run away from raid |

**Healer CDs for Ionization**: Spirit Shell, Tranquility, Healing Tide, Spirit Link

---

*Analysis generated from Warcraft Logs API - Jin'rokh 25N (276s fight)*
*Log: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C*
