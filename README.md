# Animula Official — UI Library (Furina Ocean Theme)

> Beautiful, modern, and high-performance Roblox Lua UI Library inspired by Fontaine (Furina Hydro Theme). Fully compatible with Orion Library API syntax.

## 🚀 Quick Boot
```lua
local Animula = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnimulaOffcial/UI/main/Script/MainUI/UILoader.lua"))()

local Window = Animula:MakeWindow({
    Name = "Animula Hub - Furina Ocean",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "AnimulaHub"
})
```

## 💎 Features
- **Fontaine Ocean Aesthetics**: Deep Navy & Glowing Hydro Cyan palette (`#38bdf8`).
- **100% Orion API Compatibility**: `MakeWindow`, `MakeTab`, `AddSection`, `AddButton`, `AddToggle`, `AddSlider`, `AddDropdown`, `AddTextbox`, `AddColorpicker`, `AddBind`, `AddParagraph`, `AddLabel`, `MakeNotification`, `Init`, `Destroy`, `SaveConfig`.
- **Smooth Dragging & Animations**: Interpolated Lerp Dragging and fluid TweenService animations.
- **Universal Executor Protection**: Auto-fallback support for `gethui()`, `syn.protect_gui`, `CoreGui`, and `PlayerGui`.
