--!strict
-- loaderui - entry point animula ui
-- cukup execute file ini doang, semua module di ComponentsUI bakal ke load otomatis
-- gw bikin gini biar user gak pusing harus require satu2

-- btw ini versi 2.1, udah gw humanize biar gak keliatan AI wkwk
-- kalo ada bug tag gw di discord aja

local ComponentsUI = script:FindFirstChild("ComponentsUI")
if not ComponentsUI then
    -- kadang orang mindahin LoaderUI ke folder lain, jadi fallback ke parent
    ComponentsUI = script.Parent:FindFirstChild("ComponentsUI")
end
assert(ComponentsUI, "[AnimulaUI] folder ComponentsUI gak ketemu! pastiin ada di Script/MainUI/ComponentsUI/")

local function need(path: string): any
    -- path kayak "Theme/AnimulaTheme" -> ComponentsUI/Theme/AnimulaTheme
    local cur: Instance = ComponentsUI
    for part in string.gmatch(path, "[^/]+") do
        local nxt = cur:FindFirstChild(part)
        assert(nxt, "[AnimulaUI] module ilang: " .. path .. " (gak nemu: " .. part .. ")")
        cur = nxt
    end
    return require(cur)
end

-- load semua module
-- urutannya penting jgn di acak!
local Theme        = need("Theme/AnimulaTheme")
local Config       = need("Core/Config")
local WindowMod    = need("Window/Window")
local TabManager   = need("Tabs/TabManager")
local Notification = need("Notification/Notification")

-- animula ui object - ini yg di return ke user
local AnimulaUI = {}

AnimulaUI.Version = "2.1.0-hydro-wave" -- cakep kan namanya wkwk
AnimulaUI.Theme   = Theme
AnimulaUI.Config  = Config
AnimulaUI.Flags   = Config.Flags -- biar bisa AnimulaUI.Flags["flag"].Value kayak orion

-- buat window - ini fungsi utama
-- contoh:
--   local Window = AnimulaUI:MakeWindow({ Name = "Animula Hub" })
--   local Tab = Window:MakeTab({ Name = "Home", Icon = "◈" })
function AnimulaUI:MakeWindow(cfg: any): any
    local win = WindowMod.new(cfg or {})
    TabManager.Attach(win)
    return win
end

-- alias biar yg biasa pake CreateWindow juga bisa
AnimulaUI.CreateWindow = AnimulaUI.MakeWindow

-- notif - ada 2 nama biar kompat sama orion & yg lama
function AnimulaUI:MakeNotification(cfg: any)
    return Notification.Notify(cfg)
end

function AnimulaUI:Notify(cfg: any)
    return Notification.Notify(cfg)
end

function AnimulaUI:Dialog(cfg: any, parent: Frame?)
    return Notification.Dialog(cfg, parent)
end

function AnimulaUI:Popup(cfg: any)
    return Notification.Popup(cfg)
end

-- orion wajib manggil Init() di akhir, di kita sih gak perlu tapi biar kompat aja
function AnimulaUI:Init()
    -- no-op, window udah live dari MakeWindow
    return
end

-- hancurin semua ui animula yg ada
function AnimulaUI:Destroy()
    local ok, hui = pcall(function() return (gethui :: any) and gethui() end)
    local root: Instance? = nil
    if ok and typeof(hui) == "Instance" then
        root = hui
    else
        local lp = game:GetService("Players").LocalPlayer
        root = lp and lp:FindFirstChildOfClass("PlayerGui")
    end
    if not root then return end
    for _, ch in ipairs(root:GetChildren()) do
        if ch:IsA("ScreenGui") and string.match(ch.Name, "^AnimulaUI") then
            ch:Destroy()
        end
    end
end

-- ganti theme runtime
function AnimulaUI:SetTheme(name: string)
    Theme:SetVariant(name)
end

-- expose responsive helper juga biar user bisa cek device
-- misal: if AnimulaUI.Responsive.GetDevice() == "Phone" then ...
local Responsive = need("Core/Responsive")
AnimulaUI.Responsive = Responsive

-- expose effects & animations juga, biar bisa di pake manual kalo mau
local okEff, OceanEffects = pcall(function() return need("Effects/OceanEffects") end)
if okEff and OceanEffects then
    AnimulaUI.Effects = OceanEffects
end
local okMot, Motion = pcall(function() return need("Animations/Motion") end)
if okMot and Motion then
    AnimulaUI.Motion = Motion
end

return AnimulaUI
