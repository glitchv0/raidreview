#!/bin/bash
# Generate per-boss rotation comparison table vs top performers
# Uses WCL DamageDone table API
# Shows uptime % for DoTs, CPM for direct abilities
# Usage: ./gen_comparison_table.sh <player_id> <spec> [report_code]

PLAYER_ID="$1"
SPEC="$2"
REPORT_CODE="${3:-73LvphDmkPZzNX6V}"

TOKEN=$(cat /tmp/wcl_token.txt 2>/dev/null)
if [ -z "$TOKEN" ]; then
    echo "Error: No WCL token found at /tmp/wcl_token.txt"
    exit 1
fi

# Encounter ID to boss name mapping
declare -A ENC_TO_BOSS
ENC_TO_BOSS[51577]="Jinrokh"
ENC_TO_BOSS[51575]="Horridon"
ENC_TO_BOSS[51570]="Council_of_Elders"
ENC_TO_BOSS[51565]="Tortos"
ENC_TO_BOSS[51578]="Megaera"
ENC_TO_BOSS[51573]="Ji-Kun"
ENC_TO_BOSS[51572]="Durumu"
ENC_TO_BOSS[51574]="Primordius"
ENC_TO_BOSS[51576]="Dark_Animus"
ENC_TO_BOSS[51559]="Iron_Qon"
ENC_TO_BOSS[51560]="Twin_Empyreans"
ENC_TO_BOSS[51579]="Lei_Shen"

# Spec to ability names - format: ability_name=type (dot=DoT uptime, cast=CPM)
# Using = as delimiter to avoid issues with ability names containing :
declare -A SPEC_ABILITIES
SPEC_ABILITIES["shadow_priest"]="Mind Blast=cast|Vampiric Touch=dot|Shadow Word: Pain=dot|Devouring Plague=dot|Shadow Word: Death=cast|Mind Flay=cast|Mind Flay (Insanity)=cast|Shadowfiend=cast"
SPEC_ABILITIES["arms_warrior"]="Mortal Strike=cast|Colossus Smash=cast|Overpower=cast|Slam=cast|Execute=cast|Bladestorm=cast"
SPEC_ABILITIES["fury_warrior"]="Bloodthirst=cast|Raging Blow=cast|Colossus Smash=cast|Wild Strike=cast|Execute=cast"
SPEC_ABILITIES["frost_dk"]="Obliterate=cast|Frost Strike=cast|Howling Blast=cast|Soul Reaper=cast"
SPEC_ABILITIES["unholy_dk"]="Scourge Strike=cast|Festering Strike=cast|Death Coil=cast|Soul Reaper=cast"
SPEC_ABILITIES["survival_hunter"]="Explosive Shot=cast|Black Arrow=dot|Serpent Sting=dot|Cobra Shot=cast|Arcane Shot=cast|Kill Shot=cast|A Murder of Crows=cast|Glaive Toss=cast"
SPEC_ABILITIES["bm_hunter"]="Kill Command=cast|Arcane Shot=cast|Cobra Shot=cast|Kill Shot=cast"
SPEC_ABILITIES["mm_hunter"]="Chimera Shot=cast|Aimed Shot=cast|Steady Shot=cast|Kill Shot=cast"
SPEC_ABILITIES["destro_warlock"]="Chaos Bolt=cast|Conflagrate=cast|Incinerate=cast|Immolate=dot|Shadowburn=cast"
SPEC_ABILITIES["demo_warlock"]="Soul Fire=cast|Shadow Bolt=cast|Hand of Gul'dan=cast|Touch of Chaos=cast|Corruption=dot|Doom=dot"
SPEC_ABILITIES["afflic_warlock"]="Malefic Grasp=cast|Unstable Affliction=dot|Agony=dot|Corruption=dot|Haunt=cast"
SPEC_ABILITIES["elemental_shaman"]="Lava Burst=cast|Lightning Bolt=cast|Flame Shock=dot|Earth Shock=cast|Chain Lightning=cast"
SPEC_ABILITIES["enhance_shaman"]="Stormstrike=cast|Lava Lash=cast|Earth Shock=cast|Flame Shock=dot|Lightning Bolt=cast"
SPEC_ABILITIES["fire_mage"]="Fireball=cast|Pyroblast=cast|Living Bomb=dot|Scorch=cast|Combustion=cast"
SPEC_ABILITIES["arcane_mage"]="Arcane Blast=cast|Arcane Missiles=cast|Arcane Barrage=cast"
SPEC_ABILITIES["frost_mage"]="Frostbolt=cast|Ice Lance=cast|Frostfire Bolt=cast|Frozen Orb=cast"
SPEC_ABILITIES["subtlety_rogue"]="Backstab=cast|Ambush=cast|Eviscerate=cast|Rupture=dot|Shadow Dance=cast"
SPEC_ABILITIES["assassination_rogue"]="Mutilate=cast|Envenom=cast|Rupture=dot|Dispatch=cast"
SPEC_ABILITIES["combat_rogue"]="Sinister Strike=cast|Revealing Strike=cast|Eviscerate=cast|Killing Spree=cast"
SPEC_ABILITIES["ret_paladin"]="Crusader Strike=cast|Judgment=cast|Templar's Verdict=cast|Exorcism=cast|Hammer of Wrath=cast"
SPEC_ABILITIES["balance_druid"]="Wrath=cast|Starfire=cast|Starsurge=cast|Moonfire=dot|Sunfire=dot"
SPEC_ABILITIES["feral_druid"]="Shred=cast|Rake=dot|Rip=dot|Ferocious Bite=cast|Savage Roar=cast"
SPEC_ABILITIES["windwalker_monk"]="Jab=cast|Tiger Palm=cast|Blackout Kick=cast|Rising Sun Kick=cast|Fists of Fury=cast"

