local slark = {}


slark.Enable = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Включить", false)
slark.Ult = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Shadow Dance в комбо", false)
Menu.AddOptionIcon(slark.Ult, "panorama/images/spellicons/slark_shadow_dance_png.vtex_c")
slark.Pounce = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Pounce в комбо", false)
Menu.AddOptionIcon(slark.Pounce, "panorama/images/spellicons/slark_pounce_png.vtex_c")
slark.Dark = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Dark Pact в комбо", false)
Menu.AddOptionIcon(slark.Dark, "panorama/images/spellicons/slark_dark_pact_png.vtex_c")
slark.Rem = Menu.AddOptionBool({ "Hero Specific", "Slark", "Dark Pact" }, "Использовать для снятия эффектов", false)
slark.Battle_hunger = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Battle Hunger", false)
Menu.AddOptionIcon(slark.Battle_hunger, "panorama/images/spellicons/axe_battle_hunger_png.vtex_c")
slark.Enfeeble = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Enfeeble", false)
Menu.AddOptionIcon(slark.Enfeeble, "panorama/images/spellicons/bane_enfeeble_png.vtex_c")
slark.Poison_touch = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Poison Touch", false)
Menu.AddOptionIcon(slark.Poison_touch, "panorama/images/spellicons/dazzle_poison_touch_png.vtex_c")
slark.Call_down_slow = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Call Down Slow", false)
Menu.AddOptionIcon(slark.Call_down_slow, "panorama/images/spellicons/gyrocopter_call_down_png.vtex_c")
slark.Cold_feet = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься"  }, "Cold Feet", false)
Menu.AddOptionIcon(slark.Cold_feet, "panorama/images/spellicons/ancient_apparition_cold_feet_png.vtex_c")
slark.Coldfeet_freeze = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Cold Feet Freeze", false)
Menu.AddOptionIcon(slark.Coldfeet_freeze, "panorama/images/spellicons/ancient_apparition_cold_feet_png.vtex_c")
slark.Flux = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Flux", false)
Menu.AddOptionIcon(slark.Flux, "panorama/images/spellicons/arc_warden_flux_png.vtex_c")
slark.Void = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Void", false)
Menu.AddOptionIcon(slark.Void, "panorama/images/spellicons/night_stalker_void_png.vtex_c")
slark.Gale = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Venomous Gale", false)
Menu.AddOptionIcon(slark.Gale, "panorama/images/spellicons/venomancer_venomous_gale_png.vtex_c")
slark.Track = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Track", false)
Menu.AddOptionIcon(slark.Track, "panorama/images/spellicons/bounty_hunter_track_png.vtex_c")
slark.Glimpse = Menu.AddOptionBool({ "Hero Specific", "Slark", "Способности которые будут сниматься" }, "Glimpse", false)
Menu.AddOptionIcon(slark.Glimpse, "panorama/images/spellicons/disruptor_glimpse_png.vtex_c")
slark.Key = Menu.AddKeyOption({ "Hero Specific", "Slark" }, "Кнопка для комбо", Enum.ButtonCode.KEY_1)
slark.Percent = Menu.AddOptionSlider({ "Hero Specific", "Slark" }, "Хп для авто. использования Shadow Dance", 1, 100, 20)
Menu.AddOptionIcon(slark.Percent, "panorama/images/spellicons/slark_shadow_dance_png.vtex_c")
slark.Abyssal = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Abyssal Blade в комбо", false)
Menu.AddOptionIcon(slark.Abyssal, "panorama/images/items/abyssal_blade_png.vtex_c")
slark.Orchid = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Orchid в комбо", false)
Menu.AddOptionIcon(slark.Orchid, "panorama/images/items/orchid_png.vtex_c")
slark.Bloothorn = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Bloodthorn в комбо", false)
Menu.AddOptionIcon(slark.Bloothorn, "panorama/images/items/bloodthorn_png.vtex_c")
slark.Bkb = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Black King Bar в комбо", false)
Menu.AddOptionIcon(slark.Bkb, "panorama/images/items/black_king_bar_png.vtex_c")
slark.Nullifier = Menu.AddOptionBool({ "Hero Specific", "Slark" }, "Использовать Nullifier в комбо", false)
Menu.AddOptionIcon(slark.Nullifier, "panorama/images/items/nullifier_png.vtex_c")
slark.NearestTarget = Menu.AddOptionSlider({"Hero Specific", "Slark"}, "Радиус поиска цели около курсора", 200, 800, 100)
slark.optionIcon = Menu.AddOptionIcon({ "Hero Specific","Slark"}, "panorama/images/heroes/icons/npc_dota_hero_slark_png.vtex_c")

