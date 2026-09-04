--!strict
-- window.lua - bikin window animula
-- ini file paling penting, jadi gw komen agak banyak biar gak lupa
-- update 04/09: nambahin wave + glass + glow + particle biar gak boring
-- sumpah capek bgt ngatur gradient nya wkwk tapi hasilnya cakep parah

local Theme       = require(script.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Core.Utils)
local Config      = require(script.Parent.Parent.Core.Config)
local Performance = require(script.Parent.Parent.Core.Performance)
local Responsive  = require(script.Parent.Parent.Core.Responsive)

local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

export type WindowConfig = {
    Name: string?,
    Title: string?, -- alias, biar kompat sama orion
    SubTitle: string?,
    Icon: string?,
    Author: string?,
    Size: UDim2?,
    Theme: string?,
    SaveConfig: boolean?,
    ConfigFolder: string?,
    IntroEnabled: boolean?,
    IntroText: string?,
    CloseCallback: (() -> ())?,
    ToggleKey: Enum.KeyCode?,
    Draggable: boolean?,
}

-- helper kecil buat bikin wave layer di belakang window
-- gw taro di dalem file ini aja biar gak kebanyakan require
local function attachWave(main: Frame, T: any)
    -- wave 1 - biru muda transparan, gerak pelan
    local wave = Instance.new("Frame")
    wave.Name                   = "WaveFX"
    wave.BackgroundColor3       = T.Wave1
    wave.BackgroundTransparency = 0.90
    wave.Size                   = UDim2.fromScale(1, 1)
    wave.BorderSizePixel        = 0
    wave.ZIndex                 = 1
    wave.Parent                 = main
    -- corner nya ngikut window
    local wc = Instance.new("UICorner")
    wc.CornerRadius = UDim.new(0, 16)
    wc.Parent       = wave
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   T.Wave1),
        ColorSequenceKeypoint.new(0.5, T.Wave2),
        ColorSequenceKeypoint.new(1,   T.PrimaryDark),
    })
    grad.Rotation = 18
    grad.Offset   = Vector2.new(-0.2, 0)
    grad.Parent   = wave

    -- animasi bolak balik, pelan aja biar gak pusing
    task.spawn(function()
        local dir = 1
        while grad.Parent do
            local target = if dir == 1 then Vector2.new(0.2, 0) else Vector2.new(-0.2, 0)
            local tw = Performance.Tween(grad, { Offset = target }, 5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            tw.Completed:Wait()
            if not grad.Parent then break end
            dir *= -1
        end
    end)

    -- shimmer di atas wave biar kilau
    local shimmer = Instance.new("Frame")
    shimmer.Name                   = "WaveShimmer"
    shimmer.BackgroundColor3       = Color3.new(1, 1, 1)
    shimmer.BackgroundTransparency = 1
    shimmer.Size                   = UDim2.fromScale(1, 1)
    shimmer.BorderSizePixel        = 0
    shimmer.ZIndex                 = 2
    shimmer.Parent                 = main
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 16)
    sc.Parent       = shimmer
    -- shimmer di handle sama OceanEffects kalo ada, tapi kita bikin simple aja disini
    -- biar gak perlu require lagi

    return wave
end

-- bubble kecil2 di pinggir window, lucu sih
local function spawnBubbles(parent: Frame)
    -- cuma 5 bubble, jangan kebanyakan ntar lag
    for i = 1, 5 do
        local sz: number = math.random(3, 7)
        local b = Instance.new("Frame")
        b.Name                   = "Bubble" .. tostring(i)
        b.BackgroundColor3       = Color3.fromRGB(180, 220, 255)
        b.BackgroundTransparency = 0.65
        b.Size                   = UDim2.fromOffset(sz, sz)
        b.Position               = UDim2.new(math.random() * 0.9 + 0.05, 0, 1, math.random(-10, 10))
        b.BorderSizePixel        = 0
        b.ZIndex                 = 4
        b.Parent                 = parent
        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(1, 0)
        cr.Parent       = b
        -- outline tipis biar keliatan
        local st = Instance.new("UIStroke")
        st.Color       = Color3.fromRGB(155, 214, 255)
        st.Thickness   = 1
        st.Transparency = 0.6
        st.Parent      = b

        local function float()
            if not b.Parent then return end
            local sx: number = math.random() * 0.8 + 0.1
            b.Position = UDim2.new(sx, 0, 1, 6)
            local ex: number = sx + (math.random() - 0.5) * 0.08
            local dur: number = math.random(5, 9)
            Performance.Tween(b, { Position = UDim2.new(ex, 0, 0, -6) }, dur, Enum.EasingStyle.Linear).Completed:Connect(function()
                if b.Parent then
                    task.wait(math.random() * 1.2)
                    float()
                end
            end)
        end
        task.delay(math.random() * 2.5, float)
    end
