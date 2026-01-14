#!/bin/bash
# Generate per-boss rotation comparison table vs top performers
# Usage: ./gen_comparison_table.sh <player_id> <spec> [report_code]

PLAYER_ID="$1"
SPEC="$2"
REPORT_CODE="${3:-73LvphDmkPZzNX6V}"

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

# Spec-specific key abilities, class mapping, and icon mapping
declare -A ABILITIES
declare -A SPEC_CLASS
declare -A SPEC_ICON
ABILITIES["shadow_priest"]="Mind Blast|Vampiric Touch|Shadow Word: Pain|Devouring Plague|Mind Flay|Mind Flay (Insanity)"
SPEC_CLASS["shadow_priest"]="Priest"
SPEC_ICON["shadow_priest"]="Priest-Shadow"
ABILITIES["arms_warrior"]="Mortal Strike|Colossus Smash|Overpower|Slam|Execute"
SPEC_CLASS["arms_warrior"]="Warrior"
SPEC_ICON["arms_warrior"]="Warrior-Arms"
ABILITIES["fury_warrior"]="Bloodthirst|Raging Blow|Colossus Smash|Wild Strike|Execute"
SPEC_CLASS["fury_warrior"]="Warrior"
SPEC_ICON["fury_warrior"]="Warrior-Fury"
ABILITIES["frost_dk"]="Obliterate|Frost Strike|Howling Blast|Soul Reaper"
SPEC_CLASS["frost_dk"]="DeathKnight"
SPEC_ICON["frost_dk"]="DeathKnight-Frost"
ABILITIES["unholy_dk"]="Scourge Strike|Festering Strike|Death Coil|Soul Reaper"
SPEC_CLASS["unholy_dk"]="DeathKnight"
SPEC_ICON["unholy_dk"]="DeathKnight-Unholy"
ABILITIES["survival_hunter"]="Explosive Shot|Black Arrow|Cobra Shot|Arcane Shot|Kill Shot"
SPEC_CLASS["survival_hunter"]="Hunter"
SPEC_ICON["survival_hunter"]="Hunter-Survival"
ABILITIES["bm_hunter"]="Kill Command|Arcane Shot|Cobra Shot|Kill Shot"
SPEC_CLASS["bm_hunter"]="Hunter"
SPEC_ICON["bm_hunter"]="Hunter-BeastMastery"
ABILITIES["mm_hunter"]="Chimera Shot|Aimed Shot|Steady Shot|Kill Shot"
SPEC_CLASS["mm_hunter"]="Hunter"
SPEC_ICON["mm_hunter"]="Hunter-Marksmanship"
ABILITIES["destro_warlock"]="Chaos Bolt|Conflagrate|Incinerate|Immolate|Shadowburn"
SPEC_CLASS["destro_warlock"]="Warlock"
SPEC_ICON["destro_warlock"]="Warlock-Destruction"
ABILITIES["demo_warlock"]="Soul Fire|Shadow Bolt|Hand of Gul'dan|Touch of Chaos|Corruption"
SPEC_CLASS["demo_warlock"]="Warlock"
SPEC_ICON["demo_warlock"]="Warlock-Demonology"
ABILITIES["afflic_warlock"]="Malefic Grasp|Unstable Affliction|Agony|Corruption|Haunt"
SPEC_CLASS["afflic_warlock"]="Warlock"
SPEC_ICON["afflic_warlock"]="Warlock-Affliction"
ABILITIES["elemental_shaman"]="Lava Burst|Lightning Bolt|Flame Shock|Earth Shock|Chain Lightning"
SPEC_CLASS["elemental_shaman"]="Shaman"
SPEC_ICON["elemental_shaman"]="Shaman-Elemental"
ABILITIES["enhance_shaman"]="Stormstrike|Lava Lash|Earth Shock|Flame Shock|Lightning Bolt"
SPEC_CLASS["enhance_shaman"]="Shaman"
SPEC_ICON["enhance_shaman"]="Shaman-Enhancement"
ABILITIES["fire_mage"]="Fireball|Pyroblast|Living Bomb|Scorch|Combustion"
SPEC_CLASS["fire_mage"]="Mage"
SPEC_ICON["fire_mage"]="Mage-Fire"
ABILITIES["arcane_mage"]="Arcane Blast|Arcane Missiles|Arcane Barrage"
SPEC_CLASS["arcane_mage"]="Mage"
SPEC_ICON["arcane_mage"]="Mage-Arcane"
ABILITIES["frost_mage"]="Frostbolt|Ice Lance|Frostfire Bolt|Frozen Orb"
SPEC_CLASS["frost_mage"]="Mage"
SPEC_ICON["frost_mage"]="Mage-Frost"
ABILITIES["subtlety_rogue"]="Backstab|Ambush|Eviscerate|Rupture|Shadow Dance"
SPEC_CLASS["subtlety_rogue"]="Rogue"
SPEC_ICON["subtlety_rogue"]="Rogue-Subtlety"
ABILITIES["assassination_rogue"]="Mutilate|Envenom|Rupture|Dispatch"
SPEC_CLASS["assassination_rogue"]="Rogue"
SPEC_ICON["assassination_rogue"]="Rogue-Assassination"
ABILITIES["combat_rogue"]="Sinister Strike|Revealing Strike|Eviscerate|Killing Spree"
SPEC_CLASS["combat_rogue"]="Rogue"
SPEC_ICON["combat_rogue"]="Rogue-Combat"
ABILITIES["ret_paladin"]="Crusader Strike|Judgment|Templar's Verdict|Exorcism|Hammer of Wrath"
SPEC_CLASS["ret_paladin"]="Paladin"
SPEC_ICON["ret_paladin"]="Paladin-Retribution"
ABILITIES["balance_druid"]="Wrath|Starfire|Starsurge|Moonfire|Sunfire"
SPEC_CLASS["balance_druid"]="Druid"
SPEC_ICON["balance_druid"]="Druid-Balance"
ABILITIES["feral_druid"]="Shred|Rake|Rip|Ferocious Bite|Savage Roar"
SPEC_CLASS["feral_druid"]="Druid"
SPEC_ICON["feral_druid"]="Druid-Feral"
ABILITIES["windwalker_monk"]="Jab|Tiger Palm|Blackout Kick|Rising Sun Kick|Fists of Fury"
SPEC_CLASS["windwalker_monk"]="Monk"
SPEC_ICON["windwalker_monk"]="Monk-Windwalker"

