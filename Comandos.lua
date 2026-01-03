local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local RunService = game:GetService("RunService")

-- CONFIGURAÇÕES DE ESTADO
local noclip = false
local flying = false
local flySpeed = 50

-- 1. GUI DE COMANDOS AMPLIADA (SCROLLABLE)
local function criarGuiComandos()
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "VigilanteAdmin_V3"
    
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 250, 0, 220)
    frame.Position = UDim2.new(0, 10, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame)
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "ADMIN HUB (20 COMANDOS)"
    title.TextColor3 = Color3.new(0, 1, 0.6)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
    scroll.ScrollBarThickness = 4

    local lista = Instance.new("TextLabel", scroll)
    lista.Size = UDim2.new(1, 0, 1, 0)
    lista.BackgroundTransparency = 1
    lista.TextColor3 = Color3.new(1, 1, 1)
    lista.Font = Enum.Font.Code
    lista.TextSize = 11
    lista.TextYAlignment = Enum.TextYAlignment.Top
    lista.Text = [[
/bomb - Explodir
/tp [nome] - Teleport
/tool - Bloco Tool
/speed [n] - Velocidade
/jump [n] - Pulo
/noclip - Atravessar
/clip - Colidir
/re - Resetar
/fps - Ver FPS
/fly - Voar
/unfly - Parar voo
/infjump - Pulo Infinito
/invisible - Invisivel
/visible - Visivel
/view [nome] - Espiar
/unview - Voltar camera
/goto [nome] - Ir até
/sit - Sentar
/lowres - Grafico Batata
/ping - Ver Latencia
]]
end

-- 2. LÓGICA DE VOO (FLY)
local function toggleFly(state)
    flying = state
    local char = lp.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if flying then
        local bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        
        local bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                RunService.RenderStepped:Wait()
                bv.velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                bg.cframe = workspace.CurrentCamera.CFrame
            end
            bg:Destroy()
            bv:Destroy()
        end)
    end
end

-- 3. PROCESSADOR DE CHAT (TODOS OS 20 COMANDOS)
lp.Chatted:Connect(function(msg)
    local args = string.split(msg, " ")
    local cmd = args[1]:lower()

    if cmd == "/bomb" then Instance.new("Explosion", workspace).Position = lp.Character.Head.Position
    elseif cmd == "/tp" or cmd == "/goto" then
        local t = args[2]
        for _, p in pairs(Players:GetPlayers()) do
            if string.find(p.Name:lower(), t:lower()) then lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end
        end
    elseif cmd == "/speed" then lp.Character.Humanoid.WalkSpeed = tonumber(args[2]) or 16
    elseif cmd == "/jump" then lp.Character.Humanoid.JumpPower = tonumber(args[2]) or 50
    elseif cmd == "/re" then lp.Character:BreakJoints()
    elseif cmd == "/noclip" then noclip = true 
        RunService.Stepped:Connect(function() if noclip then for _,v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)
    elseif cmd == "/clip" then noclip = false
    elseif cmd == "/fly" then toggleFly(true)
    elseif cmd == "/unfly" then toggleFly(false)
    elseif cmd == "/invisible" then for _,v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end end
    elseif cmd == "/visible" then for _,v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 0 end end
    elseif cmd == "/view" then
        local t = args[2]
        for _, p in pairs(Players:GetPlayers()) do
            if string.find(p.Name:lower(), t:lower()) then workspace.CurrentCamera.CameraSubject = p.Character.Humanoid end
        end
    elseif cmd == "/unview" then workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
    elseif cmd == "/sit" then lp.Character.Humanoid.Sit = true
    elseif cmd == "/fps" then print("FPS: " .. math.floor(1/RunService.RenderStepped:Wait()))
    elseif cmd == "/ping" then print("Ping Estimado: " .. lp:GetNetworkPing()*1000 .. "ms")
    elseif cmd == "/lowres" then for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end end
    elseif cmd == "/infjump" then game:GetService("UserInputService").JumpRequest:Connect(function() lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
end)

criarGuiComandos()