slark.lastTick = 0

function slark.OnUpdate()
    me = Heroes.GetLocal()
    if not Menu.IsEnabled(slark.Enable) or not Engine.IsInGame() or not Heroes.GetLocal() then return end
 
    if NPC.GetUnitName(me) ~= "npc_dota_hero_slark" then return end
    if not Entity.IsAlive(me) or NPC.IsStunned(me) or NPC.IsSilenced(me) then return end
    if Menu.IsEnabled(slark.Enable) then
    enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(me), Enum.TeamType.TEAM_ENEMY)
        if enemy and enemy ~= 0 then
        --Log.Write(NPC.GetUnitName(enemy))
            slark.Combo(me, enemy)
            return end
    end
end

function slark.Combo()
    target = nil
    myTeam = Entity.GetTeamNum(me)
    enemy = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
    player =  Players.GetLocal()
    mana = NPC.GetMana(me)
    health = Entity.GetHealth(me)
    max_hp = Entity.GetMaxHealth(me)
    ult = NPC.GetAbility(me, "slark_shadow_dance")
    abyssal = NPC.GetItem(me, "item_abyssal_blade", true)
    bkb = NPC.GetItem(me, "item_black_king_bar")
    orchid = NPC.GetItem(me, "item_orchid")
    bloodthorn = NPC.GetItem(me, "item_bloodthorn", true)
    nullifier = NPC.GetItem(me, "item_nullifier")
    pounce = NPC.GetAbility(me, "slark_pounce")
    dark = NPC.GetAbility(me, "slark_dark_pact")
    dark_range = 700
    cursor_pos = Input.GetWorldCursorPos()


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
       -- Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, enemy, Input.GetWorldCursorPos(), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, me)
         Player.AttackTarget(Players.GetLocal(), me, enemy, true)
        if Menu.IsEnabled(slark.Abyssal) and abyssal and Ability.IsCastable(abyssal, mana) and Ability.IsReady(abyssal) then Ability.CastTarget(abyssal, enemy) end
        if Menu.IsEnabled(slark.Ult) and ult and Ability.IsCastable(ult, mana) and Ability.IsReady(ult) then Ability.CastNoTarget(ult) end
        if Menu.IsEnabled(slark.Bkb) and bkb and Ability.IsCastable(bkb, mana) and Ability.IsReady(bkb) then Ability.CastNoTarget(bkb) end
        if Menu.IsEnabled(slark.Orchid) and orchid and Ability.IsCastable(orchid, mana) and Ability.IsReady(orchid) then Ability.CastTarget(orchid, enemy) end
        if Menu.IsEnabled(slark.Nullifier) and nullifier and Ability.IsCastable(nullifier, mana) and Ability.IsReady(nullifier) then Ability.CastTarget(nullifier, enemy) end
        if Menu.IsEnabled(slark.Bloothorn) and bloodthorn and Ability.IsCastable(bloodthorn, mana) and Ability.IsReady(bloodthorn) then Ability.CastTarget(bloodthorn, enemy, true) end
        Player.AttackTarget(Players.GetLocal(), me, enemy, true)  
        if Menu.IsEnabled(slark.Pounce) and pounce and Ability.IsCastable(pounce, mana) and Ability.IsReady(pounce) and NPC.IsAttacking(me) then
            Player.AttackTarget(Players.GetLocal(), me, enemy, true)    
            Ability.CastNoTarget(pounce)
            end
        if Menu.IsEnabled(slark.Dark) and dark and Ability.IsCastable(dark, mana) and Ability.IsReady(dark) then
            Ability.CastNoTarget(dark) end

    end



end


return slark