# WCL may use alternate names for some abilities
declare -A ABILITY_ALIASES
ABILITY_ALIASES["Dispatch"]="Blindside"

SPEC_ICON_MAP="shadow_priest:Priest-Shadow|arms_warrior:Warrior-Arms|fury_warrior:Warrior-Fury|frost_dk:DeathKnight-Frost|unholy_dk:DeathKnight-Unholy|survival_hunter:Hunter-Survival|bm_hunter:Hunter-BeastMastery|mm_hunter:Hunter-Marksmanship|destro_warlock:Warlock-Destruction|demo_warlock:Warlock-Demonology|afflic_warlock:Warlock-Affliction|elemental_shaman:Shaman-Elemental|enhance_shaman:Shaman-Enhancement|fire_mage:Mage-Fire|arcane_mage:Mage-Arcane|frost_mage:Mage-Frost|subtlety_rogue:Rogue-Subtlety|assassination_rogue:Rogue-Assassination|combat_rogue:Rogue-Combat|ret_paladin:Paladin-Retribution|balance_druid:Druid-Balance|feral_druid:Druid-Feral|windwalker_monk:Monk-Windwalker"

# Get spec icon for filtering top performers
SPEC_ICON=""
IFS='|' read -ra ICON_PAIRS <<< "$SPEC_ICON_MAP"
for pair in "${ICON_PAIRS[@]}"; do
    IFS=':' read -r spec icon <<< "$pair"
    if [ "$spec" == "$SPEC" ]; then
        SPEC_ICON="$icon"
        break
    fi
done

ABILITIES_STR="${SPEC_ABILITIES[$SPEC]}"
if [ -z "$ABILITIES_STR" ]; then
    echo "Unknown spec: $SPEC"
    exit 1
fi

REPORT_INFO="raw/${REPORT_CODE}/report_info.json"
if [ ! -f "$REPORT_INFO" ]; then
    echo "No report_info.json found"
    exit 1
fi

