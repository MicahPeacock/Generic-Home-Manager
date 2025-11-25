local wezterm = require('wezterm')
local actions = wezterm.action

local bindings = {}
-- Pane Management
for _, value in ipairs({
    { "Enter",      actions.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { "w",          actions.CloseCurrentPane { confirm = true } },
    { "LeftArrow",  actions.ActivatePaneDirection 'Left' },
    { "RightArrow", actions.ActivatePaneDirection 'Right' },
    { "UpArrow",    actions.ActivatePaneDirection 'Up' },
    { "DownArrow",  actions.ActivatePaneDirection 'Down' },
    { "t",          actions.SpawnTab 'CurrentPaneDomain' },
    { "q",          actions.CloseCurrentTab { confirm = true } },
    { "c",          actions.CopyTo 'ClipboardAndPrimarySelection' },
    { "v",          actions.PasteFrom 'Clipboard' },
    { "=",          actions.IncreaseFontSize },
    { "-",          actions.DecreaseFontSize },
    { "0",          actions.ResetFontSize }
}) do table.insert(bindings, { mods = "ALT", key = value[1], action = value[2] }) end

-- ALT + SHIFT Combinations
table.insert(bindings, {
    mods = "ALT|SHIFT", key = "Enter", action = actions.SplitVertical { domain = 'CurrentPaneDomain' }
})

-- Tab Navigation (ALT + 1-8)
for i = 0, 7 do table.insert(bindings, { mods = "ALT", key = tostring(i + 1), action = actions.ActivateTab(i) }) end

-- Tab Movement and Last Tab (CTRL + ALT)
for _, value in ipairs({
    { "UpArrow",    actions.ActivateLastTab },
    { "DownArrow",  actions.ActivateLastTab },
    { "LeftArrow",  actions.MoveTabRelative(-1) },
    { "RightArrow", actions.MoveTabRelative(1) }
}) do table.insert(bindings, { mods = "CTRL|ALT", key = value[1], action = value[2] }) end

for i = 0, 7 do table.insert(bindings, { mods = "CTRL|ALT", key = tostring(i + 1), action = actions.MoveTab(i) }) end

return bindings
