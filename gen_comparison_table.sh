#!/bin/bash
# Generate per-boss rotation comparison table vs top performers
# Uses WCL events API directly (more reliable than table API)
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

# Spec to spell IDs mapping (ability_name=spell_id)
declare -A SPEC_ABILITIES
SPEC_ABILITIES["shadow_priest"]="Mind Blast=8092|Vampiric Touch=34914|Shadow Word: Pain=589|Devouring Plague=2944|Mind Flay=15407|Mind Flay (Insanity)=129197"
SPEC_ABILITIES["arms_warrior"]="Mortal Strike=12294|Colossus Smash=86346|Overpower=7384|Slam=1464|Execute=5308"
SPEC_ABILITIES["fury_warrior"]="Bloodthirst=23881|Raging Blow=85288|Colossus Smash=86346|Wild Strike=100130|Execute=5308"
SPEC_ABILITIES["frost_dk"]="Obliterate=49020|Frost Strike=49143|Howling Blast=49184|Soul Reaper=114866"
SPEC_ABILITIES["unholy_dk"]="Scourge Strike=55090|Festering Strike=85948|Death Coil=47541|Soul Reaper=114866"
SPEC_ABILITIES["survival_hunter"]="Explosive Shot=53301|Black Arrow=3674|Cobra Shot=77767|Arcane Shot=3044|Kill Shot=53351"
SPEC_ABILITIES["bm_hunter"]="Kill Command=34026|Arcane Shot=3044|Cobra Shot=77767|Kill Shot=53351"
SPEC_ABILITIES["mm_hunter"]="Chimera Shot=53209|Aimed Shot=19434|Steady Shot=56641|Kill Shot=53351"
SPEC_ABILITIES["destro_warlock"]="Chaos Bolt=116858|Conflagrate=17962|Incinerate=29722|Immolate=348|Shadowburn=17877"
SPEC_ABILITIES["demo_warlock"]="Soul Fire=6353|Shadow Bolt=686|Hand of Gul'dan=105174|Touch of Chaos=103964|Corruption=172"
SPEC_ABILITIES["afflic_warlock"]="Malefic Grasp=103103|Unstable Affliction=30108|Agony=980|Corruption=172|Haunt=48181"
SPEC_ABILITIES["elemental_shaman"]="Lava Burst=51505|Lightning Bolt=403|Flame Shock=8050|Earth Shock=8042|Chain Lightning=421"
SPEC_ABILITIES["enhance_shaman"]="Stormstrike=17364|Lava Lash=60103|Earth Shock=8042|Flame Shock=8050|Lightning Bolt=403"
SPEC_ABILITIES["fire_mage"]="Fireball=133|Pyroblast=11366|Living Bomb=44457|Scorch=2948|Combustion=11129"
SPEC_ABILITIES["arcane_mage"]="Arcane Blast=30451|Arcane Missiles=5143|Arcane Barrage=44425"
SPEC_ABILITIES["frost_mage"]="Frostbolt=116|Ice Lance=30455|Frostfire Bolt=44614|Frozen Orb=84714"
SPEC_ABILITIES["subtlety_rogue"]="Backstab=53|Ambush=8676|Eviscerate=2098|Rupture=1943|Shadow Dance=51713"
SPEC_ABILITIES["assassination_rogue"]="Mutilate=1329|Envenom=32645|Rupture=1943|Dispatch=111240"
SPEC_ABILITIES["combat_rogue"]="Sinister Strike=1752|Revealing Strike=84617|Eviscerate=2098|Killing Spree=51690"
SPEC_ABILITIES["ret_paladin"]="Crusader Strike=35395|Judgment=20271|Templar's Verdict=85256|Exorcism=879|Hammer of Wrath=24275"
SPEC_ABILITIES["balance_druid"]="Wrath=5176|Starfire=2912|Starsurge=78674|Moonfire=8921|Sunfire=93402"
SPEC_ABILITIES["feral_druid"]="Shred=5221|Rake=1822|Rip=1079|Ferocious Bite=22568|Savage Roar=52610"
SPEC_ABILITIES["windwalker_monk"]="Jab=100780|Tiger Palm=100787|Blackout Kick=100784|Rising Sun Kick=107428|Fists of Fury=113656"

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

