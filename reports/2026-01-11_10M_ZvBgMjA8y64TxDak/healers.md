# Healer Analysis - Throne of Thunder 10N

**Log:** https://classic.warcraftlogs.com/reports/ZvBgMjA8y64TxDak
**Date:** 2026-01-11

---

## IMPORTANT: Healer Ranking Methodology

**Healers are ranked by HPS (healing per second), NOT combined parse.**

The default WCL "combined" parse includes DPS contribution, which can be misleading:
- A healer with 78% combined parse might have only 10% healing parse
- This happens when healers prioritize DPS over healing
- For healer evaluation, pure healing output matters most

---

## Healer Summary

| Player | Spec | Avg HPS | World Median | Gap | Status |
|--------|------|---------|--------------|-----|--------|
| Kamakmeleon | Resto Druid | 70k | 108k | -35% | Needs Work |
| Priestsky | Disc Priest | 52k | 80k | -35% | Critical |

**Both healers are significantly below world median for their specs.**

---

## HPS by Fight

| Player | Ji-Kun | Durumu | Primo | Animus | Qon | Twins | Lei Shen |
|--------|--------|--------|-------|--------|-----|-------|----------|
| Kamakmeleon | 46k | 52k | 104k | 66k | 103k | 63k | 71k |
| Priestsky | 49k | 45k | 70k | 41k | 61k | 58k | 48k |

## Overheal by Fight

| Player | Ji-Kun | Durumu | Primo | Animus | Qon | Twins | Lei Shen |
|--------|--------|--------|-------|--------|-----|-------|----------|
| Kamakmeleon | 60% | 60% | 43% | 51% | 46% | 60% | 51% |
| Priestsky | 47% | 44% | 19% | 29% | 25% | 36% | 42% |

---

## World Ranking Comparison

### Lei Shen 10N Benchmarks

| Spec | Our HPS | Top 10 World | Median | Our Percentile |
|------|---------|--------------|--------|----------------|
| Resto Druid | 71k | 127k | 108k | ~20-25% |
| Disc Priest | 48k | 105k | 80k | ~10-15% |

---

## Detailed Analysis

### Kamakmeleon (Restoration Druid) - Needs Work

**Average HPS:** 70k (World Median: 108k)
**Average Overheal:** 53%

**Performance by Fight:**

| Fight | HPS | Overheal | Notes |
|-------|-----|----------|-------|
| Primordius | 104k | 43% | Good - high damage fight |
| Iron Qon | 103k | 46% | Good - high damage fight |
| Lei Shen | 71k | 51% | Below Average |
| Dark Animus | 66k | 51% | Below Average |
| Twin Empyreans | 63k | 60% | Poor |
| Durumu | 52k | 60% | Poor |
| Ji-Kun | 46k | 60% | Poor |

**Issues Identified:**

| Issue | Current | Target |
|-------|---------|--------|
| Average Overheal | 53% | <40% |
| Wild Growth Usage | Likely low | On cooldown (8s CD) |
| Swiftmend Usage | Unknown | On cooldown (15s CD) |
| Lifebloom Uptime | Unknown | 100% on tank |

**Analysis:**
- 60% overheal on Ji-Kun, Durumu, and Twins is too high
- High overheal suggests casting heals on topped players
- Performs better on high-damage fights (Primo, Qon) where overhealing is harder
- Wild Growth likely not used on cooldown

**Recommendations:**

1. **Reduce Overhealing**
   - Pre-hot before damage, not after
   - Target low-health players first
   - Stop casting when raid is topped

2. **Wild Growth on Cooldown**
   - 8 second cooldown
   - Should have 30+ casts in a 4-5 min fight
   - Time with predictable raid damage

3. **Swiftmend Usage**
   - 15 second cooldown
   - Creates Efflorescence
   - Should have 18+ casts in 4-5 min fight

4. **Lifebloom Uptime**
   - Maintain 100% on active tank
   - Generates Omen of Clarity procs

5. **Cooldown Usage**
   - Tranquility: Use during heavy damage
   - Nature's Vigil: Use on cooldown
   - Incarnation: Use for burst healing

