--[[
MIT License
Copyright (c) 2025 YourName

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
...
(the rest of the MIT text)
]]

local obs = obslua

--------------------------------------------------------------------------------
-- Configuration / Logging
--------------------------------------------------------------------------------
local current_source = ""
local function log(msg)
    print(("[MapToggle] %s"):format(msg))
end

--------------------------------------------------------------------------------
-- Description shown in OBS Scripts UI
--------------------------------------------------------------------------------
function script_description()
    return [[
Rust MapToggle for OBS

Hold G, Shift+G or Ctrl+G to peek your map overlay. Also hides map while sprinting or crouching, no need to press an extra key to unhide the map.
Release G to hide the hidden map image.

-How To Setup-
1. Enter your exact map hidden image name below
2. Assign hotkeys under Settings → Hotkeys → Look for (Hold Shift+G, Hold G, Hold Ctrl+G)
3. Start OBS with the map image hidden
4. Enjoy streaming rust with no stream snipers!
    ]]
end

--------------------------------------------------------------------------------
-- Properties: scene source name input
--------------------------------------------------------------------------------
function script_properties()
    local props = obs.obs_properties_create()
    obs.obs_properties_add_text(
        props,
        "scene_name",
        "Scene Source Name",
        obs.OBS_TEXT_DEFAULT
    )
    return props
end

--------------------------------------------------------------------------------
-- Save the scene name when you hit Apply
--------------------------------------------------------------------------------
function script_update(settings)
    current_source = obs.obs_data_get_string(settings, "scene_name")
    log("Scene set to: " .. current_source)
end

--------------------------------------------------------------------------------
-- Toggle Logic
--------------------------------------------------------------------------------
local function toggle_map(visible)
    local src = obs.obs_get_source_by_name(current_source)
    if not src then
        log("ERROR: source not found → " .. current_source)
        return
    end
    obs.obs_source_set_enabled(src, visible)
    obs.obs_source_release(src)
    log((visible and "Showing " or "Hiding ") .. current_source)
end

--------------------------------------------------------------------------------
-- Hotkey Registration & Management
--------------------------------------------------------------------------------
local hotkeys = {
    G       = { id = obs.OBS_INVALID_HOTKEY_ID, name = "map_toggle_g",  label = "Hold G to toggle map (Press G)" },
    SHIFTG  = { id = obs.OBS_INVALID_HOTKEY_ID, name = "map_toggle_sg", label = "Hold Shift+G to toggle map (Press Shift+G)" },
    CTRLG   = { id = obs.OBS_INVALID_HOTKEY_ID, name = "map_toggle_cg", label = "Hold Ctrl+G to toggle map (Press Ctrl+G)" },
}

local function on_hotkey(pressed)
    toggle_map(pressed)
end

local function register_hotkeys(settings)
    for _, v in pairs(hotkeys) do
        v.id = obs.obs_hotkey_register_frontend(v.name, v.label, on_hotkey)
        local arr = obs.obs_data_get_array(settings, v.name)
        obs.obs_hotkey_load(v.id, arr)
        obs.obs_data_array_release(arr)
    end
    log("Hotkeys registered")
end

local function save_hotkeys(settings)
    for _, v in pairs(hotkeys) do
        local arr = obs.obs_hotkey_save(v.id)
        obs.obs_data_set_array(settings, v.name, arr)
        obs.obs_data_array_release(arr)
    end
end

--------------------------------------------------------------------------------
-- OBS Script Callbacks
--------------------------------------------------------------------------------
function script_load(settings)
    log("Loading MapToggle…")
    register_hotkeys(settings)
end

function script_save(settings)
    save_hotkeys(settings)
end
