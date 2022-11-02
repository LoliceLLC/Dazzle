local dazzle = {}

-- Hero detect for HeroesCore
local CoreHero = Heroes.GetLocal()
local IsDazzle = false
if CoreHero then
    IsDazzle = NPC.GetUnitName(CoreHero) == 'npc_dota_hero_dazzle'
end
HeroesCore.UseCurrentPath(IsDazzle)

-- Enbale/Disable
dazzle.Enable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle' }, 'Enable', false)
HeroesCore.AddOptionIcon(dazzle.Enable, '~/MenuIcons/Enable/enable_check_boxed.png')

-- Auto Grave section
dazzle.Percent = HeroesCore.AddOptionSlider({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Percent of max HP', 1, 100, 5)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Auto Shallow Grave' }, 'panorama/images/spellicons/dazzle_shallow_grave_png.vtex_c')
HeroesCore.AddOptionIcon(dazzle.Percent, '~/MenuIcons/bar_ally.png')
-- Use Grave if enemy is nearly
dazzle.NearlyGraveUse = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Use Grave if enemy is nearly', true)
HeroesCore.AddOptionIcon(dazzle.NearlyGraveUse, '~/MenuIcons/horizontal.png')
-- Use Grave in dangerous skills
dazzle.GraveInDangerous = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Grave in dangerous skills', true)
Menu.AddOptionTip(dazzle.GraveInDangerous, 'Supported skills: FingerOfDeath, LagunaBlade, SonicWave')
HeroesCore.AddOptionIcon(dazzle.GraveInDangerous, '~/MenuIcons/skull.png')
-- Auto Grave in FalsePromise
dazzle.GraveInPromise = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Auto grave in FalsePromise', false)
Menu.AddOptionTip(dazzle.GraveInPromise, 'Automatically cast FalsePromise at the end.')
HeroesCore.AddOptionIcon(dazzle.GraveInPromise, 'panorama/images/spellicons/oracle_false_promise_png.vtex_c')

