--!strict
-- responsive.lua - biar animula ui cakep di semua device
-- riset: roblox vs html beda jauh soal ukuran
-- html pake px/rem/vw, roblox pake UDim2 (Scale + Offset) + TextSize pixel
-- jadi gw bikin helper biar window auto nyesuain viewport

--[[

  CATATAN RISET - baca dulu sebelum edit!

  1. Roblox TextSize vs HTML font-size
     - Roblox TextSize = pixel absolut, kayak html px tapi gak scale sama viewport
     - html 16px = TextSize 16 di roblox, 1:1 di 1x DPI
     - tapi di layar 4K, 16px roblox keliatan kecil (0.4% width) vs 1080p (0.8%)
     - solusi: jangan pake TextScaled=true buat UI util (bikin lag, re-render tiap frame)
       pake TextSize fixed + UITextSizeConstraint kalo mau responsif
     - di animula kita pake: Title 18, Heading 14, Body 13, Small 11, Tiny 10
       ini udah pas, jangan di bawah 9 (gak kebaca)

  2. Roblox Size vs HTML size
     - html: width: 640px  atau  50%  atau  50vw
     - roblox: UDim2.new(ScaleX, OffsetX, ScaleY, OffsetY)
       AbsoluteSize.X = Parent.AbsoluteSize.X * Scale + Offset
     - Offset doang (fromOffset 640,430) = pixel perfect di 1080p tapi pecah di HP
       640px di iPhone SE (375px logic) = 170% layar wkwk full penuh
     - Scale doang (fromScale 0.6,0.7) = responsif tapi di ultrawide jadi kegedean
     - Hybrid + UIScale + UISizeConstraint = paling aman (kita pake ini)

  3. Ukuran window ideal (riset dari orion/fluent/rayfield)
     - Orion/Fluent: 550-600 x 380-450
     - Rayfield: 500 x 400
     - Animula awal 640x430 kegedean dikit buat HP, jadi kita ganti 600x400
       + clamp Min 480x320 Max 700x500 biar gak pecah
     - di HP < 600px, sidebar 168px + content 1,-184 = content cuma 207px sisa, sempit
       jadi di HP kita collapse sidebar jadi drawer (tombol hamburger)

  4. HTML vs Roblox unit
     - html px         -> roblox Offset + TextSize (1:1 di 1x DPI)
     - html %          -> roblox Scale (0.5 = 50%)
     - html vw/vh      -> roblox Scale di ScreenGui (1 = 100vw)
     - html rem        -> gak ada di roblox, simulasi pake UIScale = vp.X / 1920
     - html border-radius 8px -> roblox UICorner UDim.new(0,8), pill = UDim.new(1,0)

  5. TweenService - jangan spam!
     - tiap Tween = objek GC, spam 20 tween/detik = lag
     - durasi hover 0.18-0.25s, entrance 0.3-0.35s Back Out, jangan >0.5s kelamaan
     - selalu cancel tween lama sebelum bikin baru (kita udah ada Performance.Tween pooling)
     - jangan tween UIStroke.Thickness di text (bikin regenerate glyph)

--]]

local Theme = require(script.Parent.Parent.Theme.AnimulaTheme)

local Responsive = {}

-- deteksi device berdasarkan viewport
export type Device = "Phone" | "Tablet" | "Desktop"

function Responsive.GetDevice(viewport: Vector2?): Device
    local vp: Vector2 = viewport or workspace.CurrentCamera.ViewportSize
    if vp.X < 600 then
        return "Phone"
    elseif vp.X < 1024 then
        return "Tablet"
    else
        return "Desktop"
    end
end

-- kasih tau ukuran window yg ideal buat device itu
function Responsive.GetWindowSize(device: Device?): UDim2
    local d: Device = device or Responsive.GetDevice()
    if d == "Phone" then
        -- di HP pake scale biar gak kepotong
        return UDim2.fromScale(0.92, 0.84)
    elseif d == "Tablet" then
        return UDim2.fromScale(0.76, 0.72)
    else
        return UDim2.fromOffset(600, 400) -- desktop sweet spot
    end
