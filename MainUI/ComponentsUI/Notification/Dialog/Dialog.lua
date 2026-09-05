--!strict
-- Notification/Dialog/Dialog.lua - modal dialog di tengah window

local Theme       = require(script.Parent.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Parent.Core.Performance)

local Dialog = {}

function Dialog.Show(cfg: any, parentWindow: Frame?): any
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
        if isChild then overlay:Destroy()
        else (sg :: ScreenGui):Destroy() end
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
        if variant == "Primary" then Utils.Gradient(btn, T.Primary, T.PrimaryDark, 90)
        else Utils.Stroke(btn, T.Border, 1, 0.4) end
        btn.MouseButton1Click:Connect(function()
            if cb then task.spawn(cb) end
            close()
        end)
    end

    dialog.Size = UDim2.fromOffset(340, 170)
    Performance.Tween(dialog, { Size = UDim2.fromOffset(360, 180) }, 0.24, Enum.EasingStyle.Back)

    return { Close = close, Frame = dialog }
end

return Dialog
