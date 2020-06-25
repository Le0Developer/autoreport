
GUI_TAB = gui.Tab gui.Reference"Misc", "autoreport", "Auto Report"
GUI_OPT = gui.Groupbox GUI_TAB, "Options", 4, 4, 200, 400

GUI_OPT_ENABLE = with gui.Checkbox GUI_OPT, "enable", "Enable Autoreport", false
    \SetDescription "Automatically report the player who kills you."
GUI_OPT_REASONS = gui.Multibox GUI_OPT, "Reasons"
GUI_OPT_REASONS_ABUSIVECOMMUNICATION = gui.Checkbox GUI_OPT_REASONS, "reasons.abusive_communication", "Abusive Communication", true
GUI_OPT_REASONS_GRIEFING = gui.Checkbox GUI_OPT_REASONS, "reasons.griefing", "Griefing", true
GUI_OPT_REASONS_AIM = gui.Checkbox GUI_OPT_REASONS, "reasons.aim", "Aimhacking", true
GUI_OPT_REASONS_WALL = gui.Checkbox GUI_OPT_REASONS, "reasons.wall", "Wallhacking", true
GUI_OPT_REASONS_EXTERNAL = gui.Checkbox GUI_OPT_REASONS, "reasons.external", "External assistance", true

client.AllowListener "player_death"
callbacks.Register "FireGameEvent", (event) ->
    if event\GetName! != "player_death"
        return
    if client.GetPlayerIndexByUserID( event\GetInt"userid" ) != client.GetLocalPlayerIndex!
        return
    if not GUI_OPT_ENABLE\GetValue!
        return

    reasons = {}
    if GUI_OPT_REASONS_ABUSIVECOMMUNICATION\GetValue!
        table.insert reasons, "textabuse"
    if GUI_OPT_REASONS_GRIEFING\GetValue!
        table.insert reasons, "grief"
    if GUI_OPT_REASONS_AIM\GetValue!
        table.insert reasons, "aimbot"
    if GUI_OPT_REASONS_WALL\GetValue!
        table.insert reasons, "wallhack"
    if GUI_OPT_REASONS_EXTERNAL\GetValue!
        table.insert reasons, "speedhack"

    steam3_32bit = event\GetInt"attacker"
    steam3_64bit = "7656" .. (0x116ebff0000 + steam3_32bit)

    print "reporting", steam3_64bit, "for", table.concat reasons, ','
    panorama.RunScript "GameStateAPI.SubmitPlayerReport( '#{steam3_64bit}', '#{table.concat reasons, ','}' )"
return "__REMOVE_ME__"