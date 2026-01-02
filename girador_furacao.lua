-- SCRIPT DE FURACÃO (Spin Tool)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- 1. Criar a Tool
local tool = Instance.new("Tool")
tool.Name = "Modo Furacão"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local girando = false
local velocidadeGiro = 50 -- Aumente para girar mais rápido!

-- 2. Criar a Força de Giro (AngularVelocity)
-- Usamos BodyAngularVelocity porque funciona bem em jogos antigos e novos
local bAV = Instance.new("BodyAngularVelocity")
bAV.MaxTorque = Vector3.new(0, math.huge, 0) -- Força infinita no eixo Y (vertical)
bAV.AngularVelocity = Vector3.new(0, 0, 0)
bAV.Parent = rootPart

-- 3. Lógica de Ativação
tool.Activated:Connect(function()
    girando = not girando
    
    if girando then
        print("Furacão Ativado!")
        bAV.AngularVelocity = Vector3.new(0, velocidadeGiro, 0)
        
        -- Efeito Opcional: Faz o personagem flutuar um pouco
        rootPart.Velocity = Vector3.new(0, 50, 0)
    else
        print("Furacão Desativado!")
        bAV.AngularVelocity = Vector3.new(0, 0, 0)
    end
end)

-- 4. Manter o script ativo após morrer
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart")
    bAV.Parent = rootPart
    girando = false
    bAV.AngularVelocity = Vector3.new(0, 0, 0)
end)