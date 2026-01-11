# Healer Performance Analysis

**Log**: https://classic.warcraftlogs.com/reports/DkgR89WBa47FJd1C
**Fight**: Jin'rokh 25N (276 seconds)

**IMPORTANT**: Healers are ranked by HEALING output (HPS), not combined parse.

---

## HEALER SUMMARY (Ranked by HPS)

| Rank | Player | Spec | ilvl | HPS | Healing Parse | Tier |
|------|--------|------|------|-----|---------------|------|
| 1 | Mightlive | Holy Paladin | 518 | 111k | ~15-20% | CRITICAL |
| 2 | Chaewonsham | Resto Shaman | 515 | 101k | ~30-35% | Needs Work |
| 3 | Missypriest | Disc Priest | 520 | 89k | ~15-20% | CRITICAL |
| 4 | Poeshammykun | Resto Shaman | 515 | 64k | ~10% | CRITICAL |
| 5 | Chubzilla | Resto Druid | 516 | 52k | ~5-10% | CRITICAL |

**All 5 healers are below median for their spec.**

### Top Healer HPS Benchmarks (Jin'rokh 25N)

| Spec | Top HPS | Median HPS | Below 20% Parse |
|------|---------|------------|-----------------|
| Resto Druid | 212k | 141k | <70k |
| Holy Paladin | 312k | 176k | <100k |
| Disc Priest | 220k | 150k | <80k |
| Resto Shaman | 215k | 167k | <80k |

---

## Mightlive (Holy Paladin) - 111k HPS - CRITICAL

**Healing Parse**: ~15-20% | **Total Healing**: 30.7M

Despite highest raw HPS, still well below median (176k).

### Healing Breakdown

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Illuminated Healing | 11.4M | - | 6% |
| Light of Dawn | 5.5M | 40 | 57% |
| Holy Radiance | 3.1M | 37 | 53% |
| Eternal Flame | 2.3M | 17 | 58% |
| Holy Shock | 1.8M | 45 | 62% |

### Cooldown Usage

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Avenging Wrath | 1 | 2 | **MISSING 2nd** |
| Divine Favor | 1 | 2 | **MISSING 2nd** |
| Potion | 0 | 2 | **NO POTIONS** |

### Action Items

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

### Healing Breakdown

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Healing Rain | 9.4M | 7 | 66% |
| Healing Tide | 5.3M | 1 | 17% |
| Chain Heal | 4.6M | 33 | 32% |
| Healing Stream | 4.2M | 14 | 25% |

### Cooldown Usage

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Ascendance | 1 | 2 | **MISSING 2nd** |
| Mana Tide | 0 | 1-2 | **NOT USED** |

### Action Items

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

### Healing Breakdown

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Divine Aegis | 6.9M | - | 37% |
| Power Word: Shield | 5.4M | 39 | 16% |
| Halo | 4.1M | 6 | 81% |
| Atonement | 5.3M | - | ~20% |
| Prayer of Mending | 0.8M | 6 | 12% |

### Cooldown Usage

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Archangel | 8 | 8+ | Good! |
| Spirit Shell | 0 | 2-3 | **NOT USED - CRITICAL** |
| Potion | 1 | 2 | Single pot |

**Critical Issue**: Zero Spirit Shell usage. This is Disc's biggest throughput CD (15s of absorb conversion).

### Action Items

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

### Comparison to Chaewonsham

| Metric | Poeshammykun | Chaewonsham | Difference |
|--------|--------------|-------------|------------|
| Total Healing | 17.7M | 28.0M | **-37%** |
| HPS | 64k | 101k | **-37%** |
| DPS | 31k | 17k | +82% |
| Chain Heal casts | 12 | 33 | **-64%** |

**Problem**: DPSing too much, not healing enough.

### Healing Breakdown

| Ability | Healing | Uses | Overheal |
|---------|---------|------|----------|
| Healing Rain | 6.4M | 10 | 77% |
| Healing Tide | 4.7M | 1 | 16% |
| Chain Heal | 0.7M | 12 | 59% |
| Riptide | 0.5M | 7 | 56% |

### Action Items

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

### Healing Breakdown

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

### Cooldown Usage

| Cooldown | Uses | Expected | Issue |
|----------|------|----------|-------|
| Tranquility | 1 | 1 | OK |
| Incarnation | 0 | 1-2 | **NOT USED** |
| Nature's Vigil | 0 | 2 | **NOT USED** |

### Action Items

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

## HEALER PRIORITY ACTION LIST

### THIS WEEK (Before Next Raid)

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 1 | Chubzilla | Wild Growth every 8 seconds | +130% HPS |
| 2 | Poeshammykun | More Chain Heal, less DPS | +56% HPS |
| 3 | Mightlive | AW + DF twice, use potions | +44% HPS |

### NEXT RAID

| Priority | Player | Action | Impact |
|----------|--------|--------|--------|
| 4 | Missypriest | Spirit Shell before Ionization | +57% HPS |
| 5 | All Shamans | Ascendance twice | +20-30% HPS |
| 6 | Chubzilla | Use Incarnation + Nature's Vigil | +20% HPS |
| 7 | All Healers | Double pot | +5-8% HPS |

---

## HEALER ABILITY BENCHMARKS (4-5 min fight)

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

---

## NOTE ON HEALER PARSE TYPES

WCL has TWO different parse types for healers:

| Parse Type | What It Measures | Use For |
|------------|------------------|---------|
| Combined/Default | HPS + DPS contribution | NOT recommended |
| HPS Only | Pure healing output | **Use this for healer evaluation** |

Example: Poeshammykun has 78% combined parse but only ~10% HEALING parse because of high DPS contribution.

**Always evaluate healers by HPS, not combined parse.**

---

*Analysis generated from Warcraft Logs API*
*Fight: Jin'rokh 25N (276s)*