end

-- pasang UISizeConstraint biar window gak kegedean / kekecilan
function Responsive.AttachConstraints(frame: GuiObject)
    -- hapus yg lama kalo ada (biar gak dobel)
    for _, ch: Instance in ipairs(frame:GetChildren()) do
        if ch:IsA("UISizeConstraint") and ch.Name == "Animula_Constraint" then
            ch:Destroy()
        end
        if ch:IsA("UIAspectRatioConstraint") and ch.Name == "Animula_Aspect" then
            ch:Destroy()
        end
    end

    local sc = Instance.new("UISizeConstraint")
    sc.Name    = "Animula_Constraint"
    sc.MinSize = Vector2.new(480, 320) -- HP tetep usable
    sc.MaxSize = Vector2.new(700, 500) -- PC jangan 1000+ ntar aneh
    sc.Parent  = frame

    -- aspect ratio biar proporsional, optional tapi cakep
    local ar = Instance.new("UIAspectRatioConstraint")
    ar.Name         = "Animula_Aspect"
    ar.AspectRatio  = 1.50 -- 600/400
    ar.DominantAxis = Enum.DominantAxis.Width
    ar.AspectType   = Enum.AspectType.FitWithinMaxSize
    ar.Parent       = frame

    return sc, ar
end

-- UIScale biar text tetep proporsional di DPI beda
-- html rem = root font, di roblox kita fake pake ini
function Responsive.AttachScale(gui: ScreenGui | Frame): UIScale
    local scale = Instance.new("UIScale")
    scale.Name   = "Animula_Scale"
    scale.Parent = gui

    local cam: Camera? = workspace.CurrentCamera
    local function update()
        local vp: Vector2 = cam and cam.ViewportSize or Vector2.new(1920, 1080)
        -- 1920 = baseline desktop, clamp 0.65 - 1.0
        local s: number = math.clamp(vp.X / 1920, 0.65, 1.0)
        -- di HP jangan terlalu kecil, minimal 0.78 biar text kebaca
        if vp.X < 600 then
            s = math.clamp(vp.X / 375 * 0.88, 0.78, 0.92)
        end
        scale.Scale = s
    end

    update()
    if cam then
        cam:GetPropertyChangedSignal("ViewportSize"):Connect(update)
    end

    return scale
end

-- collapse sidebar kalo di HP (biar content gak sempit)
function Responsive.ShouldCollapseSidebar(viewport: Vector2?): boolean
    local vp: Vector2 = viewport or workspace.CurrentCamera.ViewportSize
    return vp.X < 600
end

-- text size token - kayak css variables
-- biar konsisten, jangan hardcode angka random
function Responsive.TextSize(token: string): number
    -- token: "title" | "heading" | "body" | "small" | "tiny"
    local map: { [string]: number } = {
        title   = Theme.TextSize.Title,   -- 18
        heading = Theme.TextSize.Heading, -- 14
        body    = Theme.TextSize.Body,    -- 13
        small   = Theme.TextSize.Small,   -- 11
        tiny    = Theme.TextSize.Tiny,    -- 10
    }
    return map[string.lower(token)] or Theme.TextSize.Body
end

-- helper buat bikin label yg auto-resize (kayak html word-wrap)
function Responsive.MakeAutoLabel(
    parent: Instance,
    text: string,
    token: string?,
    color: Color3?
): TextLabel
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size                   = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize          = Enum.AutomaticSize.Y
    lbl.FontFace               = Theme.Font.Body
    lbl.TextSize               = Responsive.TextSize(token or "body")
    lbl.TextColor3             = color or Theme.Current.Text
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.TextWrapped            = true
    lbl.Text                   = text
    lbl.Parent                 = parent
    return lbl
end

return Responsive
