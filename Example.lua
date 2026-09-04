--!strict
-- contoh pake animula ui - copy aja ini kalo mau coba
-- btw ini gw bikin sambil ngantuk jam 2 malem, kalo ada typo wajar ya wkwk
-- execute cukup require LoaderUI doang!

local AnimulaUI = require(script.Parent.LoaderUI)
-- kalo lu biasa pake orion, bisa juga: local OrionLib = AnimulaUI

-- bikin window
local Window = AnimulaUI:MakeWindow({
    Name         = "Animula Project  ◈  Fontaine",
    SubTitle     = "Hydro Archon - Biru Furina", -- ini tambahan animula, di orion gak ada
    -- Icon      = "◈",
    SaveConfig   = true,
    ConfigFolder = "AnimulaHub",
    IntroEnabled = false,
    -- Theme     = "AnimulaDark", -- ada Dark / Light / Midnight, default Dark paling cakep
})

-- bikin tabs
local HomeTab    = Window:MakeTab({ Name = "Home",     Icon = "rbxassetid://4483345998" })
local CombatTab  = Window:MakeTab({ Name = "Combat",   Icon = "rbxassetid://4483345998" })
local SettingTab = Window:MakeTab({ Name = "Settings", Icon = "rbxassetid://4483345998" })

-- ===================== HOME =====================
HomeTab:AddParagraph(
    "Welcome to AnimulaUI ♡",
    "tema biru hydro archon, cakep parah sumpah. udah ada wave + bubble + glow + glass, "
        .. "100x lebih hidup dari ui biasa. execute cuma LoaderUI.lua doang ya!"
)

HomeTab:AddSection({ Name = "Quick Actions" })

HomeTab:AddButton({
    Name = "Sapa Fontaine ◈",
    Callback = function()
        AnimulaUI:MakeNotification({
            Name    = "Bonjour ! ◈",
            Content = "Animula nyapa traveler - la vie est belle à Fontaine!",
            Image   = "rbxassetid://4483345998",
            Time    = 3,
        })
    end,
})

-- toggle god mode
local GodToggle = HomeTab:AddToggle({
    Name     = "God Mode",
    Default  = false,
    Flag     = "GodMode",
    Save     = true,
    Callback = function(v: boolean)
        print("[GodMode]", v)
        AnimulaUI:Notify({
            Title = if v then "God Mode ON" else "God Mode OFF",
            Desc  = if v then "hydro power unleashed!" else "power sealed.",
            Type  = if v then "Success" else "Warning",
            Duration = 1.8,
        })
    end,
})

HomeTab:AddSlider({
    Name      = "WalkSpeed",
    Min       = 16,
    Max       = 120,
    Default   = 16,
    Increment = 2,
    ValueName = "studs",
    Flag      = "WalkSpeed",
    Save      = true,
    Callback  = function(v: number)
        local lp  = game.Players.LocalPlayer
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end,
})

-- progress bar demo - ini baru di animula, keren abis
HomeTab:AddSection({ Name = "Stats (Baru!)" })
HomeTab:AddLabel("Level Progress - ada shimmer nya wkwk")

-- cek Flags kayak orion
HomeTab:AddButton({
    Name = "Cek Flags",
    Callback = function()
        local god = AnimulaUI.Flags["GodMode"] and AnimulaUI.Flags["GodMode"].Value
        local ws  = AnimulaUI.Flags["WalkSpeed"] and AnimulaUI.Flags["WalkSpeed"].Value
        print("GodMode:", god, "| WalkSpeed:", ws)
        AnimulaUI:Notify({
            Title = "Flags",
            Desc  = "GodMode=" .. tostring(god) .. " WalkSpeed=" .. tostring(ws),
            Type  = "Info",
        })
    end,
})

-- ===================== COMBAT =====================
CombatTab:AddSection({ Name = "WEAPON" })

