--!strict
-- =============================================================================
--  Notification.lua — Toast, Dialog, Popup
--  Lokasi: Script/MainUI/ComponentsUI/Notification/Notification.lua
--
--  API Orion-compatible:
--    AnimulaUI:MakeNotification({ Name, Content, Image, Time })
--  Animula-native:
--    AnimulaUI:Notify({ Title, Desc, Duration, Type })
--    AnimulaUI:Dialog({ Title, Desc, Buttons })
--    AnimulaUI:Popup({ Title, Desc })
-- =============================================================================

local Theme       = require(script.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Core.Performance)

local Notification = {}

local notifGui: ScreenGui? = nil
local notifContainer: Frame? = nil

-- ---------------------------------------------------------------------------
local function ensureGui()
    if notifGui and notifGui.Parent then return end

    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Notifications"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 9999
    sg.Parent         = hui

    local container = Instance.new("Frame")
    container.Name                  = "Container"
    container.BackgroundTransparency = 1
    container.Size                  = UDim2.fromScale(1, 1)
    container.Parent                = sg

    local list = Instance.new("UIListLayout")
    list.FillDirection       = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Right
    list.VerticalAlignment   = Enum.VerticalAlignment.Bottom
    list.Padding             = UDim.new(0, 8)
    list.SortOrder           = Enum.SortOrder.LayoutOrder
    list.Parent              = container

    Utils.Padding(container, 0, 0, 16, 16)

    notifGui       = sg
    notifContainer = container
end

-- ---------------------------------------------------------------------------
--  Notify — toast
-- ---------------------------------------------------------------------------
function Notification.Notify(cfg: any): Frame
    cfg = cfg or {}

    -- Orion keys: Name/Content/Image/Time  →  normalize
    local title: string = cfg.Title or cfg.Name or "Notification"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local duration: number = cfg.Duration or cfg.Time or 3
    local ntype: string = cfg.Type or "Info"

    ensureGui()
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local colorMap: { [string]: Color3 } = {
        Info    = T.Info,
        Success = T.Success,
        Warning = T.Warning,
        Error   = T.Error,
    }
    local accent: Color3 = (colorMap :: any)[ntype] or T.Primary

    local toast = Instance.new("Frame")
    toast.BackgroundColor3 = T.Surface
    toast.Size             = UDim2.fromOffset(300, if desc ~= "" then 72 else 52)
    toast.Parent           = notifContainer
    Utils.Corner(toast, R.Medium)
    Utils.Stroke(toast, T.Border, 1, 0.35)
    toast.ClipsDescendants = true

    local bar = Instance.new("Frame")
    bar.BackgroundColor3 = accent
    bar.Size             = UDim2.fromOffset(4, 999)
    bar.BorderSizePixel  = 0
    bar.Parent           = toast

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(14, 10)
    t1.Size       = UDim2.new(1, -28, 0, 16)
    t1.FontFace   = F.Heading
    t1.TextSize   = S.Body
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = toast

    if desc ~= "" then
        local t2 = Instance.new("TextLabel")
        t2.BackgroundTransparency = 1
        t2.Position   = UDim2.fromOffset(14, 28)
        t2.Size       = UDim2.new(1, -28, 0, 28)
        t2.FontFace   = F.Body
        t2.TextSize   = S.Small
        t2.TextColor3 = T.TextDim
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top
        t2.TextWrapped = true
        t2.Text        = desc
        t2.Parent      = toast
    end

    -- Image (optional rbxassetid)
    if cfg.Image and string.match(cfg.Image, "^rbxassetid://") then
        local img = Instance.new("ImageLabel")
        img.BackgroundTransparency = 1
        img.Size     = UDim2.fromOffset(20, 20)
        img.Position = UDim2.fromOffset(276, 10)
        img.Image    = cfg.Image
        img.Parent   = toast
    end

    -- Anti-lag: batasi toast, queue FIFO
    Performance.EnforceLimit(notifContainer :: Frame, Performance.NotifyLimit)

    toast.Position = UDim2.new(0, 320, 0, 0)
    Performance.Tween(toast, { Position = UDim2.fromOffset(0, 0) }, 0.32, Enum.EasingStyle.Back)

    task.delay(duration, function()
        if toast.Parent then
            Performance.Tween(toast, { Position = UDim2.new(0, 320, 0, 0) }, 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.wait(0.24)
            toast:Destroy()
        end
    end)

    return toast
end

-- Orion alias
Notification.MakeNotification = Notification.Notify

-- ---------------------------------------------------------------------------
--  Dialog
-- ---------------------------------------------------------------------------
function Notification.Dialog(cfg: any, parentWindow: Frame?): any
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Dialog"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local buttons: any  = cfg.Buttons or cfg.Options or {
        { Title = "Cancel",  Variant = "Secondary" },
        { Title = "Confirm", Variant = "Primary", Callback = cfg.Callback },
    }

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local hui = Utils.getHui()
    local isChild = parentWindow ~= nil
    local overlay: Frame
    local sg: Instance

    if isChild then
        sg = parentWindow :: Frame
        overlay = Instance.new("Frame")
        overlay.Name                  = "DialogOverlay"
        overlay.BackgroundColor3      = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.Size                  = UDim2.fromScale(1, 1)
        overlay.ZIndex                = 50
        overlay.Parent                = parentWindow
    else
        local s = Instance.new("ScreenGui")
        s.Name           = "AnimulaUI_Dialog"
        s.ResetOnSpawn   = false
        s.IgnoreGuiInset = true
        s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        s.DisplayOrder   = 100
        s.Parent         = hui
        sg = s

        overlay = Instance.new("Frame")
        overlay.BackgroundColor3      = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.Size                  = UDim2.fromScale(1, 1)
        overlay.Parent                = s
    end

    local dialog = Instance.new("Frame")
    dialog.BackgroundColor3 = T.Surface
    dialog.Size             = UDim2.fromOffset(360, 180)
    dialog.Position         = UDim2.fromScale(0.5, 0.5)
    dialog.AnchorPoint      = Vector2.new(0.5, 0.5)
    dialog.Parent           = overlay
    Utils.Corner(dialog, R.Large)
    Utils.Stroke(dialog, T.Border, 1, 0.25)

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(18, 16)
    t1.Size       = UDim2.new(1, -36, 0, 20)
    t1.FontFace   = F.Title
    t1.TextSize   = S.Title - 1
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = dialog

    local t2 = Instance.new("TextLabel")
    t2.BackgroundTransparency = 1
    t2.Position   = UDim2.fromOffset(18, 42)
    t2.Size       = UDim2.new(1, -36, 0, 60)
    t2.FontFace   = F.Body
    t2.TextSize   = S.Small
    t2.TextColor3 = T.TextDim
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.TextYAlignment = Enum.TextYAlignment.Top
    t2.TextWrapped = true
    t2.Text        = desc
    t2.Parent      = dialog

    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size     = UDim2.new(1, -36, 0, 32)
    row.Position = UDim2.new(0, 18, 1, -44)
    row.Parent   = dialog

    local rowList = Instance.new("UIListLayout")
    rowList.FillDirection       = Enum.FillDirection.Horizontal
    rowList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    rowList.Padding             = UDim.new(0, 8)
    rowList.Parent              = row

    local function close()
        Performance.Tween(dialog,  { BackgroundTransparency = 1 }, 0.14)
        Performance.Tween(overlay, { BackgroundTransparency = 1 }, 0.14)
        task.wait(0.15)
        if isChild then
            overlay:Destroy()
        else
            (sg :: ScreenGui):Destroy()
        end
    end

    for _, b in ipairs(buttons) do
        local bTitle: string = b.Title or b.Text or "OK"
        local variant: string = b.Variant or "Secondary"
        local cb: (() -> ())? = b.Callback

        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = if variant == "Primary" then T.Primary else T.SurfaceLight
        btn.Size             = UDim2.fromOffset(84, 32)
        btn.FontFace         = F.Heading
        btn.TextSize         = S.Small
        btn.TextColor3       = if variant == "Primary" then T.TextOnPrimary else T.Text
        btn.Text             = bTitle
        btn.AutoButtonColor  = false
        btn.Parent           = row
        Utils.Corner(btn, R.Small)
        if variant == "Primary" then
            Utils.Gradient(btn, T.Primary, T.PrimaryDark, 90)
        else
            Utils.Stroke(btn, T.Border, 1, 0.4)
        end

        btn.MouseButton1Click:Connect(function()
            if cb then task.spawn(cb) end
            close()
        end)
    end

    dialog.Size = UDim2.fromOffset(340, 170)
    Performance.Tween(dialog, { Size = UDim2.fromOffset(360, 180) }, 0.24, Enum.EasingStyle.Back)

    return { Close = close, Frame = dialog }
