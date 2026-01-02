-- PAINEL YELLOW CHASER (TWEEN PERSEGUIÇÃO RÁPIDA)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- 1. INTERFACE (AMARELA E PRETA)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YellowChaser_V2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Header = Instance.new("Frame")
Header.Size = UDim2.new(0, 200, 0, 35)
Header.Position = UDim2.new(1, -210, 0.5, -50)
Header.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Amarelo Ouro
Header.Active = true
Header.Draggable = true
Header.Parent = ScreenGui

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 10)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 0, 80)
MainFrame.Position = UDim2.new(0, 0, 1, 5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Parent = Header
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local ToggleBG = Instance.new("TextButton")
ToggleBG.Size = UDim2.new(0, 170, 0, 45)
ToggleBG.Position = UDim2.new(0.5, -85, 0.5, -22)
ToggleBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBG.Text = "CHASE: OFF"
ToggleBG.TextColor3 = Color3.new(1, 1, 1)
ToggleBG.Font = Enum.Font.GothamBold
ToggleBG.Parent = MainFrame
Instance.new("UICorner", ToggleBG).CornerRadius = UDim.new(0, 10)

-- 2. LÓGICA DE PERSEGUIÇÃO RÁPIDA
local chasing = false
local chaseTime = 10 -- Tempo em segundos seguindo cada jogador
local speedFactor = 100 -- Fator de velocidade do Tween (maior = mais rápido)

CloseBtn.MouseButton1Click:Connect(function()
    chasing = false
    ScreenGui:Destroy()
end)

ToggleBG.MouseButton1Click:Connect(function()
    chasing = not chasing
    ToggleBG.Text = chasing and "CHASE: ON" or "CHASE: OFF"
    ToggleBG.BackgroundColor3 = chasing and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(45, 45, 45)
    ToggleBG.TextColor3 = chasing and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
end)

-- Loop principal
task.spawn(function()
    while true do
        if chasing then
            local playersList = Players:GetPlayers()
            for _, target in pairs(playersList) do
                if not chasing then break end
                
                if target ~= lp and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local startTime = tick()
                    
                    -- Segue o jogador atual por 'chaseTime' segundos
                    while chasing and (tick() - startTime) < chaseTime do
                        local char = lp.Character
                        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                        
                        if char and targetRoot then
                            local lpRoot = char:FindFirstChild("HumanoidRootPart")
                            if lpRoot then
                                -- Calcula distância e cria Tween rápido para a posição atualizada do alvo
                                local dist = (lpRoot.Position - targetRoot.Position).Magnitude
                                local tInfo = TweenInfo.new(dist/speedFactor, Enum.EasingStyle.Linear)
                                
                                -- Noclip ativo durante o movimento
                                for _, part in pairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then part.CanCollide = false end
                                end
                                
                                local tween = TweenService:Create(lpRoot, tInfo, {CFrame = targetRoot.CFrame})
                                tween:Play()
                                task.wait(0.1) -- Atualização rápida da trajetória
                            end
                        else
                            break -- Se o alvo sumir ou morrer, pula para o próximo
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)