local WeaponDropdown = CombatTab:AddDropdown({
    Name     = "Weapon Mode",
    Default  = "Hydro Blade",
    Options  = { "Hydro Blade", "Ocean Claymore", "Fontaine Rifle", "Vision Burst" },
    Flag     = "WeaponMode",
    Save     = true,
    Callback = function(v: string) print("Weapon:", v) end,
})

CombatTab:AddDropdown({
    Name     = "Targets",
    Default  = "Mobs",
    Options  = { "Boss", "Mobs", "Players", "Dummy" },
    Callback = function(v) print("Target:", v) end,
})

CombatTab:AddSlider({
    Name      = "Damage Multiplier",
    Min       = 1,
    Max       = 10,
    Default   = 1,
    Increment = 1,
    ValueName = "x",
    Callback  = function(v) print("Damage x", v) end,
})

CombatTab:AddToggle({
    Name     = "Auto Attack",
    Default  = false,
    Callback = function(v) print("AutoAttack:", v) end,
})

CombatTab:AddButton({
    Name = "Fire Hydro Cannon 💧",
    Callback = function()
        AnimulaUI:Dialog({
            Title = "Yakin mau nembak?",
            Desc  = "Hydro Cannon bakal di tembakin ke target, yakin?",
            Buttons = {
                { Title = "Gajadi", Variant = "Secondary" },
                {
                    Title = "Tembak!",
                    Variant = "Primary",
                    Callback = function()
                        AnimulaUI:Notify({
                            Title = "Dor! 💥",
                            Desc  = "Hydro Cannon meluncur!",
                            Type  = "Success",
                        })
                        -- kasih efek shake dikit biar berasa
                        if AnimulaUI.Motion then
                            -- shake window nya, cakep
                        end
                    end,
                },
            },
        })
    end,
})

CombatTab:AddButton({
    Name = "Refresh Weapon List",
    Callback = function()
        WeaponDropdown:Refresh({ "Hydro Blade", "Abyss Spear", "Neuvillette Seal" }, true)
    end,
})

-- ===================== SETTINGS =====================
SettingTab:AddSection({ Name = "APPEARANCE" })
-- note: di html, dark mode pake css media query, di roblox kita pake Theme:SetVariant

SettingTab:AddDropdown({
    Name     = "Theme",
    Default  = "AnimulaDark",
    Options  = { "AnimulaDark", "AnimulaLight", "AnimulaMidnight" },
    Callback = function(v: string)
        Window:SetTheme(v)
        -- di html font tetep, di roblox textsize juga tetep 13-18, cuma warna yg ganti
        AnimulaUI:Notify({ Title = "Theme: " .. v, Type = "Info", Duration = 1.4 })
    end,
})

SettingTab:AddColorpicker({
    Name     = "Accent Preview",
    Default  = Color3.fromRGB(77, 163, 255),
    Callback = function(c: Color3) print("Color:", c:ToHex()) end,
})

SettingTab:AddBind({
    Name     = "Toggle UI Key",
    Default  = Enum.KeyCode.RightShift,
    Hold     = false,
    Callback = function() print("toggle key kepencet") end,
})

SettingTab:AddTextbox({
    Name          = "Nama Player",
    Default       = game.Players.LocalPlayer.Name,
    TextDisappear = false,
    Callback      = function(v: string) print("Input:", v) end,
})

SettingTab:AddLabel("—  AnimulaUI v2.1 hydro wave • cuma LoaderUI.lua yg di execute —")

-- demo set value dari luar (kayak orion Toggle:Set / Slider:Set)
task.delay(1, function()
    -- GodToggle:Set(true) -- uncomment kalo mau auto on
    -- WeaponDropdown:Set("Vision Burst")
    print("[AnimulaUI] tips: semua element bisa di .Set() dari luar callback")
end)

-- wajib di orion, di animula sih no-op tapi biar kompat
AnimulaUI:Init()

print("[AnimulaUI] loaded, 3 tabs ready. have fun!")
return Window
