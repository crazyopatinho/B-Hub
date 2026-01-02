-- SISTEMA DE INSPEÇÃO DE PERFIL (V3 - FINAL)
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- 1. INTERFACE PRINCIPAL (LADO DIREITO)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VigilanteProfile_V3"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Barra Superior da Lista
local ListHeader = Instance.new("Frame")
ListHeader.Size = UDim2.new(0, 200, 0, 35)
ListHeader.Position = UDim2.new(1, -210, 0.5, -150)
ListHeader.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
ListHeader.Active = true
ListHeader.Draggable = true
ListHeader.Parent = ScreenGui

local ListHeaderCorner = Instance.new("UICorner", ListHeader)
ListHeaderCorner.CornerRadius = UDim.new(0, 10)

-- Botão "X" para fechar TUDO
local CloseAllBtn = Instance.new("TextButton")
CloseAllBtn.Size = UDim2.new(0, 25, 0, 25)
CloseAllBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseAllBtn.Text = "X"
CloseAllBtn.TextColor3 = Color3.new(1, 1, 1)
CloseAllBtn.Font = Enum.Font.GothamBold
CloseAllBtn.Parent = ListHeader
Instance.new("UICorner", CloseAllBtn).CornerRadius = UDim.new(1, 0)

-- Frame da Lista
local ListFrame = Instance.new("Frame")
ListFrame.Size = UDim2.new(1, 0, 0, 265)
ListFrame.Position = UDim2.new(0, 0, 1, 5)
ListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ListFrame.Parent = ListHeader
Instance.new("UICorner", ListFrame).CornerRadius = UDim.new(0, 10)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -60)
Scroll.Position = UDim2.new(0, 5, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.Parent = ListFrame
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

local InspectBtn = Instance.new("TextButton")
InspectBtn.Size = UDim2.new(0.9, 0, 0, 35)
InspectBtn.Position = UDim2.new(0.05, 0, 1, -45)
InspectBtn.Text = "Ver Jogador"
InspectBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
InspectBtn.TextColor3 = Color3.new(1,1,1)
InspectBtn.Font = Enum.Font.GothamBold
InspectBtn.Parent = ListFrame
Instance.new("UICorner", InspectBtn)

-- 2. GUI DE PERFIL (CENTRAL)
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 280, 0, 380)
ProfileFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ProfileFrame.Visible = false
ProfileFrame.Parent = ScreenGui
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 15)

local ProfileHeader = Instance.new("Frame")
ProfileHeader.Size = UDim2.new(1, 0, 0, 35)
ProfileHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProfileHeader.Parent = ProfileFrame
Instance.new("UICorner", ProfileHeader)

local CloseProfile = Instance.new("TextButton")
CloseProfile.Size = UDim2.new(0, 25, 0, 25)
CloseProfile.Position = UDim2.new(1, -30, 0.5, -12)
CloseProfile.Text = "X"
CloseProfile.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseProfile.TextColor3 = Color3.new(1,1,1)
CloseProfile.Parent = ProfileHeader
Instance.new("UICorner", CloseProfile).CornerRadius = UDim.new(1,0)

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.new(0, 100, 0, 100)
ImageLabel.Position = UDim2.new(0.5, -50, 0, 50)
ImageLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ImageLabel.Parent = ProfileFrame
Instance.new("UICorner", ImageLabel).CornerRadius = UDim.new(1,0)

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 0, 180)
InfoText.Position = UDim2.new(0, 10, 0, 160)
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 14
InfoText.RichText = true
InfoText.Parent = ProfileFrame

-- 3. LÓGICA E FUNÇÕES
local selecionado = nil

function atualizarLista()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 30)
        b.Text = p.Name
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        b.TextColor3 = Color3.new(1,1,1)
        b.Parent = Scroll
        Instance.new("UICorner", b)
        
        b.MouseButton1Click:Connect(function()
            for _, btn in pairs(Scroll:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55) end end
            b.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            selecionado = p
        end)
    end
end

InspectBtn.MouseButton1Click:Connect(function()
    if selecionado then
        local userId = selecionado.UserId
        local content, isReady = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        ImageLabel.Image = content
        
        local tempoNoJogo = math.floor(workspace.DistributedGameTime / 60)
        
        InfoText.Text = string.format([[
<font color="#FFFF00"><b>NOME:</b></font> %s
<font color="#FFFF00"><b>ID:</b></font> %d
<font color="#FFFF00"><b>IDADE DA CONTA:</b></font> %d dias
<font color="#FFFF00"><b>TEMPO NO SERVER:</b></font> %d min
        ]], selecionado.Name, userId, selecionado.AccountAge, tempoNoJogo)
        
        ProfileFrame.Visible = true
    end
end)

-- Fechamentos
CloseAllBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
CloseProfile.MouseButton1Click:Connect(function() ProfileFrame.Visible = false end)

atualizarLista()
Players.PlayerAdded:Connect(atualizarLista)
Players.PlayerRemoving:Connect(atualizarLista)