end

function Window.new(cfg: WindowConfig): any
    cfg = cfg or {}

    local title: string    = cfg.Name or cfg.Title or "Animula"
    local subTitle: string = cfg.SubTitle or "Hydro Archon  •  Fontaine"
    if cfg.Author then
        subTitle = subTitle .. "  •  " .. cfg.Author
    end

    local icon: string?            = cfg.Icon
    local themeName: string?       = cfg.Theme
    -- responsive: kalo gak di set manual, auto nyesuain device
    -- riset: html 640px di HP 375px = 170% layar, jadi di HP kita pake scale
    local winSize: UDim2           = cfg.Size or Responsive.GetWindowSize()
    local draggable: boolean       = if cfg.Draggable == nil then true else cfg.Draggable
    local toggleKey: Enum.KeyCode? = cfg.ToggleKey or Enum.KeyCode.RightShift

    if themeName and Theme.Variants[themeName] then
        Theme:SetVariant(themeName)
    end

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui: Instance = Utils.getHui()

    -- === ScreenGui ===
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name           = "AnimulaUI_" .. HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 8)
    screenGui.ResetOnSpawn   = false
    screenGui.IgnoreGuiInset = true
    -- riset: ScreenInsets biar gak ketutup notch / dynamic island di HP
    pcall(function()
        (screenGui :: any).ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        ;(screenGui :: any).ClipToDeviceSafeArea = true
    end)
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder   = 10
    screenGui.Parent         = hui
    -- UIScale biar proporsional di DPI beda (html rem vs roblox Offset)
    Responsive.AttachScale(screenGui)

    -- === Main Window ===
    local main = Instance.new("Frame")
    main.Name             = "MainWindow"
    main.BackgroundColor3 = T.Surface
    main.Size             = winSize
    main.Position         = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint      = Vector2.new(0.5, 0.5)
    main.ClipsDescendants = true -- biar wave gak keluar corner
    main.Parent           = screenGui
    Utils.Corner(main, R.Window)
    Utils.Stroke(main, T.Border, 1.5, 0.14)
    -- clamp biar gak kegedean / kekecilan di device aneh
    -- html gak ada ini, di html pake max-width / min-width
    Responsive.AttachConstraints(main)

    -- wave di belakang, transparan jadi cuma keliatan samar
    attachWave(main, T)

    -- shadow - gw bikin 2 lapis biar lebih deep
    do
        local shadow1 = Instance.new("Frame")
        shadow1.Name                   = "Shadow1"
        shadow1.BackgroundColor3       = T.Shadow
        shadow1.BackgroundTransparency = 0.82
        shadow1.Size                   = UDim2.new(1, 18, 1, 18)
        shadow1.Position               = UDim2.fromOffset(-9, -9)
        shadow1.ZIndex                 = 0
        shadow1.BorderSizePixel        = 0
        shadow1.Parent                 = main
        local c1 = Instance.new("UICorner")
        c1.CornerRadius = UDim.new(0, 20)
        c1.Parent       = shadow1
        -- shadow kedua lebih soft
        local shadow2 = Instance.new("Frame")
        shadow2.Name                   = "Shadow2"
        shadow2.BackgroundColor3       = T.Primary
        shadow2.BackgroundTransparency = 0.92
        shadow2.Size                   = UDim2.new(1, 30, 1, 30)
        shadow2.Position               = UDim2.fromOffset(-15, -15)
        shadow2.ZIndex                 = -1
        shadow2.BorderSizePixel        = 0
        shadow2.Parent                 = main
        local c2 = Instance.new("UICorner")
        c2.CornerRadius = UDim.new(0, 24)
        c2.Parent       = shadow2
        main.ZIndex = 3
    end

    -- accent bar di atas - gradient 3 warna + shimmer
    do
        local bar = Instance.new("Frame")
        bar.Name             = "AccentBar"
        bar.BackgroundColor3 = T.Primary
        bar.Size             = UDim2.new(1, 0, 0, 3)
        bar.BorderSizePixel  = 0
        bar.ZIndex           = 8
        bar.Parent           = main
        Utils.Corner(bar, UDim.new(0, 99))
        -- gradient 3 warna biar lebih hidup
        local g = Instance.new("UIGradient")
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   T.Primary),
            ColorSequenceKeypoint.new(0.5, T.Secondary),
            ColorSequenceKeypoint.new(1,   T.AccentGold),
        })
        g.Rotation = 0
        g.Parent   = bar
        local c: UICorner? = bar:FindFirstChildOfClass("UICorner") :: any
        if c then c.CornerRadius = UDim.new(0, 16) end

        -- shimmer jalan
        local shimmerGrad = Instance.new("UIGradient")
        shimmerGrad.Color = ColorSequence.new(Color3.new(1, 1, 1))
        shimmerGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.45, 0.5),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.55, 0.5),
            NumberSequenceKeypoint.new(1, 1),
        })
        shimmerGrad.Offset   = Vector2.new(-1, 0)
        shimmerGrad.Rotation = 10
        -- kita apply ke bar tapi pake overlay frame biar gak ngerusak gradient utama
        local shimmerFrame = Instance.new("Frame")
        shimmerFrame.BackgroundColor3       = Color3.new(1, 1, 1)
        shimmerFrame.BackgroundTransparency = 1
        shimmerFrame.Size                   = UDim2.fromScale(1, 1)
        shimmerFrame.BorderSizePixel        = 0
        shimmerFrame.ZIndex                 = 9
        shimmerFrame.Parent                 = bar
        local sc = Instance.new("UICorner")
        sc.CornerRadius = UDim.new(0, 99)
        sc.Parent       = shimmerFrame
        shimmerGrad.Parent = shimmerFrame
        task.spawn(function()
            while shimmerGrad.Parent do
                local tw = Performance.Tween(shimmerGrad, { Offset = Vector2.new(1, 0) }, 2.2, Enum.EasingStyle.Linear)
                tw.Completed:Wait()
                if not shimmerGrad.Parent then break end
                shimmerGrad.Offset = Vector2.new(-1, 0)
                task.wait(1.8)
            end
        end)
    end

    -- === TitleBar ===
    local titleBar = Instance.new("Frame")
    titleBar.Name                   = "TitleBar"
    titleBar.BackgroundTransparency = 1
    titleBar.Size                   = UDim2.new(1, 0, 0, 52)
    titleBar.Position               = UDim2.fromOffset(0, 3)
    titleBar.ZIndex                 = 6
    titleBar.Parent                 = main

    -- icon bulat - ada glow di belakangnya
    local iconWrap = Instance.new("Frame")
    iconWrap.Name             = "IconWrap"
    iconWrap.BackgroundColor3 = T.Primary
    iconWrap.Size             = UDim2.fromOffset(36, 36)
    iconWrap.Position         = UDim2.fromOffset(14, 8)
    iconWrap.ZIndex           = 7
    iconWrap.Parent           = titleBar
    Utils.Corner(iconWrap, UDim.new(1, 0))
    Utils.Gradient(iconWrap, T.Primary, T.Secondary, 35)

    -- glow di belakang icon
    do
        local glow = Instance.new("ImageLabel")
        glow.Name                   = "IconGlow"
        glow.BackgroundTransparency = 1
        glow.Image                  = "rbxassetid://5028857084"
        glow.ImageColor3            = T.Glow
        glow.ImageTransparency      = 0.55
        glow.ScaleType              = Enum.ScaleType.Slice
        glow.SliceCenter            = Rect.new(24, 24, 276, 276)
        glow.Size                   = UDim2.new(1, 18, 1, 18)
        glow.Position               = UDim2.fromOffset(-9, -9)
        glow.ZIndex                 = 6
        glow.Parent                 = iconWrap
        -- pulse pelan
        task.spawn(function()
            while glow.Parent do
                Performance.Tween(glow, { ImageTransparency = 0.75 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
                if not glow.Parent then break end
                Performance.Tween(glow, { ImageTransparency = 0.45 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
            end
        end)
    end

    -- ring tipis di icon biar premium
    do
        local ring = Instance.new("UIStroke")
        ring.Color       = T.AccentGold
        ring.Thickness   = 1.5
        ring.Transparency = 0.3
        ring.Parent      = iconWrap
    end

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name                   = "Icon"
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size                   = UDim2.fromScale(1, 1)
    iconLabel.FontFace               = F.Title
    iconLabel.TextSize               = 18
    iconLabel.TextColor3             = T.TextOnPrimary
    iconLabel.Text                   = "◈"
    iconLabel.ZIndex                 = 8
    iconLabel.Parent                 = iconWrap
    if icon and #icon <= 4 then
        iconLabel.Text = icon
    end

    -- title + subtitle
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name                   = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position               = UDim2.fromOffset(58, 6)
    titleLabel.Size                   = UDim2.new(1, -140, 0, 20)
    titleLabel.FontFace               = F.Title
    titleLabel.TextSize               = S.Title
    titleLabel.TextColor3             = T.Text
    titleLabel.TextXAlignment         = Enum.TextXAlignment.Left
    titleLabel.TextTruncate           = Enum.TextTruncate.AtEnd
    titleLabel.Text                   = title
    titleLabel.ZIndex                 = 7
    titleLabel.Parent                 = titleBar

    local subLabel = Instance.new("TextLabel")
    subLabel.Name                   = "SubTitle"
    subLabel.BackgroundTransparency = 1
    subLabel.Position               = UDim2.fromOffset(58, 26)
    subLabel.Size                   = UDim2.new(1, -140, 0, 14)
    subLabel.FontFace               = F.Body
    subLabel.TextSize               = S.Small
    subLabel.TextColor3             = T.TextDim
    subLabel.TextXAlignment         = Enum.TextXAlignment.Left
    subLabel.Text                   = subTitle
    subLabel.ZIndex                 = 7
    subLabel.Parent                 = titleBar

    -- === Window controls (min & close) ===
    local controls = Instance.new("Frame")
    controls.Name                   = "Controls"
    controls.BackgroundTransparency = 1
    controls.Size                   = UDim2.fromOffset(64, 32)
    controls.Position               = UDim2.new(1, -72, 0, 10)
    controls.ZIndex                 = 7
    controls.Parent                 = titleBar

    local ctrlLayout = Instance.new("UIListLayout")
    ctrlLayout.FillDirection       = Enum.FillDirection.Horizontal
    ctrlLayout.Padding             = UDim.new(0, 6)
    ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ctrlLayout.Parent              = controls

    local function makeCtrlBtn(text: string, hover: Color3, cb: () -> ()): TextButton
        local b = Instance.new("TextButton")
        b.Name             = text
        b.BackgroundColor3 = T.SurfaceLight
        b.Size             = UDim2.fromOffset(28, 28)
        b.FontFace         = F.Body
        b.TextSize         = 14
        b.TextColor3       = T.TextDim
        b.Text             = text
        b.AutoButtonColor  = false
        b.ZIndex           = 7
        b.Parent           = controls
        Utils.Corner(b, UDim.new(0, 8))
        Utils.Stroke(b, T.Border, 1, 0.6)
        -- hover glow dikit
        b.MouseEnter:Connect(function()
            Performance.Tween(b, { BackgroundColor3 = hover }, 0.15)
            Performance.Tween(b, { TextColor3 = Color3.new(1, 1, 1) }, 0.15)
        end)
        b.MouseLeave:Connect(function()
            Performance.Tween(b, { BackgroundColor3 = T.SurfaceLight }, 0.15)
            Performance.Tween(b, { TextColor3 = T.TextDim }, 0.15)
        end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    -- === Body: Sidebar + Content ===
    local body = Instance.new("Frame")
    body.Name                   = "Body"
    body.BackgroundTransparency = 1
    body.Position               = UDim2.fromOffset(0, 56)
    body.Size                   = UDim2.new(1, 0, 1, -56)
    body.ZIndex                 = 4
    body.Parent                 = main

    -- sidebar
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name                    = "Sidebar"
    sidebar.BackgroundColor3        = T.Background
    sidebar.BackgroundTransparency  = 0.22
    sidebar.Size                    = UDim2.new(0, 168, 1, -12)
    sidebar.Position                = UDim2.fromOffset(8, 6)
    sidebar.CanvasSize              = UDim2.fromOffset(0, 0)
    sidebar.ScrollBarThickness      = 2
    sidebar.ScrollBarImageColor3    = T.Primary
    sidebar.ScrollingDirection      = Enum.ScrollingDirection.Y
    sidebar.BorderSizePixel         = 0
    sidebar.ZIndex                  = 5
    sidebar.Parent                  = body
    Utils.Corner(sidebar, R.Large)
    Utils.Stroke(sidebar, T.Border, 1, 0.45)
    Utils.Padding(sidebar, 6, 8, 6, 8)

    local sideList = Instance.new("UIListLayout")
    sideList.FillDirection = Enum.FillDirection.Vertical
    sideList.Padding       = UDim.new(0, 4)
    sideList.SortOrder     = Enum.SortOrder.LayoutOrder
    sideList.Parent        = sidebar

    -- collapse sidebar di HP biar gak sempit
    local isPhone: boolean = Responsive.ShouldCollapseSidebar()
    local sidebarW: number = if isPhone then 0 else 168
    local contentX: number = if isPhone then 8 else 176
    local contentW: number = if isPhone then -16 else -184
    if isPhone then
        sidebar.Visible = false -- di HP hidden, nanti bisa di toggle hamburger
    end

    -- content wrapper - glass effect dikit
    local contentWrap = Instance.new("Frame")
    contentWrap.Name                     = "ContentWrap"
    contentWrap.BackgroundColor3         = T.SurfaceLight
    contentWrap.BackgroundTransparency   = 0.08
    contentWrap.Size                     = UDim2.new(1, contentW, 1, -12)
    contentWrap.Position                 = UDim2.new(0, contentX, 0, 6)
    contentWrap.ZIndex                   = 5
    contentWrap.Parent                   = body
    Utils.Corner(contentWrap, R.Large)
    -- border nya agak glowing
    do
        local st = Utils.Stroke(contentWrap, T.Border, 1, 0.38)
        -- inner highlight atas (kayak glass reflection)
        local hl = Instance.new("Frame")
        hl.Name                   = "Highlight"
        hl.BackgroundColor3       = Color3.new(1, 1, 1)
        hl.BackgroundTransparency = 0.94
        hl.Size                   = UDim2.new(1, -2, 0, 1)
        hl.Position               = UDim2.fromOffset(1, 1)
        hl.BorderSizePixel        = 0
        hl.ZIndex                 = 6
        hl.Parent                 = contentWrap
    end

    -- particle bubble di contentWrap biar hidup
    -- jangan lupa clipping biar gak keluar
    contentWrap.ClipsDescendants = true
    spawnBubbles(contentWrap)

    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Name                     = "Content"
    contentScroll.BackgroundTransparency   = 1
    contentScroll.Size                     = UDim2.fromScale(1, 1)
    contentScroll.CanvasSize               = UDim2.fromOffset(0, 0)
    contentScroll.ScrollBarThickness       = 3
    contentScroll.ScrollBarImageColor3     = T.Primary
    contentScroll.ScrollBarImageTransparency = 0.3
    contentScroll.BorderSizePixel          = 0
    contentScroll.ZIndex                   = 6
    contentScroll.Parent                   = contentWrap
    Utils.Padding(contentScroll, 14, 14, 14, 14)

    local contentList = Instance.new("UIListLayout")
    contentList.FillDirection = Enum.FillDirection.Vertical
    contentList.Padding       = UDim.new(0, 10)
    contentList.SortOrder     = Enum.SortOrder.LayoutOrder
    contentList.Parent        = contentScroll

    -- anti-lag: debounced canvas
    local pool: any = Performance.NewPool()
    pool:Add(Performance.AutoCanvas(sidebar, sideList, 24))
    pool:Add(Performance.AutoCanvas(contentScroll, contentList, 24))

    -- === Window object ===
    local self: any = setmetatable({}, Window)
    self._gui       = screenGui
    self._main      = main
    self._sidebar   = sidebar
    self._content   = contentScroll
    self._titleLbl  = titleLabel
    self._subLbl    = subLabel
    self._wrap      = contentWrap
    self._body      = body
    self._pool      = pool
    self._tabs      = {}
    self._activeTab = nil
    self._visible   = true
    self._winSize   = winSize
    self._closeCb   = cfg.CloseCallback
    self._T         = T
    self._R         = R
    self._F         = F
    self._S         = S

    if cfg.SaveConfig and cfg.ConfigFolder then
        self._configFolder = cfg.ConfigFolder
        Config:LoadFromFile(cfg.ConfigFolder, "config")
    end

    -- controls
    local minimized: boolean = false
    makeCtrlBtn("—", T.SurfaceHover, function()
        minimized = not minimized
        if minimized then
            Performance.Tween(body, { Size = UDim2.new(1, 0, 0, 0) }, 0.22)
            Performance.Tween(main, { Size = UDim2.fromOffset(winSize.X.Offset, 56) }, 0.22)
        else
            Performance.Tween(body, { Size = UDim2.new(1, 0, 1, -56) }, 0.22)
            Performance.Tween(main, { Size = winSize }, 0.22)
        end
    end)
    makeCtrlBtn("✕", Color3.fromRGB(220, 60, 60), function()
        self:Destroy()
        if self._closeCb then task.spawn(self._closeCb) end
    end)

    if draggable then
        Utils.MakeDraggable(titleBar, main)
    end

    if toggleKey then
        local conn: RBXScriptConnection =
            UserInputService.InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == toggleKey then self:Toggle() end
            end)
        pool:Add(conn)
    end

    -- entrance - scale + fade, biar pop
    main.Size                   = UDim2.fromOffset(winSize.X.Offset - 28, winSize.Y.Offset - 28)
    main.BackgroundTransparency = 0.2
    -- scale dikit dulu terus balik
    Performance.Tween(main, { Size = winSize }, 0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Performance.Tween(main, { BackgroundTransparency = 0 }, 0.24)

    return self
end

function Window:SetTitle(newTitle: string, newSub: string?)
    (self._titleLbl :: TextLabel).Text = newTitle
    if newSub then
        (self._subLbl :: TextLabel).Text = newSub
    end
end

function Window:SetTheme(name: string)
    if not Theme.Variants[name] then return end
    Theme:SetVariant(name)
    local T = Theme.Current
    self._T = T
    ;(self._main :: Frame).BackgroundColor3                 = T.Surface
    ;(self._sidebar :: ScrollingFrame).BackgroundColor3     = T.Background
    ;(self._wrap :: Frame).BackgroundColor3                 = T.SurfaceLight
    ;(self._titleLbl :: TextLabel).TextColor3               = T.Text
    ;(self._subLbl :: TextLabel).TextColor3                 = T.TextDim
    ;(self._content :: ScrollingFrame).ScrollBarImageColor3 = T.Primary
    ;(self._sidebar :: ScrollingFrame).ScrollBarImageColor3 = T.Primary
end

function Window:Toggle(state: boolean?)
    local show: boolean = if state == nil then not self._visible else (state :: boolean)
    self._visible = show
    if show then
        (self._gui :: ScreenGui).Enabled = true
        ;(self._main :: Frame).Visible   = true
        Performance.Tween(self._main, { BackgroundTransparency = 0 }, 0.2)
        ;(self._main :: Frame).Size = UDim2.fromOffset(
            (self._winSize :: UDim2).X.Offset - 16,
            (self._winSize :: UDim2).Y.Offset - 16
        )
        Performance.Tween(self._main, { Size = self._winSize }, 0.3, Enum.EasingStyle.Back)
    else
        Performance.Tween(self._main, { BackgroundTransparency = 1 }, 0.18)
        task.delay(0.18, function()
            if not self._visible then
                (self._main :: Frame).Visible = false
            end
        end)
    end
end

function Window:Destroy()
    if self._pool then (self._pool :: any):Clear() end
    (self._gui :: ScreenGui):Destroy()
end

function Window:Notify(cfg: any)
    local N: any = require(script.Parent.Parent.Notification.Notification)
    return N.Notify(cfg)
end
function Window:MakeNotification(cfg: any) return self:Notify(cfg) end
function Window:Dialog(cfg: any)
    local N: any = require(script.Parent.Parent.Notification.Notification)
    return N.Dialog(cfg, self._main)
end
function Window:Popup(cfg: any)
    local N: any = require(script.Parent.Parent.Notification.Notification)
    return N.Popup(cfg)
end

return Window
