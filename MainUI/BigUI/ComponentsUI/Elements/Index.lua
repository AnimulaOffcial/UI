-- elements index - daftar element yg ada di animula ui
-- sebenernya logic nya di TabManager.lua, disini cuma dokumentasi biar gak lupa

local Index = {}

Index.Available = {
    "AddButton      - Tab:AddButton({ Name, Callback })",
    "AddToggle      - Tab:AddToggle({ Name, Default, Flag, Save, Callback })",
    "AddSlider      - Tab:AddSlider({ Name, Min, Max, Default, Increment, ValueName, Callback })",
    "AddDropdown    - Tab:AddDropdown({ Name, Default, Options, Callback }) + Refresh/Set",
    "AddTextbox     - Tab:AddTextbox({ Name, Default, TextDisappear, Callback })",
    "AddBind        - Tab:AddBind({ Name, Default, Hold, Callback }) - keybind",
    "AddColorpicker - Tab:AddColorpicker({ Name, Default, Callback })",
    "AddLabel       - Tab:AddLabel('text')",
    "AddParagraph   - Tab:AddParagraph('Title','Content')",
    "AddSection     - Tab:AddSection({ Name })",
    "AddDivider     - Tab:AddDivider('optional text')",
}

-- tambahan animula (gak ada di orion):
-- - Progress bar (Effects.OceanEffects.ProgressBar)
-- - Wave / Glass / Glow / Bubbles (Effects.OceanEffects)
-- - Motion.* (Animations.Motion) - Spring, SlideIn, Pop, TabSwitch, Shake, Pulse

Index.Notes = {
    html_vs_roblox = "TextSize di roblox = pixel Fixed, jangan pake TextScaled buat UI util",
    window_size    = "Desktop 600x400, Phone 0.92 scale, Tablet 0.76 - auto via Responsive.lua",
    tween_rule     = "jangan spam tween, pake Performance.Tween pooling, durasi 0.18-0.35s",
}

return Index
