-- SCRIPT DE FREEZE POSE (LocalScript)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()

-- 1. Criar a Tool (Ferramenta)
local tool = Instance.new("Tool")
tool.Name = "Congelar Postura"
tool.RequiresHandle = false -- Não precisa de um modelo de peça na mão
tool.Parent = player.Backpack

local congelado = false
local pecasAncoradas = {}

-- 2. Função para Congelar/Descongelar
tool.Activated:Connect(function()
    congelado = not congelado -- Inverte o estado (liga/desliga)
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    if congelado then
        print("Personagem Congelado!")
        -- Ancorar todas as partes do corpo para ele ficar na pose exata
        for _, parte in pairs(character:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.Anchored = true
                table.insert(pecasAncoradas, parte)
            end
        end
    else
        print("Personagem Descongelado!")
        -- Desancorar tudo para voltar a andar
        for _, parte in pairs(pecasAncoradas) do
            if parte and parte.Parent then
                parte.Anchored = false
            end
        end
        pecasAncoradas = {} -- Limpa a lista
    end
end)

-- 3. Garantir que o script funcione se você morrer e renascer
player.CharacterAdded:Connect(function(novoCharacter)
    character = novoCharacter
    tool.Parent = player.Backpack
end)