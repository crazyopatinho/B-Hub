-- PAINEL ESP VIGILANTE V2 (ROXO NEON + ANIMAÇÕES + MOBILE)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

-- 1. ESTRUTURA DA INTERFACE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VigilanteESP_V2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Label Superior (Barra de Controle)
local Header = Instance.new("Frame")
Header.Parent = ScreenGui
Header.Size = UDim2.new(0, 220, 0, 40)
Header.Position = UDim2.new(1, -230, 0.5, -150)
Header.BackgroundColor3 = Color3.fromRGB(40, 15, 60)
Header.Active = true
Header.Draggable = true -- Permite mover tudo pela barra

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ESP TRACKER"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botões da Barra
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = Header
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.Text = "+"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

-- Frame Principal (Abaixo da Header)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = Header
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 40)
MainFrame.Position = UDim2.new(0, 0, 1, 5)
MainFrame.Size = UDim2.new(1, 0, 0, 260)
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Lista Rolável
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Size = UDim2.new(1, -20, 0, 190)
Scroll.Position = UDim2.new(0, 10, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0, 5)

-- Toggle ESP
local ToggleBG = Instance.new("TextButton")
ToggleBG.Parent = MainFrame
ToggleBG.Position = UDim2.new(0.5, -50, 1, -45)
ToggleBG.Size = UDim2.new(0, 100, 0, 35)
ToggleBG.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ToggleBG.Text = "ESP: OFF"
ToggleBG.TextColor3 = Color3.new(1, 1, 1)
ToggleBG.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBG).CornerRadius = UDim.new(0, 8)

-- 2. ANIMAÇÕES E LÓGICA
local minimizado = false
local originalSize = MainFrame.Size

MinimizeBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    local goal = {}
    if minimizado then
        goal.Size = UDim2.new(1, 0, 0, 0)
        MinimizeBtn.Text = "-"
    else
        goal.Size = originalSize
        MinimizeBtn.Text = "+"
    end
    
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), goal)
    tween:Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Deleta tudo
end)

-- 3. LÓGICA DO ESP (MANTIDA E OTIMIZADA)
local selecionado = nil
local espAtivo = false

function atualizarLista()
    for _, child in pairs(Scroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp then
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 35)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(60, 40, 80)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Font = Enum.Font.Gotham
            b.Parent = Scroll
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
            
            b.MouseButton1Click:Connect(function()
                for _, btn in pairs(Scroll:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(60, 40, 80) end end
                b.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
                selecionado = p
            end)
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end

function gerenciarESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("HighlightESP") if h then h:Destroy() end
            local n = p.Character:FindFirstChild("BillboardESP") if n then n:Destroy() end
        end
    end
    if espAtivo and selecionado and selecionado.Character then
        local h = Instance.new("Highlight")
        h.Name = "HighlightESP"
        h.Parent = selecionado.Character
        h.FillColor = Color3.fromRGB(180, 0, 255)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        
        local b = Instance.new("BillboardGui")
        b.Name = "BillboardESP"
        b.Parent = selecionado.Character
        b.Adornee = selecionado.Character:FindFirstChild("Head")
        b.Size = UDim2.new(0, 100, 0, 50)
        b.AlwaysOnTop = true
        b.StudsOffset = Vector3.new(0, 3, 0)
        
        local l = Instance.new("TextLabel")
        l.Parent = b
        l.Size = UDim2.new(1, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = selecionado.Name
        l.TextColor3 = Color3.fromRGB(200, 100, 255)
        l.Font = Enum.Font.GothamBold
        l.TextSize = 14
    end
end

ToggleBG.MouseButton1Click:Connect(function()
    if not selecionado then return end
    espAtivo = not espAtivo
    ToggleBG.Text = espAtivo and "ESP: ON" or "ESP: OFF"
    ToggleBG.BackgroundColor3 = espAtivo and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(45, 45, 50)
    gerenciarESP()
end)

atualizarLista()
Players.PlayerAdded:Connect(atualizarLista)
Players.PlayerRemoving:Connect(atualizarLista)