-- Heal section
dazzle.HealBind = HeroesCore.AddKeyOption({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Healing' }, 'Heal target teammates', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddOptionIcon(dazzle.HealBind, '~/MenuIcons/status.png')
dazzle.AbilitiesForHeal = HeroesCore.AddOptionMultiSelect({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Healing' }, 'Abilities for heal:', 
{
    { 'shadow_wave', 'panorama/images/spellicons/dazzle_shadow_wave_png.vtex_c', true },
    { 'bad_juju', 'panorama/images/spellicons/dazzle_bad_juju_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(dazzle.AbilitiesForHeal, '~/MenuIcons/dots.png')
dazzle.ItemsForHeal = HeroesCore.AddOptionMultiSelect({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Healing' }, 'Items for heal:', 
{
    { 'item_holy_locket', 'panorama/images/items/holy_locket_png.vtex_c', true },
    { 'item_mekansm', 'panorama/images/items/mekansm_png.vtex_c', true },
    { 'item_guardian_greaves', 'panorama/images/items/guardian_greaves_png.vtex_c', true },
    { 'item_urn_of_shadows', 'panorama/images/items/urn_of_shadows_png.vtex_c', false },
    { 'item_spirit_vessel', 'panorama/images/items/spirit_vessel_png.vtex_c', false }
}, false)
HeroesCore.AddOptionIcon(dazzle.ItemsForHeal, '~/MenuIcons/dots.png')
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Healing' }, 'panorama/images/spellicons/dazzle_shadow_wave_png.vtex_c')

-- Visual section
dazzle.Panel = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Visual' }, 'Panel', false)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Visual' }, '~/MenuIcons/panel_def.png')
HeroesCore.AddOptionIcon(dazzle.Panel, '~/MenuIcons/Enable/enable_check_boxed.png')
dazzle.MovingButton = HeroesCore.AddKeyOption({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Visual' }, 'Moving button', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddOptionIcon(dazzle.MovingButton, '~/MenuIcons/drag_def.png')

-- Hero face icon
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle' }, 'panorama/images/heroes/icons/npc_dota_hero_dazzle_png.vtex_c')

-- Timer
local Timer = -69696969
local GameTime = nil

-- Hero
local MyHero = nil
local MyTeam = nil
local MyPlayer = nil
local MyMana = nil

-- Render
local _screenW, _screenH = Renderer.GetScreenSize()
local Multiplier = _screenH / 1080

-- Skills
local ShallowGrave = nil
local ShadowWave = nil
local BadJuju = nil

-- Skill range
local GraveRange = 0
local ShadowRange = 0
local BadRange = 0

-- Settings
local HeroSettings = {}

-- Init in game
local function Init()
    if Engine.IsInGame() then
        if IsDazzle then
            MyHero = Heroes.GetLocal()
            MyTeam = Entity.GetTeamNum(MyHero)
            MyPlayer = Players.GetLocal()
        end
    end
end

Init()

function dazzle.OnGameStart()
    Init()
end

function dazzle.GetTeammates()
    local heroes = {}
    for _, hero in pairs(Heroes.GetAll()) do
        if (Entity.IsSameTeam(hero, MyHero)) then
            if (#heroes < 5) then
                table.insert(heroes, hero)
            end
        end
    end
    return heroes
end

local function UpdateInfo()
    MyMana = NPC.GetMana(MyHero)
    ShallowGrave = NPC.GetAbility(MyHero, 'dazzle_shallow_grave')
    ShadowWave = NPC.GetAbility(MyHero, 'dazzle_shadow_wave')
    BadJuju = NPC.GetAbility(MyHero, 'dazzle_bad_juju')
end

local function GetPercent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        return (maxvalue * percent) / 100
    end
    return 696969696969691337 -- erorhendler))))
end

local function GetRadius()
    GraveRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_shallow_grave'))
    ShadowRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_shadow_wave'))
    BadRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_bad_juju'))
end

local function GetTheRightHero() 
    if (Menu.IsEnabled(dazzle.Enable)) then
        for _, FriendlyHeroes in pairs(Heroes.InRadius(Entity.GetOrigin(MyHero), GraveRange, Entity.GetTeamNum(MyTeam), Enum.TeamType.TEAM_FRIEND)) do
            if (HeroSettings[FriendlyHeroes]) then 
                if (HeroSettings[FriendlyHeroes].enabled) then
                    -- Default auto Grave return FriendlyHeroes
                    if Entity.GetHealth(FriendlyHeroes) < GetPercent(Menu.GetValue(dazzle.Percent), Entity.GetMaxHealth(FriendlyHeroes)) then
                        local EnemyHeroes = Entity.GetHeroesInRadius(FriendlyHeroes, 1100, Enum.TeamType.TEAM_ENEMY)
                        if (#EnemyHeroes >= 1 and Menu.IsEnabled(dazzle.NearlyGraveUse)) then
                            return FriendlyHeroes
                        end
                    end
                    -- If dangerous skills ( i don't know if this approach is optimized))) )
                    if (Menu.IsEnabled(dazzle.GraveInDangerous)) then
                        for _, Heroes in pairs(Heroes.GetAll()) do

                            local ModifierProperty = NPC.GetModifierProperty(Heroes, Enum.ModifierFunction.MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE) + NPC.GetModifierProperty(Heroes, Enum.ModifierFunction.MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE)

                            if (NPC.GetUnitName(Heroes) == 'npc_dota_hero_queenofpain' and Ability.IsInAbilityPhase(NPC.GetAbilityByIndex(Heroes, 5))
                            and NPC.IsEntityInRange(Heroes, FriendlyHeroes, Ability.GetCastRange(NPC.GetAbilityByIndex(Heroes, 5)))) then

                                local SW = 0
                                local SWD = 0

                                if (NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed_alchemist')) then
                                    SW = Ability.GetLevelSpecialValueFor(NPC.GetAbilityByIndex(Heroes, 5), 'damage_scepter')
                                    SWD = SW + (ModifierProperty)
                                else
                                    SW = Ability.GetLevelSpecialValueFor(NPC.GetAbilityByIndex(Heroes, 5), 'damage')
                                    SWD = SW + (ModifierProperty)
                                end

                                if (Ability.GetLevel(NPC.GetAbility(Heroes, 'special_bonus_unique_queen_of_pain_2')) > 0) then SWD = SWD + 120 end

                                if (SWD + 150 >= Entity.GetHealth(FriendlyHeroes)) then return FriendlyHeroes end

                            elseif (NPC.GetUnitName(Heroes) == 'npc_dota_hero_lion'
                            and Ability.IsInAbilityPhase(NPC.GetAbilityByIndex(Heroes, 5)) or Ability.IsChannelling(NPC.GetAbilityByIndex(Heroes, 5))
                            and NPC.IsEntityInRange(Heroes, FriendlyHeroes, Ability.GetCastRange(NPC.GetAbilityByIndex(Heroes, 5)))) then

                                local FD = Ability.GetLevelSpecialValueFor(NPC.GetAbilityByIndex(Heroes, 5), 'damage')
                                local FLD = 0

                                local AMP = FD * (ModifierProperty * 0.01)

                                if (NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed_alchemist')) then
                                    local FLA = Ability.GetLevelSpecialValueFor(NPC.GetAbilityByIndex(Heroes, 5), 'damage_scepter')
                                    FD = FLA + AMP
                                    FLD = FD * NPC.GetMagicalArmorDamageMultiplier(FriendlyHeroes)
                                else
                                    FD = FD + AMP
                                    FLD = FD * NPC.GetMagicalArmorDamageMultiplier(FriendlyHeroes)
                                end

                                if FLD + 150 >= Entity.GetHealth(FriendlyHeroes) then return FriendlyHeroes end

                            elseif (NPC.GetUnitName(Heroes) == 'npc_dota_hero_lina'
                            and Ability.IsInAbilityPhase(NPC.GetAbilityByIndex(Heroes, 5)) or Ability.IsChannelling(NPC.GetAbilityByIndex(Heroes, 5))
                            and NPC.IsEntityInRange(FriendlyHeroes, Heroes, Ability.GetCastRange(NPC.GetAbilityByIndex(Heroes, 5)))) then

                                local LB = Ability.GetLevelSpecialValueFor(NPC.GetAbilityByIndex(Heroes, 5), 'damage')
                                local LBAMP = LB * (ModifierProperty * 0.01)
                                local LLD = 0

                                if (NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed') or NPC.HasModifier(Heroes, 'modifier_item_ultimate_scepter_consumed_alchemist')) then
                                    LLD = LB + LBAMP
                                else
                                    LB = LB + LBAMP
                                    LLD = LB * NPC.GetMagicalArmorDamageMultiplier(FriendlyHeroes)
                                end

                                if (LLD + 150 >= Entity.GetHealth(FriendlyHeroes)) then return FriendlyHeroes end
                            end
                        end
                    end
                end
            end
        end
        return false
    end
end

local function GetModifiersDieTimeByName(hero, name)
    Modifiers = NPC.GetModifiers(hero)
    for _, Modifs in pairs(Modifiers) do
        if (Modifier.GetName(Modifs) == name) then
            DieTime = math.floor(((Modifier.GetDieTime(Modifs) - GameRules.GetGameTime()) * 10^1) + 0.5) / (10^1)
            return DieTime
        end
    end
end

function dazzle.OnUpdate()

    if (Menu.IsEnabled(dazzle.Enable)) then

        if MyHero == nil then return end

        if not IsDazzle then return end

        -- Amazing timer
        GameTime = GameRules.GetGameTime()
        if (Timer > GameTime) then return end
        Timer = GameTime + 0.15

        UpdateInfo()
        GetRadius()
        
        -- Return end if hero stuned etc...
        if not Entity.IsAlive(MyHero) 
        or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_SILENCED)
        or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_MUTED)
        or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_STUNNED)
        or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_HEXED)
        or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_NIGHTMARED)
        or NPC.HasModifier(MyHero, 'modifier_obsidian_destroyer_astral_imprisonment_prison')
        or NPC.HasModifier(MyHero, 'modifier_teleporting')
        or NPC.HasModifier(MyHero, 'modifier_pudge_swallow_hide')
        or NPC.HasModifier(MyHero, 'modifier_axe_berserkers_call')
        then return end

        -- Target healing
        FriendlyTarget = HeroesCore.GetTarget(MyTeam, Enum.TeamType.TEAM_FRIEND)

        if (Menu.IsKeyDown(dazzle.HealBind)) then
            for i, Items in pairs(Menu.GetItems(dazzle.ItemsForHeal)) do
                if (Menu.IsSelected(dazzle.ItemsForHeal, Items)) then
                    if (Ability.IsCastable(NPC.GetItem(MyHero, tostring(Items)), MyMana)) then
                        if (NPC.IsEntityInRange(FriendlyTarget, MyHero, 1100)) then
                            if (Items == 'item_mekansm' or Items == 'item_guardian_greaves') then
                                Ability.CastNoTarget(NPC.GetItem(MyHero, tostring(Items)))
                            elseif (Items == 'item_urn_of_shadows' or Items == 'item_spirit_vessel') then
                                if (Item.GetCurrentCharges(NPC.GetItem(MyHero, tostring(Items))) > 0) then
                                    if not (NPC.HasModifier(FriendlyTarget, 'modifier_item_spirit_vessel_heal') or NPC.HasModifier(FriendlyTarget, 'modifier_item_urn_heal')) then
                                        Ability.CastTarget(NPC.GetItem(MyHero, tostring(Items)), FriendlyTarget)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            local CastStep = 1

            if (CastStep == 1) then
                if (Ability.IsCastable(ShadowWave, MyMana) and Menu.IsSelected(dazzle.AbilitiesForHeal, 'shadow_wave')) then
                    Ability.CastTarget(ShadowWave, FriendlyTarget)
                else
                    CastStep = 2
                end
            end

            if (CastStep == 2) then
                if (Ability.IsCastable(BadJuju, MyMana) and Menu.IsSelected(dazzle.AbilitiesForHeal, 'bad_juju') and NPC.IsEntityInRange(FriendlyTarget, MyHero, BadRange)) then
                    Ability.CastNoTarget(BadJuju)
                end 
            end
        end

        local RightHero = GetTheRightHero()

        -- Return if hero not available to cast Grave
        if not Entity.IsAlive(RightHero) 
        or NPC.HasModifier(RightHero, 'modifier_pudge_swallow_hide')
        or NPC.HasModifier(RightHero, 'modifier_obsidian_destroyer_astral_imprisonment_prison')
        or NPC.HasModifier(RightHero, 'modifier_puck_phase_shift')
        or NPC.HasModifier(RightHero, 'modifier_life_stealer_infest')
        or NPC.HasModifier(RightHero, 'modifier_juggernaut_omnislash')
        or NPC.HasModifier(RightHero, 'modifier_shadow_demon_disruption')
        or NPC.HasModifier(RightHero, 'modifier_eul_cyclone') or NPC.HasModifier(RightHero, 'modifier_wind_waker')
        or NPC.HasModifier(RightHero, 'modifier_item_book_of_shadows_buff')
        or NPC.HasModifier(RightHero, 'modifier_dark_willow_shadow_realm_buff')
        or NPC.HasModifier(RightHero, 'modifier_void_spirit_dissimilate_phase')
        or NPC.HasModifier(RightHero, 'modifier_earth_spirit_stone_thinker')
        or NPC.HasModifier(RightHero, 'modifier_phoenix_supernova_hiding')
        or NPC.HasModifier(RightHero, 'modifier_snapfire_gobble_up_creep')
        or NPC.HasModifier(RightHero, 'modifier_invoker_tornado')
        or NPC.HasModifier(RightHero, 'modifier_visage_summon_familiars_stone_form_buff')
        then return end

        -- Auto Grave
        if (Ability.IsCastable(ShallowGrave, MyMana)) then
            if not NPC.HasModifier(RightHero, 'modifier_dazzle_shallow_grave') then
                if (Menu.IsEnabled(dazzle.GraveInPromise)) then
                    if (NPC.HasModifier(RightHero, 'modifier_oracle_false_promise_timer') and GetModifiersDieTimeByName(RightHero, 'modifier_oracle_false_promise_timer') < 1) then
                        Ability.CastTarget(ShallowGrave, RightHero)
                    elseif (not NPC.HasModifier(RightHero, 'modifier_oracle_false_promise_timer')) then
                        Ability.CastTarget(ShallowGrave, RightHero)
                    end
                else
                    Ability.CastTarget(ShallowGrave, RightHero)
                end
            end
        end
    end
end

local configName = 'cum_mega_dazzle_panel_positions'

local UI = {
    x = Config.ReadInt(configName, 'x', 200),
    y = Config.ReadInt(configName, 'y', 200),
    Width = 234,
    Height = 54,
    HeroBgW = 36,
    HeroBgH = 36,
    HeroW = 30,
    HeroH = 30,
    ToggleW = 42,
    ToggleH = 42,
    MoveW = 0,
    MoveH = 0,
    IsMoving = false,
}

function dazzle.ScreenClamp(x, y)
    if (x < 0) then
        x = 0
    end
    if (x + UI.Width > _screenW) then
        x = _screenW - UI.Width
    end
    if (y < 0) then
        y = 0
    end
    if (y + UI.Height > _screenH) then
        y = _screenH - UI.Height
    end

    return x, y
end

function dazzle.MovingManager()
    if (UI.IsMoving and Menu.IsKeyDown(dazzle.MovingButton) and Input.IsKeyDown(Enum.ButtonCode.KEY_MOUSE1)) then
        local w, h = Input.GetCursorPos()
        UI.x = UI.x - (UI.MoveW - w)
        UI.y = UI.y - (UI.MoveH - h)

        UI.x, UI.y = dazzle.ScreenClamp(UI.x, UI.y)

        Config.WriteInt(configName, 'x', UI.x)
        Config.WriteInt(configName, 'y', UI.y)
        UI.MoveW = w
        UI.MoveH = h    
    else
        UI.IsMoving = false
    end
end

-- Please fix renderer functions and make antialiasing 🙏🙏🙏🙏
local MainBackground = Renderer.LoadImage('~/dazzle/background.png')
local HeroBackground =  Renderer.LoadImage('~/dazzle/bg.png')
local ToggleOn = Renderer.LoadImage('~/dazzle/toggle_on.png')
local ToggleOff = Renderer.LoadImage('~/dazzle/toggle_off.png')

function dazzle.DrawUI()
    UI.x, UI.y = dazzle.ScreenClamp(UI.x, UI.y)
    local x = UI.x

    Renderer.SetDrawColor(255, 255, 255, 255)
    Renderer.DrawImage(MainBackground, x, UI.y, UI.Width * Multiplier, UI.Height * Multiplier)

    local Heroes = dazzle.GetTeammates()

    x = x + (9 * Multiplier)

    local HeroImage = {}

    for _, Hero in pairs(Heroes) do

        if (not HeroSettings[Hero]) then
            HeroSettings[Hero] = {
                enabled = true 
            }
        end

        Renderer.SetDrawColor(255, 255, 255, 255)
        Renderer.DrawImage(HeroBackground, x, UI.y + 9, UI.HeroBgW * Multiplier, UI.HeroBgH * Multiplier)

        if (HeroSettings[Hero].enabled) then
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(ToggleOn, x - 3, UI.y + 6, UI.ToggleW * Multiplier, UI.ToggleH * Multiplier)
        else
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(ToggleOff, x - 3, UI.y + 6, UI.ToggleW * Multiplier, UI.ToggleH * Multiplier)
        end
        
        if (Input.IsCursorInRect(x, UI.y, UI.HeroBgW * Multiplier, UI.HeroBgH * Multiplier)) then
            if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
                HeroSettings[Hero].enabled = not HeroSettings[Hero].enabled
            end
        end

        if (not HeroImage[NPC.GetUnitName(Hero)]) then
            HeroImage[NPC.GetUnitName(Hero)] = Renderer.LoadImage('~/heroes_circle/' .. string.gsub(NPC.GetUnitName(Hero), 'npc_dota_hero_', '') .. '.png')
        end

        if (HeroSettings[Hero].enabled) then
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(HeroImage[NPC.GetUnitName(Hero)], x + 3, UI.y + 12, UI.HeroW * Multiplier, UI.HeroH * Multiplier)
        else
            Renderer.SetDrawColor(100, 100, 100, 255)
            Renderer.DrawImage(HeroImage[NPC.GetUnitName(Hero)], x + 3, UI.y + 12, UI.HeroW * Multiplier, UI.HeroH * Multiplier)
        end

        x = x + 36 + 9
    end

    if (Input.IsCursorInRect(UI.x, UI.y, UI.Width, UI.Height) and not UI.IsMoving and Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
        UI.IsMoving = true
        UI.MoveW, UI.MoveH = Input.GetCursorPos()
    end
end

function dazzle.OnDraw()
    if ((Engine.IsInGame() and Menu.IsEnabled(dazzle.Enable) and Menu.IsEnabled(dazzle.Panel)) and IsDazzle) then
        dazzle.MovingManager()
        dazzle.DrawUI()
    end
end

return dazzle
