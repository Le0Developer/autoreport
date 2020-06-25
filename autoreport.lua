local GUI_TAB = gui.Tab(gui.Reference("Misc"), "autoreport", "Auto Report")
local GUI_OPT = gui.Groupbox(GUI_TAB, "Options", 4, 4, 200, 400)
local GUI_OPT_ENABLE
do
  local _with_0 = gui.Checkbox(GUI_OPT, "enable", "Enable Autoreport", false)
  _with_0:SetDescription("Automatically report the player who kills you.")
  GUI_OPT_ENABLE = _with_0
end
local GUI_OPT_REASONS = gui.Multibox(GUI_OPT, "Reasons")
local GUI_OPT_REASONS_ABUSIVECOMMUNICATION = gui.Checkbox(GUI_OPT_REASONS, "reasons.abusive_communication", "Abusive Communication", true)
local GUI_OPT_REASONS_GRIEFING = gui.Checkbox(GUI_OPT_REASONS, "reasons.griefing", "Griefing", true)
local GUI_OPT_REASONS_AIM = gui.Checkbox(GUI_OPT_REASONS, "reasons.aim", "Aimhacking", true)
local GUI_OPT_REASONS_WALL = gui.Checkbox(GUI_OPT_REASONS, "reasons.wall", "Wallhacking", true)
local GUI_OPT_REASONS_EXTERNAL = gui.Checkbox(GUI_OPT_REASONS, "reasons.external", "External assistance", true)
client.AllowListener("player_death")
callbacks.Register("FireGameEvent", function(event)
  if event:GetName() ~= "player_death" then
    return 
  end
  if client.GetPlayerIndexByUserID(event:GetInt("userid")) ~= client.GetLocalPlayerIndex() then
    return 
  end
  if not GUI_OPT_ENABLE:GetValue() then
    return 
  end
  local reasons = { }
  if GUI_OPT_REASONS_ABUSIVECOMMUNICATION:GetValue() then
    table.insert(reasons, "textabuse")
  end
  if GUI_OPT_REASONS_GRIEFING:GetValue() then
    table.insert(reasons, "grief")
  end
  if GUI_OPT_REASONS_AIM:GetValue() then
    table.insert(reasons, "aimbot")
  end
  if GUI_OPT_REASONS_WALL:GetValue() then
    table.insert(reasons, "wallhack")
  end
  if GUI_OPT_REASONS_EXTERNAL:GetValue() then
    table.insert(reasons, "speedhack")
  end
  local steam3_32bit = event:GetInt("attacker")
  local steam3_64bit = "7656" .. (0x116ebff0000 + steam3_32bit)
  print("reporting", steam3_64bit, "for", table.concat(reasons, ','))
  return panorama.RunScript("GameStateAPI.SubmitPlayerReport( '" .. tostring(steam3_64bit) .. "', '" .. tostring(table.concat(reasons, ',')) .. "' )")
end)

