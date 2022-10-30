local dazzle = {}

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
-- Auto Grave in FalsePromise
dazzle.GraveInPromise = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle', 'Auto Shallow Grave' }, 'Auto grave in FalsePromise', false)
Menu.AddOptionTip(dazzle.GraveInPromise, 'Automatically cast FalsePromise at the end.')
HeroesCore.AddOptionIcon(dazzle.GraveInPromise, 'panorama/images/spellicons/oracle_false_promise_png.vtex_c')

-- Visual section
dazzle.Panel = HeroesCore.AddOptionBool({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Visual' }, 'Panel', false)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle', 'Visual' }, '~/MenuIcons/panel_def.png')
HeroesCore.AddOptionIcon(dazzle.Panel, '~/MenuIcons/Enable/enable_check_boxed.png')
dazzle.MovingButton = HeroesCore.AddKeyOption({ 'Hero Specific', 'Intelligence',  'Dazzle' , 'Visual' }, 'Moving button', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddOptionIcon(dazzle.MovingButton, '~/MenuIcons/drag_def.png')

-- Hero face icon
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Intelligence', 'Dazzle' }, 'panorama/images/heroes/icons/npc_dota_hero_dazzle_png.vtex_c')

local Timer = -69696969
local GameTime = nil

local MyHero = nil
local MyTeam = nil
local MyPlayer = nil

local _screenW, _screenH = Renderer.GetScreenSize()
local Multiplier = _screenH / 1080

local GraveRange = 0

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

-- Init
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
    grave = NPC.GetAbility(myHero, 'dazzle_shallow_grave')
end

local function GetPercent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        return (maxvalue * percent) / 100
    end
    return 696969696969691337 -- erorhendler))))
end

local function GetShallowGraveRadius()
    GraveRange = Ability.GetCastRange(NPC.GetAbility(myHero, 'dazzle_shallow_grave'))
end

local function GetTheRightHero()
    for i, hero in pairs(Heroes.InRadius(Entity.GetOrigin(MyHero), GraveRange, Entity.GetTeamNum(MyTeam), Enum.TeamType.TEAM_FRIEND)) do
        if HeroSettings[hero] then 
            if HeroSettings[hero].enabled then
                if Entity.GetHealth(hero) < GetPercent(Menu.GetValue(dazzle.Percent), Entity.GetMaxHealth(hero)) then
                    local EnemyHeroes = Entity.GetHeroesInRadius(hero, 1100, Enum.TeamType.TEAM_ENEMY)
                    if #EnemyHeroes >= 1 then
                        return hero
                    end
                end
            end
        end
    end
    return false
end

local function GetModifiersDieTimeByName(name)
    modifiers = NPC.GetModifiers(GetTheRightHero())
    for _, modifs in pairs(modifiers) do
        if Modifier.GetName(modifs) == name then
            DieTime = math.floor(((Modifier.GetDieTime(modifs) - GameRules.GetGameTime()) * 10^1) + 0.5) / (10^1)
            return DieTime
        end
    end
end

function dazzle.OnUpdate()

    if Menu.IsEnabled(dazzle.Enable) then

        -- Amazing timer
        GameTime = GameRules.GetGameTime()
        if Timer > GameTime then return end
        Timer = GameTime + 0.15
        
        UpdateInfo()
        GetShallowGraveRadius()

        if not Entity.IsAlive(myHero) 
        or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_SILENCED)
        or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_MUTED)
        or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_STUNNED)
        or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED)
        or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_NIGHTMARED)
        or NPC.HasModifier(myHero, 'modifier_obsidian_destroyer_astral_imprisonment_prison')
        or NPC.HasModifier(myHero, 'modifier_teleporting')
        or NPC.HasModifier(myHero, 'modifier_pudge_swallow_hide')
        or NPC.HasModifier(myHero, 'modifier_axe_berserkers_call')
        then return end

        if not Entity.IsAlive(GetTheRightHero()) 
        or NPC.HasModifier(GetTheRightHero(), 'modifier_pudge_swallow_hide')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_obsidian_destroyer_astral_imprisonment_prison')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_puck_phase_shift')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_life_stealer_infest')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_juggernaut_omnislash')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_shadow_demon_disruption')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_eul_cyclone') or NPC.HasModifier(GetTheRightHero(), 'modifier_wind_waker')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_item_book_of_shadows_buff')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_dark_willow_shadow_realm_buff')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_void_spirit_dissimilate_phase')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_earth_spirit_stone_thinker')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_phoenix_supernova_hiding')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_snapfire_gobble_up_creep')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_invoker_tornado')
        or NPC.HasModifier(GetTheRightHero(), 'modifier_visage_summon_familiars_stone_form_buff')
        then return end

        if Ability.IsReady(grave) then
            if Menu.IsEnabled(dazzle.GraveInPromise) then
                if (NPC.HasModifier(GetTheRightHero(), 'modifier_oracle_false_promise_timer') and GetModifiersDieTimeByName('modifier_oracle_false_promise_timer') < 1) then
                    Ability.CastTarget(grave, GetTheRightHero())
                elseif not NPC.HasModifier(GetTheRightHero(), 'modifier_oracle_false_promise_timer') then
                    Ability.CastTarget(grave, GetTheRightHero())
                end
            else
                Ability.CastTarget(grave, GetTheRightHero())
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
    if UI.IsMoving and Menu.IsKeyDown(dazzle.MovingButton) and Input.IsKeyDown(Enum.ButtonCode.KEY_MOUSE1) then
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

    local heroes = dazzle.GetTeammates()

    x = x + (9 * Multiplier)

    local HeroImage = {}

    for i, hero in pairs(heroes) do

        if not HeroSettings[hero] then
            HeroSettings[hero] = {
                enabled = true 
            }
        end

        Renderer.DrawImage(HeroBackground, x, UI.y + 9, UI.HeroBgW * Multiplier, UI.HeroBgH * Multiplier)

        if HeroSettings[hero].enabled then
            Renderer.DrawImage(ToggleOn, x - 3, UI.y + 6, UI.ToggleW * Multiplier, UI.ToggleH * Multiplier)
        else
            Renderer.DrawImage(ToggleOff, x - 3, UI.y + 6, UI.ToggleW * Multiplier, UI.ToggleH * Multiplier)
        end
        
        if (Input.IsCursorInRect(x, UI.y, UI.HeroBgW * Multiplier, UI.HeroBgH * Multiplier)) then
            if (Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
                HeroSettings[hero].enabled = not HeroSettings[hero].enabled
            end
        end

        if not HeroImage[NPC.GetUnitName(hero)] then
            HeroImage[NPC.GetUnitName(hero)] = Renderer.LoadImage('~/heroes_circle/' .. string.gsub(NPC.GetUnitName(hero), 'npc_dota_hero_', '') .. '.png')
        end

        Renderer.DrawImage(HeroImage[NPC.GetUnitName(hero)], x + 3, UI.y + 12, UI.HeroW * Multiplier, UI.HeroH * Multiplier)

        x = x + 36 + 9
    end

    if (Input.IsCursorInRect(UI.x, UI.y, UI.Width, UI.Height) and not UI.IsMoving and Input.IsKeyDownOnce(Enum.ButtonCode.KEY_MOUSE1)) then
        UI.IsMoving = true
        UI.MoveW, UI.MoveH = Input.GetCursorPos()
    end
end

function dazzle.OnDraw()
    if (Engine.IsInGame() and Menu.IsEnabled(dazzle.Enable) and Menu.IsEnabled(dazzle.Panel)) and IsDazzle then
        dazzle.MovingManager()
        dazzle.DrawUI()
    end
end

return dazzle