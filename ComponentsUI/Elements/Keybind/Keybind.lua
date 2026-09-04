--!strict
-- Keybind/Keybind.lua - AddBind buat animula ui
-- dipanggil dari TabManager: Tab:AddBind(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddBind(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Bind"
        local def: Enum.KeyCode = cfg.Default or cfg.Value or Enum.KeyCode.F
        -- Orion's Default bisa string; handle
        if typeof(def) == "string" then
            local ok, kc = pcall(function()
                return Enum.KeyCode[def :: string]
            end)
            if ok and kc then def = kc end
        end
        local hold: boolean = cfg.Hold or false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Enum.KeyCode) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local f = card(42)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -90, 1, 0)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local keyBtn = Instance.new("TextButton")
        keyBtn.BackgroundColor3 = T.Background
        keyBtn.Size     = UDim2.fromOffset(80, 26)
        keyBtn.Position = UDim2.new(1, -80, 0.5, -13)
        keyBtn.FontFace = F.Body
        keyBtn.TextSize = S.Small
        keyBtn.TextColor3 = T.Text
        keyBtn.Text     = (def :: Enum.KeyCode).Name
        keyBtn.AutoButtonColor = false
        keyBtn.Parent   = f
        Utils.Corner(keyBtn, R.Small)
        Utils.Stroke(keyBtn, T.Border, 1, 0.4)

        local current: Enum.KeyCode = def :: Enum.KeyCode
        local listening = false
        local obj: any = { Value = current, Save = save }

        local function set(k: Enum.KeyCode)
            current   = k
            obj.Value = k
            keyBtn.Text = k.Name
            if flag then Config:SetFlag(flag, k) end
            if cb then task.spawn(cb, k) end
        end

        -- Hold mode
        if hold and cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, true) end
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(input: InputObject)
                if input.KeyCode == current then task.spawn(cb, false) end
            end)
        elseif cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, current) end
            end)
        end

        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            keyBtn.Text      = "..."
            keyBtn.TextColor3 = T.Primary
            local conn: RBXScriptConnection
            conn = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    conn:Disconnect()
                    listening = false
                    keyBtn.TextColor3 = T.Text
                    set(input.KeyCode)
                end
            end)
            task.delay(5, function()
                if listening then
                    listening = false
                    if conn.Connected then conn:Disconnect() end
                    keyBtn.Text      = current.Name
                    keyBtn.TextColor3 = T.Text
                end
            end)
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(k: Enum.KeyCode) set(k) end
        function obj:Get() return current end

        return obj
    end
    Tab.Bind        = Tab.AddBind
    Tab.Keybind     = Tab.AddBind
    Tab.AddKeybind  = Tab.AddBind
end

-- =============================================================================
--  Attach tabs ke Window
-- =============================================================================
end

return Element
