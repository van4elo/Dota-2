local slark = {}

slark.Enable = Menu.AddOptionBool({ "Hero Specific", "slark" }, "enable", false)
slark.Ult = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use ult in combo?", false)
slark.Pounce = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use pounce in combo?", false)
slark.Dark = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use dark_pact in combo?", false)
slark.Rem = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "use for remove effects?", false)
slark.Battle_hunger = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_axe_battle_hunger", false)
slark.Enfeeble = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_bane_enfeeble", false)
slark.Poison_touch = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_dazzle_poison_touch", false)
slark.Call_down_slow = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_gyrocopter_call_down_slow", false)
slark.Cold_feet = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_cold_feet", false)
slark.Coldfeet_freeze = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_ancientapparition_coldfeet_freeze", false)
slark.Flux = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_arc_warden_flux", false)
slark.Void = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_night_stalker_void", false)
slark.Gale = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_venomancer_venomous_gale", false)
slark.Track = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_bounty_hunter_track", false)
slark.Glimpse = Menu.AddOptionBool({ "Hero Specific", "slark", "dark_pact" }, "modifier_disruptor_glimpse", false)
slark.Key = Menu.AddKeyOption({ "Hero Specific", "slark" }, "Combo Key", Enum.ButtonCode.KEY_1)
slark.Percent = Menu.AddOptionSlider({ "Hero Specific", "slark" }, "hp to ult", 1, 100, 20)
slark.Abyssal = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use abyssal in combo?", false)
slark.Orchid = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use orchid in combo?", false)
slark.Bloothorn = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use bloothorn in combo?", false)
slark.Bkb = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use bkb in combo?", false)
slark.Nullifier = Menu.AddOptionBool({ "Hero Specific", "slark" }, "use nullifier in combo?", false)
slark.NearestTarget = Menu.AddOptionSlider({"Hero Specific", "slark"}, "Радиус поиска цели около курсора", 200, 800, 100)
local me = nil
local enemy = nil
slark.lastTick = 0
function slark.OnUpdate()
if not Menu.IsEnabled(slark.Enable) or not Engine.IsInGame() or not Heroes.GetLocal() then return end
me = Heroes.GetLocal()

if NPC.GetUnitName(me) ~= "npc_dota_hero_slark" then return end
if not Entity.IsAlive(me) or NPC.IsStunned(me) or NPC.IsSilenced(me) then return end
enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), Enum.TeamType.TEAM_ENEMY)
if Menu.IsKeyDown(slark.Key) then
enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), Enum.TeamType.TEAM_ENEMY)
if enemy and enemy ~= 0 then
--Log.Write(NPC.GetUnitName(enemy))
slark.Combo(me, enemy)
return
end
end
end



function slark.Combo(me, enemy)
enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), Enum.TeamType.TEAM_ENEMY)
local mana = NPC.GetMana(me)
local health = Entity.GetHealth(me)
local max_hp = Entity.GetMaxHealth(me)
local ult = NPC.GetAbility(me, "slark_shadow_dance")
local abyssal = NPC.GetItem(me, "item_abyssal_blade", true)
local bkb = NPC.GetItem(me, "item_black_king_bar")
local orchid = NPC.GetItem(me, "item_orchid")
local bloodthorn = NPC.GetItem(me, "item_bloodthorn", true)
local nullifier = NPC.GetItem(me, "item_nullifier")
local pounce = NPC.GetAbility(me, "slark_pounce")
local dark = NPC.GetAbility(me, "slark_dark_pact")
local dark_range = 700
local mypos = Entity.GetAbsOrigin(me)
local cursor_pos = Input.GetWorldCursorPos()
local enemy_origin = Entity.GetAbsOrigin(enemy)
local AimPaunce = (mypos - enemy_origin):Length2D()
if (cursor_pos - enemy_origin):Length2D() > Menu.GetValue(slark.NearestTarget) then enemy = nil return end
if ult and (max_hp*(Menu.GetValue(slark.Percent))/100 > health) and Ability.IsReady(ult) and Ability.IsCastable(ult, mana) then
Ability.CastNoTarget(ult) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Battle_hunger) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_axe_battle_hunger") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Enfeeble) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_bane_enfeeble") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Poison_touch) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_dazzle_poison_touch") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Call_down_slow) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_gyrocopter_call_down_slow") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Cold_feet) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_cold_feet") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Coldfeet_freeze) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_ancientapparition_coldfeet_freeze") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Flux) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_arc_warden_flux") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Void) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_night_stalker_void") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Gale) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_venomancer_venomous_gale") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Track) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_bounty_hunter_track") then 
Ability.CastNoTarget(dark) end
if Menu.IsEnabled(slark.Rem) and Menu.IsEnabled(slark.Glimpse) and dark and Ability.IsReady(dark) and Ability.IsCastable(dark, mana) and NPC.HasModifier(me, "modifier_disruptor_glimpse") then 
Ability.CastNoTarget(dark) end

if Menu.IsKeyDown(slark.Key) then
Player.AttackTarget(Players.GetLocal(), me, enemy, true)
if AimPaunce < 600 then
if slark.SleepReady(0.6) then
if Menu.IsEnabled(slark.Abyssal) and abyssal and Ability.IsCastable(abyssal, mana) then Ability.CastTarget(abyssal, enemy) end
if Menu.IsEnabled(slark.Ult) and ult and Ability.IsCastable(ult, mana) then Ability.CastNoTarget(ult) end
if Menu.IsEnabled(slark.Bkb) and bkb and Ability.IsReady(bkb, mana) then Ability.CastNoTarget(bkb) end
if Menu.IsEnabled(slark.Orchid) and orchid and Ability.IsReady(orchid, mana) then Ability.CastTarget(orchid, enemy) end
if Menu.IsEnabled(slark.Nullifier) and nullifier and Ability.IsReady(nullifier, mana) then Ability.CastTarget(nullifier, enemy) end
if Menu.IsEnabled(slark.Bloothorn) and bloodthorn and Ability.IsReady(bloodthorn, mana) then Ability.CastTarget(bloodthorn, enemy, true) end
if Menu.IsEnabled(slark.Pounce) and pounce and Ability.IsCastable(pounce, mana) then 
Player.AttackTarget(Players.GetLocal(), me, enemy, false)
Ability.CastNoTarget(pounce) end
if Menu.IsEnabled(slark.Dark) and dark and Ability.IsCastable(dark, mana) and Ability.IsReady(dark) then 
Ability.CastNoTarget(dark) end
if slark.SleepReady(0.6) then
Player.AttackTarget(Players.GetLocal(), me, enemy, false)
slark.lastTick = os.clock()
sleep_after_cast = os.clock()
sleep_after_attack = os.clock()
return
end
end
end
end
end
function slark.SleepReady(sleep, lastTick)
if (os.clock() - slark.lastTick) >= sleep then
return true
end

return false
end
return slark