# Function to get cast count from events API
get_casts() {
    local report="$1"
    local fight_id="$2"
    local source_id="$3"
    local spell_id="$4"

    local result=$(curl -s -X POST "https://classic.warcraftlogs.com/api/v2/client" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"query\": \"{ reportData { report(code: \\\"${report}\\\") { events(dataType: Casts, fightIDs: [${fight_id}], sourceID: ${source_id}, abilityID: ${spell_id}, limit: 1000) { data } } } }\"}" 2>/dev/null | \
        jq '.data.reportData.report.events.data | length' 2>/dev/null)

    echo "${result:-0}"
}

# Abbreviation mapping
abbreviate() {
    echo "$1" | sed '
        s/Mind Blast/MB/; s/Vampiric Touch/VT/; s/Shadow Word: Pain/SWP/; s/Devouring Plague/DP/;
        s/Mind Flay (Insanity)/MFI/; s/Mind Flay/MF/; s/Mortal Strike/MS/; s/Colossus Smash/CS/;
        s/Explosive Shot/ES/; s/Black Arrow/BA/; s/Cobra Shot/CoS/; s/Arcane Shot/AS/; s/Kill Shot/KS/;
        s/Chaos Bolt/CB/; s/Conflagrate/Conf/; s/Incinerate/Inc/; s/Shadowburn/SB/; s/Immolate/Immo/;
        s/Soul Fire/SF/; s/Shadow Bolt/ShB/; s/Hand of Gul.dan/HoG/; s/Touch of Chaos/ToC/;
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

    # Get top performer info
    TOP_FILE="raw/${REPORT_CODE}/top_performers_by_boss/${SPEC}/${BOSS}_casts.json"
    TOP_TIME=0
    TOP_PLAYER_ID=""
    TOP_REPORT=""

    if [ -f "$TOP_FILE" ]; then
        TOP_TIME=$(jq -r '.data.reportData.report.table.data.totalTime // 0' "$TOP_FILE" 2>/dev/null)
        # Get top performer's report code and player ID from the file path or content
        TOP_REPORT=$(basename "$(dirname "$(dirname "$TOP_FILE")")" 2>/dev/null)
    fi

    FIRST_ABILITY=1
    IFS='|' read -ra ABILITY_LIST <<< "$ABILITIES_STR"
    for ability_pair in "${ABILITY_LIST[@]}"; do
        IFS='=' read -r ability spell_id <<< "$ability_pair"

        # Get player casts from events API
        PLAYER_CASTS=$(get_casts "$REPORT_CODE" "$FIGHT_ID" "$PLAYER_ID" "$spell_id")
        sleep 0.05  # Rate limit

        # Calculate player CPM
        PLAYER_CPM=$(echo "scale=1; $PLAYER_CASTS * 60000 / $FIGHT_DURATION" | bc 2>/dev/null || echo "0")

        # Get top performer casts from table (fallback, may be incomplete)
        TOP_CASTS=0
        if [ -f "$TOP_FILE" ] && [ -n "$SPEC_ICON" ]; then
            TOP_CASTS=$(jq -r --arg name "$ability" --arg icon "$SPEC_ICON" '
                .data.reportData.report.table.data.entries[] |
                select(.icon == $icon) |
                .abilities[]? |
                select(.name == $name) |
                .total // 0
            ' "$TOP_FILE" 2>/dev/null | head -1)
        fi

        if [ -z "$TOP_CASTS" ] || [ "$TOP_CASTS" == "null" ]; then
            TOP_CASTS=0
        fi

        # Calculate top CPM
        TOP_CPM="0"
        if [ "$TOP_TIME" -gt 0 ] && [ "$TOP_TIME" != "null" ]; then
            TOP_CPM=$(echo "scale=1; $TOP_CASTS * 60000 / $TOP_TIME" | bc 2>/dev/null || echo "0")
        fi

        # Calculate gap
        if [ "$TOP_CPM" != "0" ] && [ "$TOP_CPM" != "0.0" ] && [ -n "$TOP_CPM" ]; then
            GAP=$(echo "scale=0; ($PLAYER_CPM - $TOP_CPM) * 100 / $TOP_CPM" | bc 2>/dev/null || echo "0")
            if [ "$GAP" -gt 0 ] 2>/dev/null; then
                GAP_STR="+${GAP}%"
            else
                GAP_STR="${GAP}%"
            fi
        else
            GAP_STR="-"
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

        echo "| $BOSS_DISPLAY | $short | $PLAYER_CPM | $TOP_CPM | $GAP_STR |"
    done
done

echo ""
echo "*CPM = Casts Per Minute*"
