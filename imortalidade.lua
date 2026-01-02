-- PAINEL VIGILANTE HUB: MODO IMORTAL V3 (CORRIGIDO)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- 1. INTERFACE (MANTIDA IGUAL PARA MOBILE)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelImortalFixo"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -60)
MainFrame.Size = UDim2.new(0, 200, 0, 130)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 0, 0) -- Vermelho enquanto desligado
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "IMORTALIDADE V3"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local ToggleBG = Instance.new("TextButton")
ToggleBG.Parent = MainFrame
ToggleBG.Position = UDim2.new(0.5, -40, 0.5, -10)
ToggleBG.Size = UDim2.new(0, 80, 0, 35)
ToggleBG.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ToggleBG.Text = ""

local Circle = Instance.new("Frame")
Circle.Parent = ToggleBG
Circle.Position = UDim2.new(0, 5, 0.5, -12)
Circle.Size = UDim2.new(0, 25, 0, 25)
Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
Instance.new("UICorner", ToggleBG).CornerRadius = UDim.new(1, 0)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "STATUS: OFF"
StatusLabel.TextColor3 = Color3.new(1,1,1)
StatusLabel.Font = Enum.Font.Gotham

-- 2. LÓGICA DE IMORTALIDADE CORRIGIDA
local imortalAtivo = false

ToggleBG.MouseButton1Click:Connect(function()
    imortalAtivo = not imortalAtivo
    if imortalAtivo then
        Circle:TweenPosition(UDim2.new(1, -30, 0.5, -12), "Out", "Quad", 0.2)
        ToggleBG.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        UIStroke.Color = Color3.fromRGB(0, 255, 150)
        StatusLabel.Text = "STATUS: ON"
    else
        Circle:TweenPosition(UDim2.new(0, 5, 0.5, -12), "Out", "Quad", 0.2)
        ToggleBG.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        UIStroke.Color = Color3.fromRGB(255, 0, 0)
        StatusLabel.Text = "STATUS: OFF"
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.MaxHealth = 100
        end
    end
end)

-- O SEGREDO: Hook no HealthChanged e State
RunService.Stepped:Connect(function()
    if imortalAtivo then
        local char = lp.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                -- Se a vida cair de 100, voltamos ela instantaneamente
                if hum.Health < 100 and hum.Health > 0 then
                    hum.Health = 100
                end
                
                -- CORREÇÃO DO ERRO DO CONSOLE:
                -- Se o estado for 'Dead', mudamos para 'Physics' (correto)
                if hum:GetState() == Enum.HumanoidStateType.Dead then
                    hum:ChangeState(Enum.HumanoidStateType.Physics)
                    hum.Health = 100
                end
            end
        end
    end
end)

-- Impede que a lava "quebre" seu corpo
lp.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.BreakJointsOnDeath = not imortalAtivo
end)