# Function to get DamageDone table for a fight
get_damage_table() {
    local report="$1"
    local fight_id="$2"
    local source_id="$3"

    curl -s -X POST "https://classic.warcraftlogs.com/api/v2/client" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"query\": \"{ reportData { report(code: \\\"${report}\\\") { table(dataType: DamageDone, fightIDs: [${fight_id}], sourceID: ${source_id}) } } }\"}" 2>/dev/null
}

# Function to extract DoT uptime from DamageDone table (in ms)
get_ability_uptime() {
    local json="$1"
    local ability_name="$2"
    local alias="${ABILITY_ALIASES[$ability_name]}"

    # Find entry with uptime (DoT application entry)
    local result=$(echo "$json" | jq -r --arg name "$ability_name" --arg alias "${alias:-$ability_name}" '
        .data.reportData.report.table.data.entries[]? |
        select((.name == $name or .name == $alias) and .uptime != null) |
        .uptime
    ' 2>/dev/null | head -1)

    if [ -z "$result" ] || [ "$result" == "null" ]; then
        echo "0"
    else
        echo "$result"
    fi
}

# Function to extract cast count from DamageDone table
# Uses 'uses' if available, otherwise 'hitCount' for single-hit abilities
get_ability_casts() {
    local json="$1"
    local ability_name="$2"
    local alias="${ABILITY_ALIASES[$ability_name]}"

    # First try to get 'uses' (for abilities tracked as casts)
    local result=$(echo "$json" | jq -r --arg name "$ability_name" --arg alias "${alias:-$ability_name}" '
        .data.reportData.report.table.data.entries[]? |
        select((.name == $name or .name == $alias) and .uses != null) |
        .uses
    ' 2>/dev/null | head -1)

    # If no uses, try hitCount (for single-hit abilities like Envenom)
    if [ -z "$result" ] || [ "$result" == "null" ]; then
        result=$(echo "$json" | jq -r --arg name "$ability_name" --arg alias "${alias:-$ability_name}" '
            .data.reportData.report.table.data.entries[]? |
            select((.name == $name or .name == $alias) and .hitCount > 0) |
            .hitCount
        ' 2>/dev/null | head -1)
    fi

    if [ -z "$result" ] || [ "$result" == "null" ]; then
        echo "0"
    else
        echo "$result"
    fi
}

# Abbreviation mapping
abbreviate() {
    echo "$1" | sed '
        s/Mind Blast/MB/; s/Vampiric Touch/VT/; s/Shadow Word: Pain/SWP/; s/Shadow Word: Death/SWD/;
        s/Devouring Plague/DP/; s/Shadowfiend/SFnd/; s/Mind Flay (Insanity)/MFI/; s/Mind Flay/MF/;
        s/Mortal Strike/MS/; s/Colossus Smash/CS/;
        s/Explosive Shot/ES/; s/Black Arrow/BA/; s/Serpent Sting/SrS/; s/Cobra Shot/CoS/; s/Arcane Shot/AS/;
        s/Kill Shot/KS/; s/A Murder of Crows/AMoC/; s/Glaive Toss/GT/; s/Bladestorm/BStorm/;
        s/Chaos Bolt/CB/; s/Conflagrate/Conf/; s/Incinerate/Inc/; s/Shadowburn/SB/; s/Immolate/Immo/;
        s/Soul Fire/SF/; s/Shadow Bolt/ShB/; s/Hand of Gul.dan/HoG/; s/Touch of Chaos/ToC/; s/Doom/Doom/;
        s/Lava Burst/LvB/; s/Lightning Bolt/LB/; s/Flame Shock/FS/; s/Earth Shock/ES/; s/Chain Lightning/CL/;
        s/Stormstrike/SS/; s/Lava Lash/LL/; s/Pyroblast/Pyro/; s/Living Bomb/LvB/; s/Combustion/Comb/;
        s/Backstab/BS/; s/Ambush/Amb/; s/Eviscerate/Evis/; s/Rupture/Rup/; s/Shadow Dance/SD/;
        s/Dispatch/Disp/; s/Envenom/Env/; s/Mutilate/Mut/;
        s/Crusader Strike/CS/; s/Judgment/Jud/; s/Templar.s Verdict/TV/; s/Exorcism/Exo/; s/Hammer of Wrath/HoW/;
        s/Obliterate/Oblit/; s/Frost Strike/FS/; s/Howling Blast/HB/; s/Soul Reaper/SR/;
        s/Kill Command/KC/; s/Chimera Shot/ChS/; s/Aimed Shot/AiS/; s/Steady Shot/StS/;
        s/Bloodthirst/BT/; s/Raging Blow/RB/; s/Wild Strike/WS/;
        s/Scourge Strike/ScS/; s/Festering Strike/FsS/; s/Death Coil/DC/;
        s/Malefic Grasp/MG/; s/Unstable Affliction/UA/; s/Agony/Ag/; s/Haunt/Hnt/; s/Corruption/Corr/;
        s/Wrath/Wr/; s/Starfire/StF/; s/Starsurge/SS/; s/Moonfire/MF/; s/Sunfire/SuF/;
        s/Shred/Shr/; s/Rake/Rk/; s/Rip/Rip/; s/Ferocious Bite/FB/; s/Savage Roar/SvR/;
        s/Jab/Jab/; s/Tiger Palm/TP/; s/Blackout Kick/BoK/; s/Rising Sun Kick/RSK/; s/Fists of Fury/FoF/
    '
}

echo "#### Per-Boss Rotation Analysis vs Top Performers"
echo ""
echo "| Boss | Ability | You | Top | Gap |"
echo "|------|---------|-----|-----|-----|"

# Get kills from report_info and iterate
jq -r '.data.reportData.report.fights[] | select(.kill == true and .encounterID > 0) | "\(.id)|\(.encounterID)|\(.name)|\(.startTime)|\(.endTime)"' "$REPORT_INFO" | \
while IFS='|' read -r FIGHT_ID ENC_ID FIGHT_NAME START_TIME END_TIME; do
    [ -z "$FIGHT_ID" ] && continue

    BOSS="${ENC_TO_BOSS[$ENC_ID]}"
    [ -z "$BOSS" ] && BOSS=$(echo "$FIGHT_NAME" | tr ' ' '_')

    # Calculate fight duration in ms
    FIGHT_DURATION=$((END_TIME - START_TIME))
    if [ "$FIGHT_DURATION" -le 0 ]; then
        continue
    fi

    # Fetch DamageDone table for player
    PLAYER_TABLE=$(get_damage_table "$REPORT_CODE" "$FIGHT_ID" "$PLAYER_ID")
    sleep 0.1  # Rate limit

    # Get top performer DamageDone table
    TOP_FILE="raw/${REPORT_CODE}/top_performers_by_boss/${SPEC}/${BOSS}_damage.json"
    TOP_TIME=0

    if [ -f "$TOP_FILE" ]; then
        TOP_TIME=$(jq -r '.data.reportData.report.table.data.totalTime // 0' "$TOP_FILE" 2>/dev/null)
    fi

    FIRST_ABILITY=1
    IFS='|' read -ra ABILITY_LIST <<< "$ABILITIES_STR"
    for ability_pair in "${ABILITY_LIST[@]}"; do
        IFS='=' read -r ability ability_type <<< "$ability_pair"

        if [ "$ability_type" == "dot" ]; then
            # Get uptime for DoT
            PLAYER_UPTIME=$(get_ability_uptime "$PLAYER_TABLE" "$ability")
            PLAYER_PCT=$(echo "scale=1; $PLAYER_UPTIME * 100 / $FIGHT_DURATION" | bc 2>/dev/null || echo "0")

            # Get top performer uptime (single-player data, no icon filter needed)
            TOP_PCT="0"
            if [ -f "$TOP_FILE" ] && [ "$TOP_TIME" -gt 0 ]; then
                local_alias="${ABILITY_ALIASES[$ability]}"
                TOP_UPTIME=$(jq -r --arg name "$ability" --arg alias "${local_alias:-$ability}" '
                    .data.reportData.report.table.data.entries[]? |
                    select((.name == $name or .name == $alias) and .uptime != null) |
                    .uptime // 0
                ' "$TOP_FILE" 2>/dev/null | head -1)
                if [ -n "$TOP_UPTIME" ] && [ "$TOP_UPTIME" != "null" ] && [ "$TOP_UPTIME" != "0" ]; then
                    TOP_PCT=$(echo "scale=1; $TOP_UPTIME * 100 / $TOP_TIME" | bc 2>/dev/null || echo "0")
                fi
            fi

            # Calculate gap
            if [ "$TOP_PCT" != "0" ] && [ "$TOP_PCT" != "0.0" ]; then
                GAP=$(echo "scale=0; $PLAYER_PCT - $TOP_PCT" | bc 2>/dev/null || echo "0")
                if [ "$GAP" -gt 0 ] 2>/dev/null; then
                    GAP_STR="+${GAP}%"
                else
                    GAP_STR="${GAP}%"
                fi
            else
                GAP_STR="-"
            fi

            PLAYER_DISPLAY="${PLAYER_PCT}%"
            TOP_DISPLAY="${TOP_PCT}%"
        else
            # Get casts for non-DoT ability
            PLAYER_CASTS=$(get_ability_casts "$PLAYER_TABLE" "$ability")
            PLAYER_CPM=$(echo "scale=1; $PLAYER_CASTS * 60000 / $FIGHT_DURATION" | bc 2>/dev/null || echo "0")

            # Get top performer casts (single-player data, no icon filter needed)
            TOP_CPM="0"
            if [ -f "$TOP_FILE" ] && [ "$TOP_TIME" -gt 0 ]; then
                local_alias="${ABILITY_ALIASES[$ability]}"
                TOP_CASTS=$(jq -r --arg name "$ability" --arg alias "${local_alias:-$ability}" '
                    .data.reportData.report.table.data.entries[]? |
                    select(.name == $name or .name == $alias) |
                    if .uses != null then .uses elif .hitCount > 0 then .hitCount else 0 end
                ' "$TOP_FILE" 2>/dev/null | head -1)
                if [ -n "$TOP_CASTS" ] && [ "$TOP_CASTS" != "null" ] && [ "$TOP_CASTS" != "0" ]; then
                    TOP_CPM=$(echo "scale=1; $TOP_CASTS * 60000 / $TOP_TIME" | bc 2>/dev/null || echo "0")
                fi
            fi

            # Calculate gap
            if [ "$TOP_CPM" != "0" ] && [ "$TOP_CPM" != "0.0" ]; then
                GAP=$(echo "scale=0; ($PLAYER_CPM - $TOP_CPM) * 100 / $TOP_CPM" | bc 2>/dev/null || echo "0")
                if [ "$GAP" -gt 0 ] 2>/dev/null; then
                    GAP_STR="+${GAP}%"
                else
                    GAP_STR="${GAP}%"
                fi
            else
                GAP_STR="-"
            fi

            PLAYER_DISPLAY="$PLAYER_CPM"
            TOP_DISPLAY="$TOP_CPM"
        fi

        # Abbreviate ability name
        short=$(abbreviate "$ability")

        # Show boss name only on first ability
        if [ $FIRST_ABILITY -eq 1 ]; then
            BOSS_DISPLAY="**$BOSS**"
            FIRST_ABILITY=0
        else
            BOSS_DISPLAY=""
        fi

        echo "| $BOSS_DISPLAY | $short | $PLAYER_DISPLAY | $TOP_DISPLAY | $GAP_STR |"
    done
done

echo ""
echo "*CPM = Casts Per Minute, % = Uptime*"