**Expected Improvement:** 70k → 100k+ HPS

---

### Priestsky (Discipline Priest) - CRITICAL

**Average HPS:** 52k (World Median: 80k)
**Average Overheal:** 33%

**Performance by Fight:**

| Fight | HPS | Overheal | Notes |
|-------|-----|----------|-------|
| Primordius | 70k | 19% | Best - high damage |
| Iron Qon | 61k | 25% | Below Average |
| Twin Empyreans | 58k | 36% | Poor |
| Ji-Kun | 49k | 47% | Poor |
| Lei Shen | 48k | 42% | Poor |
| Durumu | 45k | 44% | Very Poor |
| Dark Animus | 41k | 29% | Very Poor |

**Combined Parse History:**

| Fight | Combined Parse | Notes |
|-------|----------------|-------|
| Ji-Kun | 26% | Low |
| Durumu | 23% | Low |
| Primordius | 8% | Very Low |
| Dark Animus | 1% | Critical |
| Iron Qon | 17% | Low |
| Twin Empyreans | 20% | Low |
| Lei Shen | 9% | Very Low |

**Issues Identified:**

| Issue | Current | Target |
|-------|---------|--------|
| Overall Output | 40% below median | At median |
| Atonement Healing | Underutilized | Primary healing source |
| Spirit Shell Usage | Likely poor timing | Before damage spikes |
| Prayer of Mending | Unknown cast count | 27+ (10s CD) |

**Analysis:**
- Both HPS AND combined parse are low
- This means BOTH healing AND DPS contribution are lacking
- Disc Priest strength is Atonement healing + Spirit Shell
- 1% parse on Dark Animus is concerning

**Recommendations:**

1. **CRITICAL: Atonement Healing**
   - Penance on cooldown (enemy target for Atonement)
   - Smite filler
   - Holy Fire on cooldown
   - Atonement should be 30-40% of healing

2. **Spirit Shell Timing**
   - Use BEFORE predictable damage
   - Covers 15 seconds of healing as absorbs
   - Critical for Ionization, Quills, etc.

3. **Prayer of Mending**
   - 10 second cooldown
   - Should cast 27+ times in 4-5 min fight
   - Keep bouncing on melee

4. **Power Word: Shield**
   - Blanket before damage
   - Rapture for mana return

5. **Cooldown Usage**
   - Power Infusion: On cooldown (self or DPS)
   - Pain Suppression: Tank cooldown
   - Barrier: Stacking for mechanics

6. **Archangel**
   - Build to 5 Evangelism stacks
   - Pop Archangel for 25% healing buff
   - Should have 8+ uses per fight

**Expected Improvement:** 52k → 80k+ HPS

---

## Healer Benchmarks (MoP 10N)

### Ability Cast Targets (4-5 min fight)

| Class | Ability | Target Casts | Cooldown |
|-------|---------|--------------|----------|
| Resto Druid | Wild Growth | 34+ | 8s |
| Resto Druid | Swiftmend | 18+ | 15s |
| Disc Priest | Prayer of Mending | 27+ | 10s |
| Disc Priest | Penance | 40+ | 9s |

### HPS Targets by Spec (10N)

| Spec | Median HPS | Good | Excellent |
|------|------------|------|-----------|
| Resto Druid | 100k+ | 120k+ | 140k+ |
| Disc Priest | 80k+ | 100k+ | 120k+ |

---

## Priority Actions

| Priority | Player | Issue | Action | Expected Gain |
|----------|--------|-------|--------|---------------|
| 1 | Priestsky | Low output | Atonement + Spirit Shell usage | +54% HPS |
| 2 | Kamakmeleon | High overheal | Pre-hot, Wild Growth on CD | +43% HPS |
| 3 | Both | Cooldown usage | Use major CDs twice per fight | +10% HPS |

---

## Raid Impact

With both healers 35% below median:
- Higher risk of deaths during damage spikes
- Less room for error on mechanics
- DPS may need to use personals more often

Bringing healers to median would:
- Reduce death count
- Allow faster progression
- Give margin for learning new fights

---

*Analysis based on WCL data and world ranking comparisons*
