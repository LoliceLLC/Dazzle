local dazzle = {}

-- Hero detect for HeroesCore
local CoreHero = Heroes.GetLocal()
local IsDazzle = false
if (CoreHero) then
    IsDazzle = NPC.GetUnitName(CoreHero) == 'npc_dota_hero_dazzle'
end
HeroesCore.UseCurrentPath(IsDazzle)

-- Enable/Disable
dazzle.Enable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle' }, 'Enable', false)
HeroesCore.AddOptionIcon(dazzle.Enable, '~/MenuIcons/Enable/enable_check_boxed.png')

-- Combo section
dazzle.ComboBind = HeroesCore.AddKeyOption({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Combo' }, 'Combo key', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Combo' }, '~/MenuIcons/enemy_evil.png')
HeroesCore.AddOptionIcon(dazzle.ComboBind, '~/MenuIcons/status.png')
-- Abilities for combo
dazzle.AbilitiesForCombo = HeroesCore.AddOptionMultiSelect({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Combo' }, 'Skills for combo:', 
{
    { 'poison_touch', 'panorama/images/spellicons/dazzle_poison_touch_png.vtex_c', true },
    { 'shadow_wave', 'panorama/images/spellicons/dazzle_shadow_wave_png.vtex_c', true },
    { 'bad_juju', 'panorama/images/spellicons/dazzle_bad_juju_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(dazzle.AbilitiesForCombo, '~/MenuIcons/dots.png')
-- Items for combo
dazzle.ItemsForCombo = HeroesCore.AddOptionMultiSelect({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Combo' }, 'Items for combo:', 
{
    { 'item_orchid', 'panorama/images/items/orchid_png.vtex_c', true },
    { 'item_bloodthorn', 'panorama/images/items/bloodthorn_png.vtex_c', true },
    { 'item_rod_of_atos', 'panorama/images/items/rod_of_atos_png.vtex_c', true },
    { 'item_sheepstick', 'panorama/images/items/sheepstick_png.vtex_c', true },
    { 'item_nullifier', 'panorama/images/items/nullifier_png.vtex_c', true },
    { 'item_gungir', 'panorama/images/items/gungir_png.vtex_c', true },
    { 'item_veil_of_discord', 'panorama/images/items/veil_of_discord_png.vtex_c', true },
    { 'item_shivas_guard', 'panorama/images/items/shivas_guard_png.vtex_c', true },
    { 'item_ancient_janggo', 'panorama/images/items/ancient_janggo_png.vtex_c', true },
    { 'item_heavens_halberd', 'panorama/images/items/heavens_halberd_png.vtex_c', true },
    { 'item_mjollnir', 'panorama/images/items/mjollnir_png.vtex_c', true },
    { 'item_medallion_of_courage', 'panorama/images/items/medallion_of_courage_png.vtex_c', true },
    { 'item_solar_crest', 'panorama/images/items/solar_crest_png.vtex_c', true },
    { 'item_diffusal_blade', 'panorama/images/items/diffusal_blade_png.vtex_c', true },
    { 'item_satanic', 'panorama/images/items/satanic_png.vtex_c', true },
    { 'item_black_king_bar', 'panorama/images/items/black_king_bar_png.vtex_c', false }
}, false)
HeroesCore.AddOptionIcon(dazzle.ItemsForCombo, '~/MenuIcons/dots.png')
Menu.AddOptionTip(dazzle.ItemsForCombo, 'You can move items on LMB to change priority!')
-- Satanic settings
dazzle.SatanicUsagePercent = HeroesCore.AddOptionSlider({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo' }, 'Percent HP for use Satanic', 1, 100, 25)
HeroesCore.AddOptionIcon(dazzle.SatanicUsagePercent, '~/MenuIcons/bar_enemy.png')
-- Combo in lotus
dazzle.ComboInLotusEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo' }, 'Combo in LotusOrb', false)
HeroesCore.AddOptionIcon(dazzle.ComboInLotusEnable, 'panorama/images/items/lotus_orb_png.vtex_c')
Menu.AddOptionTip(dazzle.ComboInLotusEnable, 'If you are immune to magic, the combo will work in LotusOrb.')
-- Combo in mirror shield
dazzle.ComboInMirrorShieldEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo' }, 'Combo in MirrorShield', false)
HeroesCore.AddOptionIcon(dazzle.ComboInMirrorShieldEnable, 'panorama/images/items/mirror_shield_png.vtex_c')
Menu.AddOptionTip(dazzle.ComboInMirrorShieldEnable, 'If you are immune to magic, the combo will work in MirrorShield.')

-- Linken breaker
dazzle.LinkenBreakerEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence', 'Dazzle',  'Combo', 'Linken breaker' }, 'Enable', false)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Combo', 'Linken breaker' }, '~/MenuIcons/dota/linken.png')
HeroesCore.AddOptionIcon(dazzle.LinkenBreakerEnable, '~/MenuIcons/Enable/enable_check_boxed.png')
-- Items for linken breaker
dazzle.ItemsForLinkenBreaker = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Intelligence', 'Dazzle', 'Combo', 'Linken breaker'}, 'Items:', 
{
    { 'item_heavens_halberd', 'panorama/images/items/heavens_halberd_png.vtex_c', true },
    { 'item_wind_waker', 'panorama/images/items/wind_waker_png.vtex_c', true },
    { 'item_cyclone', 'panorama/images/items/cyclone_png.vtex_c', true },
    { 'item_hurricane_pike', 'panorama/images/items/hurricane_pike_png.vtex_c', true },
    { 'item_force_staff', 'panorama/images/items/force_staff_png.vtex_c', true },
    { 'item_diffusal_blade', 'panorama/images/items/diffusal_blade_png.vtex_c', true },
    { 'item_bloodthorn', 'panorama/images/items/bloodthorn_png.vtex_c', true },
    { 'item_rod_of_atos', 'panorama/images/items/rod_of_atos_png.vtex_c', true },
    { 'item_sheepstick', 'panorama/images/items/sheepstick_png.vtex_c', true },
    { 'item_nullifier', 'panorama/images/items/nullifier_png.vtex_c', true },
    { 'item_ethereal_blade', 'panorama/images/items/ethereal_blade_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(dazzle.ItemsForLinkenBreaker, '~/MenuIcons/dots.png')
Menu.AddOptionTip(dazzle.ItemsForLinkenBreaker, 'You can move items on LMB to change priority!')

-- Blink usage
local BlinkArgs = {
  style = HeroesCore.AddOptionCombo({'Hero Specific', 'Intelligence', 'Dazzle', 'Combo', 'Blink options'}, 'Usage style', { "Don't use", "To enemy", "To cursor" }, 2),
  key = HeroesCore.AddKeyOption({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo', 'Blink options' }, 'Additional key', Enum.ButtonCode.KEY_NONE),
  graded_always = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo', 'Blink options' }, 'Use graded blink on close distance', true)
}
HeroesCore.AddMenuIcon({'Hero Specific', 'Intelligence', 'Dazzle', 'Combo', 'Blink options'}, 'panorama/images/items/blink_png.vtex_c')
HeroesCore.AddOptionIcon(BlinkArgs.style, '~/MenuIcons/Lists/single_choice.png')
HeroesCore.AddOptionIcon(BlinkArgs.key, '~/MenuIcons/status.png')
HeroesCore.AddOptionIcon(BlinkArgs.graded_always, 'panorama/images/items/overwhelming_blink_png.vtex_c')
function dazzle.OnMenuOptionChange(option, oldValue, newValue)
  if (option ~= BlinkArgs.style) then return end
  HeroesCore.UseCurrentPath(IsDazzle)
  if (newValue == 1) then
    BlinkArgs.distance = HeroesCore.AddOptionSlider({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Combo', 'Blink options' }, 'Blink distance', 0, 1200, 400)
    HeroesCore.AddOptionIcon(BlinkArgs.distance, '~/MenuIcons/edit.png')
  else
    HeroesCore.RemoveOption(BlinkArgs.distance)
    BlinkArgs.distance = nil
  end
end
-- Auto Grave section
dazzle.AutoSaveEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Auto Shallow Grave' }, 'Enable', false)
HeroesCore.AddOptionIcon(dazzle.AutoSaveEnable, '~/MenuIcons/Enable/enable_check_boxed.png')
-- Percent of max HP
dazzle.Percent = HeroesCore.AddOptionSlider({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Percent of max HP', 1, 100, 5)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Auto Shallow Grave' }, 'panorama/images/spellicons/dazzle_shallow_grave_png.vtex_c')
HeroesCore.AddOptionIcon(dazzle.Percent, '~/MenuIcons/bar_ally.png')
-- Use Grave if enemy is nearly
dazzle.NearlyGraveUse = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Use Grave only if enemy is nearly', true)
HeroesCore.AddOptionIcon(dazzle.NearlyGraveUse, '~/MenuIcons/horizontal.png')
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
-- Moving button
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
local PoisonTouch = nil
local ShallowGrave = nil
local ShadowWave = nil
local BadJuju = nil

-- Skill range
local GraveRange = 0
local ShadowRange = 0
local BadRange = 0

-- Combo
local EnemyTarget = nil
local BreakerItem = nil

-- Particle
local ParticleHandler = 0

-- Settings
local HeroSettings = {}

-- Init in game
local function Init()
    if (Engine.IsInGame()) then
        if (IsDazzle) then
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
    local HeroesTable = {}
    for _, Hero in pairs(Heroes.GetAll()) do
        if (Entity.IsSameTeam(Hero, MyHero)) then
            if (#HeroesTable < 5) then
                table.insert(HeroesTable, Hero)
            end
        end
    end
    return HeroesTable
end

local function UpdateInfo()
    -- My mana
    MyMana = NPC.GetMana(MyHero)
    -- Hero skills
    PoisonTouch = NPC.GetAbility(MyHero, 'dazzle_poison_touch')
    ShallowGrave = NPC.GetAbility(MyHero, 'dazzle_shallow_grave')
    ShadowWave = NPC.GetAbility(MyHero, 'dazzle_shadow_wave')
    BadJuju = NPC.GetAbility(MyHero, 'dazzle_bad_juju')
    -- Skills radius
    GraveRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_shallow_grave'))
    ShadowRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_shadow_wave'))
    BadRange = Ability.GetCastRange(NPC.GetAbility(MyHero, 'dazzle_bad_juju'))
end

local function GetPercent(Percent,MaxValue)
    if tonumber(Percent) and tonumber(MaxValue) then
        return (MaxValue * Percent) / 100
    end
    return 696969696969691337 -- erorhendler))))
end

local function GetModifiersDieTimeByName(Hero, Name)
    Modifiers = NPC.GetModifiers(Hero)
    for _, Modifs in pairs(Modifiers) do
        if (Modifier.GetName(Modifs) == Name) then
            DieTime = math.floor(((Modifier.GetDieTime(Modifs) - GameRules.GetGameTime()) * 10^1) + 0.5) / (10^1)
            return DieTime
        end
    end
end

local function BestPosition(UnitsAround, Radius, PredictTime)
    if (not UnitsAround or #UnitsAround <= 0) then return nil end

    local EnemyNumber = #UnitsAround

	if (EnemyNumber == 1) then return HeroesCore.GetPredictionPos(UnitsAround[1], PredictTime) end

	local MaxNumber = 1
	local BestPos = Entity.GetAbsOrigin(UnitsAround[1])

	for i = 1, EnemyNumber-1 do
		for j = i+1, EnemyNumber do
			if (UnitsAround[i] and UnitsAround[j]) then
				local Pos1 = HeroesCore.GetPredictionPos(UnitsAround[i], PredictTime)
				local Pos2 = HeroesCore.GetPredictionPos(UnitsAround[j], PredictTime)
				local Mid = Pos1:__add(Pos2):Scaled(0.5)

				local HeroesNumber = 0

				for k = 1, EnemyNumber do
					if (NPC.IsPositionInRange(UnitsAround[k], Mid, Radius, 0)) then
						HeroesNumber = HeroesNumber + 1
					end
				end

				if (HeroesNumber > MaxNumber) then
					MaxNumber = HeroesNumber
					BestPos = Mid
				end
			end
		end
	end
	return BestPos
end

local function IsGhosted(Hero)
    if ((not NPC.HasModifier(Hero, 'modifier_item_ethereal_blade_ethereal')) and (not NPC.HasModifier(Hero, 'modifier_ghost_state'))) then
        return false
    end
    return true
end

local function UpdateParticle()
    if (EnemyTarget and Menu.IsKeyDown(dazzle.ComboBind) and HeroesCore.IsTSelectorParticle()) then
        if (ParticleHandler == 0) then
            ParticleHandler = Particle.Create('particles/ui_mouseactions/range_finder_tower_aoe.vpcf', Enum.ParticleAttachment.PATTACH_INVALID, EnemyTarget)	
        end	
        Particle.SetControlPoint(ParticleHandler, 2, Entity.GetOrigin(MyHero))
        Particle.SetControlPoint(ParticleHandler, 6, Vector(1, 0, 0))
        Particle.SetControlPoint(ParticleHandler, 7, Entity.GetOrigin(EnemyTarget))
    else
        if (ParticleHandler > 0) then
            Particle.Destroy(ParticleHandler)
            ParticleHandler = 0
        end
    end
end

local function IsTargetedByProjectile(Hero)
    for _, TargetProjectile in pairs(TargetProjectiles.GetAll()) do
        if (TargetProjectile.Hero == Hero) then
            return true
        end
    end
    return false
end

local function NotAvailableModifs(Hero)
    return (NPC.HasModifier(Hero, 'modifier_dazzle_shallow_grave') or NPC.HasModifier(Hero, 'modifier_pudge_swallow_hide')
    or NPC.HasModifier(Hero, 'modifier_obsidian_destroyer_astral_imprisonment_prison') or NPC.HasModifier(Hero, 'modifier_puck_phase_shift')
    or NPC.HasModifier(Hero, 'modifier_life_stealer_infest') or NPC.HasModifier(Hero, 'modifier_juggernaut_omnislash')
    or NPC.HasModifier(Hero, 'modifier_shadow_demon_disruption') or NPC.HasModifier(Hero, 'modifier_eul_cyclone') or NPC.HasModifier(Hero, 'modifier_wind_waker')
    or NPC.HasModifier(Hero, 'modifier_item_book_of_shadows_buff') or NPC.HasModifier(Hero, 'modifier_dark_willow_shadow_realm_buff')
    or NPC.HasModifier(Hero, 'modifier_void_spirit_dissimilate_phase') or NPC.HasModifier(Hero, 'modifier_earth_spirit_stone_thinker')
    or NPC.HasModifier(Hero, 'modifier_phoenix_supernova_hiding') or NPC.HasModifier(Hero, 'modifier_snapfire_gobble_up_creep')
    or NPC.HasModifier(Hero, 'modifier_invoker_tornado') or NPC.HasModifier(Hero, 'modifier_visage_summon_familiars_stone_form_buff'))
end

local function GetTheRightHero() 
    if (Menu.IsEnabled(dazzle.Enable)) then
        for _, FriendlyHeroes in pairs(Heroes.InRadius(Entity.GetOrigin(MyHero), GraveRange, Entity.GetTeamNum(MyTeam), Enum.TeamType.TEAM_FRIEND)) do
            if (HeroSettings[FriendlyHeroes]) then 
                if (HeroSettings[FriendlyHeroes].enabled) then
                    if (Entity.GetHealth(FriendlyHeroes) < GetPercent(Menu.GetValue(dazzle.Percent), Entity.GetMaxHealth(FriendlyHeroes))) then
                        local EnemyHeroes = Entity.GetHeroesInRadius(FriendlyHeroes, 1100, Enum.TeamType.TEAM_ENEMY)
                        if (Menu.IsEnabled(dazzle.NearlyGraveUse)) then
                            if (#EnemyHeroes >= 1) then
                                return FriendlyHeroes
                            end
                        else
                            return FriendlyHeroes
                        end
                    end
                end
            end
        end
        return false
    end
end

function dazzle.OnUpdate()

    if (Menu.IsEnabled(dazzle.Enable)) then

        if (MyHero == nil) then return end

        if (not IsDazzle) then return end
        -- Target particle
        UpdateParticle()

        -- Amazing timer
        GameTime = GameRules.GetGameTime()
        if (Timer > GameTime) then return end
        Timer = HeroesCore.GetSleep(0.1)

        UpdateInfo()
        -- Return end if my hero stuned etc...
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

        local RightHero = GetTheRightHero()

        -- Auto Grave
        if (Menu.IsEnabled(dazzle.AutoSaveEnable)) then
            if (Ability.IsCastable(ShallowGrave, MyMana)) then
                -- Return if hero not available to cast Grave
                if (not NotAvailableModifs(RightHero)) then
                    if (Menu.IsEnabled(dazzle.GraveInPromise)) then
                        if (NPC.HasModifier(RightHero, 'modifier_oracle_false_promise_timer') and GetModifiersDieTimeByName(RightHero, 'modifier_oracle_false_promise_timer') < 1) then
                            Ability.CastTarget(ShallowGrave, RightHero)
                        elseif (not NPC.HasModifier(RightHero, 'modifier_oracle_false_promise_timer')) then
                            Ability.CastTarget(ShallowGrave, RightHero)
                        end
                    end
                end
            end
        end

        -- Target healing
        local FriendlyTarget = HeroesCore.GetTarget(MyTeam, Enum.TeamType.TEAM_FRIEND)

        -- Healing combo
        if (Menu.IsKeyDown(dazzle.HealBind)) then
            -- Items
            for i, Items in ipairs(Menu.GetItems(dazzle.ItemsForHeal)) do
                if (Menu.IsSelected(dazzle.ItemsForHeal, Items)) then
                    if (Ability.IsCastable(NPC.GetItem(MyHero, tostring(Items)), MyMana)) then
                        if (NPC.IsEntityInRange(FriendlyTarget, MyHero, 1100)) then
                            if (Items == 'item_mekansm' or Items == 'item_guardian_greaves') then
                                Ability.CastNoTarget(NPC.GetItem(MyHero, tostring(Items)))
                            elseif (Items == 'item_urn_of_shadows' or Items == 'item_spirit_vessel') then
                                if (Item.GetCurrentCharges(NPC.GetItem(MyHero, tostring(Items))) > 0) then
                                    if (not NPC.HasModifier(FriendlyTarget, 'modifier_item_spirit_vessel_heal') or NPC.HasModifier(FriendlyTarget, 'modifier_item_urn_heal')) then
                                        Ability.CastTarget(NPC.GetItem(MyHero, tostring(Items)), FriendlyTarget)
                                    end
                                end
                            else
                                Ability.CastTarget(NPC.GetItem(MyHero, tostring(Items)), FriendlyTarget)
                            end
                        end
                    end
                end
            end

            -- Stepping
            local HealingCastStep = 1

            -- Cast ShadowWave
            if (HealingCastStep == 1) then
                if (Ability.IsCastable(ShadowWave, MyMana) and Menu.IsSelected(dazzle.AbilitiesForHeal, 'shadow_wave')) then
                    Ability.CastTarget(ShadowWave, FriendlyTarget)
                else
                    HealingCastStep = 2
                end
            end

            -- Cast BadJuju
            if (HealingCastStep == 2) then
                if (Ability.IsCastable(BadJuju, MyMana) and Menu.IsSelected(dazzle.AbilitiesForHeal, 'bad_juju') and NPC.IsEntityInRange(FriendlyTarget, MyHero, BadRange)) then
                    Ability.CastNoTarget(BadJuju)
                end 
            end
        end

        -- I hate HeroesCore ;-;
        -- EnemyTarget writer
        if (HeroesCore.GetTSelectorStyle()) == 1 then
            if (EnemyTarget == nil) then
                if (Menu.IsKeyDown(dazzle.ComboBind)) then
                    EnemyTarget = HeroesCore.GetTarget(MyTeam, Enum.TeamType.TEAM_ENEMY)
                end
            else
                if (not Menu.IsKeyDown(dazzle.ComboBind)) or (Entity.IsDormant(EnemyTarget)) or (not Entity.IsAlive(EnemyTarget)) then
                    EnemyTarget = nil
                end
            end
        else
            if (Menu.IsKeyDown(dazzle.ComboBind)) then
                EnemyTarget = HeroesCore.GetTarget(MyTeam, Enum.TeamType.TEAM_ENEMY)
            else
                EnemyTarget = nil
            end
        end

        if (not Entity.IsAlive(MyHero)) then
            EnemyTarget = nil
        end

        -- Move to cursor
        if (not EnemyTarget) then
            if (HeroesCore.IsTSelectorMove() and Menu.IsKeyDown(dazzle.ComboBind)) then
                NPC.MoveTo(MyHero, Input.GetWorldCursorPos())
            end
            return
        end

        -- Another check...
        if (Entity.IsDormant(EnemyTarget) or not Entity.IsAlive(EnemyTarget) or NPC.IsStructure(EnemyTarget) or NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) then return end

        -- Check on the NotAvailableModifs
        if (NotAvailableModifs(EnemyTarget)) then return end

        -- funi Linken breaker
        BreakerItem = nil
        if (Menu.IsKeyDown(dazzle.ComboBind) and Menu.IsEnabled(dazzle.LinkenBreakerEnable) and NPC.IsLinkensProtected(EnemyTarget) and (not IsTargetedByProjectile(EnemyTarget))) then
            if (not NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE)) then 
                for _, Item in ipairs(Menu.GetItems(dazzle.ItemsForLinkenBreaker)) do
                    if (Menu.IsSelected(dazzle.ItemsForLinkenBreaker, Item)) then
                        if (Ability.IsCastable(NPC.GetItem(myHero, tostring(Item)), MyMana)) then
                            BreakerItem = NPC.GetItem(myHero, tostring(Item))
                        break
                        end
                    end
                end
                if (not BreakerItem == nil) then
                    Ability.CastTarget(BreakerItem, EnemyTarget)
                end
            end
        end
        
        -- Combo
        if (Menu.IsKeyDown(dazzle.ComboBind)) then

            -- MirrorSheild check
            if (not Menu.IsEnabled(dazzle.ComboInMirrorShieldEnable)) then
                if (not NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) then
                    if (Ability.IsReady(NPC.GetItem(EnemyTarget, 'item_mirror_shield'))) then return end
                end
            end

            -- LotusOrb Check
            if (not Menu.IsEnabled(dazzle.ComboInLotusEnable)) then
                if (not NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE)) then
                    if (NPC.HasModifier(EnemyTarget, 'modifier_item_lotus_orb_active')) then return end
                end
            end

            -- Linken breaker check
            if (Menu.IsEnabled(dazzle.LinkenBreakerEnable)) then
                if (NPC.IsLinkensProtected(EnemyTarget)) then return end
            end

            -- Blink usage
            HeroesCore.BlinkUsage(MyHero, EnemyTarget, BlinkArgs)
            
            --Cool stepping
            local ComboCastStep = 0

            -- Items
            if (ComboCastStep == 0) then
                if (not NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE)) then 
                    for _, Items in ipairs(Menu.GetItems(dazzle.ItemsForCombo)) do
                        if (Menu.IsSelected(dazzle.ItemsForCombo, Items)) then
                            if (Ability.IsCastable(NPC.GetItem(MyHero, tostring(Items)), MyMana)) then
                                if (Items == 'item_shivas_guard' or Items == 'item_ancient_janggo' or Items == 'item_black_king_bar') then
                                    Ability.CastNoTarget(NPC.GetItem(MyHero, tostring(Items)))
                                else
                                    if (Items ~= 'item_gungir' and Items ~= 'item_veil_of_discord') then
                                        if (Items == 'item_mjollnir') then
                                            Ability.CastTarget(NPC.GetItem(MyHero, tostring(Items)), MyHero)
                                        else
                                            if (Items == 'item_satanic') then
                                                if (Entity.GetHealth(MyHero) < GetPercent(Menu.GetValue(dazzle.SatanicUsagePercent), Entity.GetMaxHealth(MyHero))) then
                                                    Ability.CastNoTarget(NPC.GetItem(MyHero, tostring(Items)))
                                                end
                                            else
                                                Ability.CastTarget(NPC.GetItem(MyHero, tostring(Items)), EnemyTarget)
                                            end
                                        end
                                    else
                                        Ability.CastPosition(NPC.GetItem(MyHero, tostring(Items)), BestPosition(Heroes.InRadius(Entity.GetAbsOrigin(EnemyTarget), 1000, MyTeam, Enum.TeamType.TEAM_ENEMY),500, 0.3))
                                    end
                                end
                            else
                                ComboCastStep = 1
                            end
                        end
                    end
                end
            end

            -- Cant attack o_O
            local CantAttack = false

            -- Cast PoisonTouch
            if (ComboCastStep == 1) then
                if (Ability.IsCastable(PoisonTouch, MyMana) and Menu.IsSelected(dazzle.AbilitiesForCombo, 'poison_touch')) then
                    Ability.CastTarget(PoisonTouch, EnemyTarget)
                    CantAttack = true
                else
                    ComboCastStep = 2
                end
            end

            -- Cast ShadowWave if npcs in radius
            if (ComboCastStep == 2) then
                for _, HealTarget in pairs(NPCs.InRadius(Entity.GetAbsOrigin(EnemyTarget), 175, MyTeam, Enum.TeamType.TEAM_FRIEND)) do
                    if (Ability.IsCastable(ShadowWave, MyMana) and Menu.IsSelected(dazzle.AbilitiesForCombo, 'poison_touch')) then
                        Ability.CastTarget(ShadowWave, HealTarget)
                    end
                end
                ComboCastStep = 3
            end

            -- Cast BadJuju
            if (ComboCastStep == 3) then
                if (Ability.IsCastable(BadJuju, MyMana) and Menu.IsSelected(dazzle.AbilitiesForCombo, 'bad_juju') and NPC.IsEntityInRange(EnemyTarget, MyHero, BadRange)) then
                    Ability.CastNoTarget(BadJuju)
                    CantAttack = true
                end 
            end

            -- Target attack
            if (not CantAttack) then
                if (not IsGhosted(EnemyTarget)) then
                    HeroesCore.Orbwalker(MyHero, EnemyTarget)
                return end
            end
        end
    end
end

local configName = 'cum_mega_dazzle_panel_positions'

local UI = {
    x = Config.ReadInt(configName, 'x', 200),
    y = Config.ReadInt(configName, 'y', 200),
    Width = 234 * Multiplier,
    Height = 54 * Multiplier,
    HeroBgW = 36 * Multiplier,
    HeroBgH = 36 * Multiplier,
    HeroW = 30 * Multiplier,
    HeroH = 30 * Multiplier,
    ToggleW = 48 * Multiplier,
    ToggleH = 48 * Multiplier,
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

-- Please fix renderer functions and make antialiasing 🙏🙏🙏🙏 | upd 11/4/2022: Valve thanks)0)0))
local ToggleOn = Renderer.LoadImage('~/dazzle/toggle_on.png')
local ToggleOff = Renderer.LoadImage('~/dazzle/toggle_off.png')

-- Panel UI
function dazzle.DrawUI()
    UI.x, UI.y = dazzle.ScreenClamp(UI.x, UI.y)
    local x = UI.x

    Renderer.DrawFilledRoundedRect(x, UI.y, UI.Width, UI.Height, 10, 23, 30, 37)

    local Heroes = dazzle.GetTeammates()

    x = x + (9 * Multiplier)

    local HeroImage = {}

    for _, Hero in pairs(Heroes) do

        if (not HeroSettings[Hero]) then
            HeroSettings[Hero] = {
                enabled = true
            }
        end

        Renderer.DrawFilledRoundedRect(x, UI.y + (9 * Multiplier), UI.HeroBgW, UI.HeroBgH, 8, 31, 40, 52)

        if (HeroSettings[Hero].enabled) then
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(ToggleOn, x - (6 * Multiplier), UI.y + (3 * Multiplier), UI.ToggleW, UI.ToggleH)
        else
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(ToggleOff, x - (6 * Multiplier), UI.y + (3 * Multiplier), UI.ToggleW, UI.ToggleH)
        end
        
        if (Input.IsCursorInRect(x, UI.y + (9 * Multiplier), UI.HeroBgW, UI.HeroBgH)) then
            if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
                HeroSettings[Hero].enabled = not HeroSettings[Hero].enabled
            end
        end

        if (not HeroImage[NPC.GetUnitName(Hero)]) then
            HeroImage[NPC.GetUnitName(Hero)] = Renderer.LoadImage('~/heroes_circle/' .. string.gsub(NPC.GetUnitName(Hero), 'npc_dota_hero_', '') .. '.png')
        end

        if (HeroSettings[Hero].enabled) then
            Renderer.SetDrawColor(255, 255, 255, 255)
            Renderer.DrawImage(HeroImage[NPC.GetUnitName(Hero)], x + (3 * Multiplier), UI.y + (12 * Multiplier), UI.HeroW, UI.HeroH)
        else
            Renderer.SetDrawColor(100, 100, 100, 255)
            Renderer.DrawImage(HeroImage[NPC.GetUnitName(Hero)], x + (3 * Multiplier), UI.y + (12 * Multiplier), UI.HeroW, UI.HeroH)
        end

        x = x + (36 + 9) * Multiplier
    end

    if (Input.IsCursorInRect(UI.x, UI.y, UI.Width, UI.Height) and not UI.IsMoving and Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
        UI.IsMoving = true
        UI.MoveW, UI.MoveH = Input.GetCursorPos()
    end
end

-- Render
function dazzle.OnDraw()
    if ((Engine.IsInGame() and Menu.IsEnabled(dazzle.Enable) and Menu.IsEnabled(dazzle.Panel)) and IsDazzle) then
        dazzle.MovingManager()
        dazzle.DrawUI()
    end
end

return dazzle
