local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function tornarGiganteUniversal()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    local multiplicador = 10

    -- 1. TENTA O MÉTODO R15 (ESCALAS AUTOMÁTICAS)
    local escalasR15 = {"BodyDepthScale", "BodyHeightScale", "BodyWidthScale", "HeadScale"}
    local ehR15 = false

    for _, nome in pairs(escalasR15) do
        local valor = hum:FindFirstChild(nome)
        if valor then
            valor.Value = multiplicador
            ehR15 = true
        end
    end

    -- 2. SE FOR R6 OU AS ESCALAS NÃO FUNCIONAREM, REDIMENSIONA MANUALMENTE
    if not ehR15 then
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Size = obj.Size * multiplicador
            elseif obj:IsA("Motor6D") or obj:IsA("Weld") then
                -- Ajusta a posição das juntas (Joints) para não desmontar o R6
                obj.C0 = CFrame.new(obj.C0.Position * multiplicador) * (obj.C0 - obj.C0.Position)
                obj.C1 = CFrame.new(obj.C1.Position * multiplicador) * (obj.C1 - obj.C1.Position)
            end
        end
    end

    -- 3. AJUSTES FÍSICOS GLOBAIS
    -- Ajusta a altura do quadril para não ficar preso no chão
    if ehR15 then
        hum.HipHeight = hum.HipHeight * multiplicador
    else
        hum.HipHeight = 1.35 * multiplicador
    end

    -- Teleporta levemente para cima para evitar bugar no mapa ao crescer
    root.CFrame = root.CFrame + Vector3.new(0, 50, 0)
end

-- 4. GUI DE AVISO (MOBILE FRIENDLY)
local function criarAviso()
    local sg = Instance.new("ScreenGui", lp.PlayerGui)
    sg.Name = "AvisoGiganteUniversal"
    sg.ResetOnSpawn = false

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 260, 0, 90)
    frame.Position = UDim2.new(0.5, -130, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(255, 200, 0)

    local txt = Instance.new("TextLabel", frame)
    txt.Size = UDim2.new(1, -20, 1, -20)
    txt.Position = UDim2.new(0, 10, 0, 10)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1, 1, 1)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 14
    txt.Text = "SISTEMA GIGANTE ATIVO!\nFunciona em R6 e R15.\nResete para voltar ao normal."

    task.delay(10, function() sg:Destroy() end)
end

-- EXECUÇÃO
tornarGiganteUniversal()
criarAviso()