KEY_ABILITIES="${ABILITIES[$SPEC]}"
CLASS="${SPEC_CLASS[$SPEC]}"
ICON="${SPEC_ICON[$SPEC]}"
if [ -z "$KEY_ABILITIES" ]; then
    echo "Unknown spec: $SPEC"
    exit 1
fi

REPORT_INFO="raw/${REPORT_CODE}/report_info.json"
if [ ! -f "$REPORT_INFO" ]; then
    echo "No report_info.json found"
    exit 1
fi

echo "#### Per-Boss Rotation Analysis vs Top Performers"
echo ""
echo "| Boss | Ability | You | Top | Gap |"
echo "|------|---------|-----|-----|-----|"

# Get kills from report_info and iterate
jq -r '.data.reportData.report.fights[] | select(.kill == true and .encounterID > 0) | "\(.id)|\(.encounterID)|\(.name)"' "$REPORT_INFO" | \
while IFS='|' read -r FIGHT_ID ENC_ID FIGHT_NAME; do
    [ -z "$FIGHT_ID" ] && continue

    BOSS="${ENC_TO_BOSS[$ENC_ID]}"
    [ -z "$BOSS" ] && BOSS=$(echo "$FIGHT_NAME" | tr ' ' '_')

    # Find cast file for this fight
    CAST_DIR="raw/${REPORT_CODE}/casts_by_fight"
    FIGHT_FOLDER=$(ls -d "$CAST_DIR"/*_${FIGHT_ID} 2>/dev/null | head -1)

    if [ -z "$FIGHT_FOLDER" ] || [ ! -f "$FIGHT_FOLDER/casts.json" ]; then
        continue
    fi

    CASTS_FILE="$FIGHT_FOLDER/casts.json"
    TOP_FILE="raw/${REPORT_CODE}/top_performers_by_boss/${SPEC}/${BOSS}_casts.json"

    # Get total time
    TOTAL_TIME=$(jq -r '.data.reportData.report.table.data.totalTime // 0' "$CASTS_FILE")
    if [ "$TOTAL_TIME" == "0" ] || [ "$TOTAL_TIME" == "null" ]; then
        continue
    fi

    TOP_TIME=$(jq -r '.data.reportData.report.table.data.totalTime // 0' "$TOP_FILE" 2>/dev/null)

    FIRST_ABILITY=1
    IFS='|' read -ra ABILITY_LIST <<< "$KEY_ABILITIES"
    for ability in "${ABILITY_LIST[@]}"; do
        # Get player casts for this ability
        PLAYER_CASTS=$(jq -r --arg name "$ability" --arg pid "$PLAYER_ID" '
            .data.reportData.report.table.data.entries[] |
            select(.id == ($pid | tonumber)) |
            .abilities[]? |
            select(.name == $name) |
            .total // 0
        ' "$CASTS_FILE" 2>/dev/null | head -1)

        if [ -z "$PLAYER_CASTS" ] || [ "$PLAYER_CASTS" == "null" ]; then
            PLAYER_CASTS=0
        fi

        # Special handling for abilities missing from WCL table API - fetch from events API
        # Map ability names to spell IDs for fallback
        FALLBACK_SPELL_ID=""
        case "$ability" in
            "Devouring Plague") FALLBACK_SPELL_ID=2944 ;;
            "Dispatch") FALLBACK_SPELL_ID=111240 ;;
            "Kill Shot") FALLBACK_SPELL_ID=53351 ;;
            "Execute") FALLBACK_SPELL_ID=5308 ;;
            "Corruption") FALLBACK_SPELL_ID=172 ;;
            "Shadowburn") FALLBACK_SPELL_ID=17877 ;;
            "Hammer of Wrath") FALLBACK_SPELL_ID=24275 ;;
        esac

        if [ -n "$FALLBACK_SPELL_ID" ] && [ "$PLAYER_CASTS" -eq 0 ]; then
            TOKEN=$(cat /tmp/wcl_token.txt 2>/dev/null)
            if [ -n "$TOKEN" ]; then
                EVENTS_CASTS=$(curl -s -X POST "https://classic.warcraftlogs.com/api/v2/client" \
                    -H "Authorization: Bearer $TOKEN" \
                    -H "Content-Type: application/json" \
                    -d "{\"query\": \"{ reportData { report(code: \\\"${REPORT_CODE}\\\") { events(dataType: Casts, fightIDs: [${FIGHT_ID}], sourceID: ${PLAYER_ID}, abilityID: ${FALLBACK_SPELL_ID}) { data } } } }\"}" 2>/dev/null | \
                    jq '.data.reportData.report.events.data | length' 2>/dev/null)
                if [ -n "$EVENTS_CASTS" ] && [ "$EVENTS_CASTS" -gt 0 ] 2>/dev/null; then
                    PLAYER_CASTS=$EVENTS_CASTS
                fi
                sleep 0.1
            fi
        fi

        # Calculate player CPM
        if [ "$TOTAL_TIME" -gt 0 ]; then
            PLAYER_CPM=$(echo "scale=1; $PLAYER_CASTS * 60000 / $TOTAL_TIME" | bc 2>/dev/null || echo "0")
        else
            PLAYER_CPM="0"
        fi

        # Get top performer casts (filter by spec icon if available, otherwise by class)
        if [ -n "$ICON" ]; then
            TOP_CASTS=$(jq -r --arg name "$ability" --arg icon "$ICON" '
                .data.reportData.report.table.data.entries[] |
                select(.icon == $icon) |
                .abilities[]? |
                select(.name == $name) |
                .total // 0
            ' "$TOP_FILE" 2>/dev/null | head -1)
        else
            TOP_CASTS=$(jq -r --arg name "$ability" --arg class "$CLASS" '
                .data.reportData.report.table.data.entries[] |
                select(.type == $class) |
                .abilities[]? |
                select(.name == $name) |
                .total // 0
            ' "$TOP_FILE" 2>/dev/null | head -1)
        fi

        if [ -z "$TOP_CASTS" ] || [ "$TOP_CASTS" == "null" ]; then
            TOP_CASTS=0
        fi

        # Calculate top CPM
        if [ "$TOP_TIME" -gt 0 ] && [ "$TOP_TIME" != "null" ]; then
            TOP_CPM=$(echo "scale=1; $TOP_CASTS * 60000 / $TOP_TIME" | bc 2>/dev/null || echo "0")
        else
            TOP_CPM="0"
        fi

        # Calculate gap
        if [ "$TOP_CPM" != "0" ] && [ -n "$TOP_CPM" ]; then
            GAP=$(echo "scale=0; ($PLAYER_CPM - $TOP_CPM) * 100 / $TOP_CPM" | bc 2>/dev/null || echo "0")
            if [ "$GAP" -gt 0 ]; then
                GAP_STR="+${GAP}%"
            else
                GAP_STR="${GAP}%"
            fi
        else
            GAP_STR="-"
        fi

        # Abbreviate ability name
        short=$(echo "$ability" | sed '
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
        ')

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