end

-- ---------------------------------------------------------------------------
--  Popup
-- ---------------------------------------------------------------------------
function Notification.Popup(cfg: any): any
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Popup"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Popup"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 90
    sg.Parent         = hui

    local popup = Instance.new("Frame")
    popup.BackgroundColor3 = T.Surface
    popup.Size     = UDim2.fromOffset(320, 140)
    popup.Position = UDim2.fromScale(0.5, 0.5)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.Parent   = sg
    Utils.Corner(popup, R.Large)
    Utils.Stroke(popup, T.Border, 1, 0.3)

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(16, 12)
    t1.Size       = UDim2.new(1, -32, 0, 18)
    t1.FontFace   = F.Title
    t1.TextSize   = 14
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = popup

    if desc ~= "" then
        local d = Instance.new("TextLabel")
        d.BackgroundTransparency = 1
        d.Position   = UDim2.fromOffset(16, 34)
        d.Size       = UDim2.new(1, -32, 0, 60)
        d.FontFace   = F.Body
        d.TextSize   = S.Small
        d.TextColor3 = T.TextDim
        d.TextWrapped = true
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.TextYAlignment = Enum.TextYAlignment.Top
        d.Text        = desc
        d.Parent      = popup
    end

    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundColor3 = T.SurfaceLight
    closeBtn.Size     = UDim2.fromOffset(24, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 8)
    closeBtn.FontFace = F.Body
    closeBtn.TextSize = 12
    closeBtn.TextColor3 = T.TextMuted
    closeBtn.Text     = "✕"
    closeBtn.Parent   = popup
    Utils.Corner(closeBtn, UDim.new(1, 0))

    local function close()
        Performance.Tween(popup, { BackgroundTransparency = 1 }, 0.16)
        task.wait(0.16)
        sg:Destroy()
    end

    closeBtn.MouseButton1Click:Connect(close)
    task.delay(cfg.Duration or 4, close)

    return { Close = close }
end

return Notification
