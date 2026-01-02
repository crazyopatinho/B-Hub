local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "B Hub (By Isllan)", HidePremium = false, IntroText = "B Hub",  SaveConfig = true, ConfigFolder = "B Hub Tests"})

OrionLib:MakeNotification({
	Name = "Title!",
	Content = "B Hub Injection... Success",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Main:AddSection({
	Name = "Player Local"
})

Main:AddButton({
	Name = "Congela!",
	Callback = function()
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
  	end    
})

Main:AddButton({
	Name = "Girar(Modo Furacã!)",
	Callback = function()
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
  	end    
})

Main:AddButton({
	Name = "Gui Players!",
	Callback = function()
      	-- PAINEL VIGILANTE: TP & VIEW (Otimizado para Mobile)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- Criando a Interface Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelVigilanteV2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Variáveis de controle
local selecionado = nil
local visualizando = false

-- Botão de Abrir/Fechar (Lado Esquerdo)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "MENU"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = ScreenGui

local UICorner_T = Instance.new("UICorner")
UICorner_T.CornerRadius = UDim.new(0, 15)
UICorner_T.Parent = ToggleBtn

-- Frame Principal (Lado Direito)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Position = UDim2.new(1, -260, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner_M = Instance.new("UICorner")
UICorner_M.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LISTA DE ALVOS"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Lista Rolável (ScrollingFrame)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 0, 240)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.ScrollBarThickness = 6
Scroll.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0, 5)

-- Botões Inferiores (TP e VIEW)
local TpBtn = Instance.new("TextButton")
TpBtn.Size = UDim2.new(0, 115, 0, 50)
TpBtn.Position = UDim2.new(0, 5, 1, -55)
TpBtn.Text = "TELEPORT"
TpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TpBtn.TextColor3 = Color3.new(1, 1, 1)
TpBtn.Font = Enum.Font.SourceSansBold
TpBtn.Parent = MainFrame

local ViewBtn = Instance.new("TextButton")
ViewBtn.Size = UDim2.new(0, 115, 0, 50)
ViewBtn.Position = UDim2.new(1, -120, 1, -55)
ViewBtn.Text = "VIEW"
ViewBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
ViewBtn.TextColor3 = Color3.new(1, 1, 1)
ViewBtn.Font = Enum.Font.SourceSansBold
ViewBtn.Parent = MainFrame

-- Lógica de Abrir/Fechar
ToggleBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Função para Atualizar a Lista
function atualizarLista()
	for _, child in pairs(Scroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end

	for _, p in pairs(Players:GetPlayers()) do
		if p ~= lp then
			local pBtn = Instance.new("TextButton")
			pBtn.Size = UDim2.new(1, -10, 0, 40)
			pBtn.Text = p.Name
			pBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			pBtn.TextColor3 = Color3.new(1, 1, 1)
			pBtn.Parent = Scroll
			
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = pBtn

			pBtn.MouseButton1Click:Connect(function()
				-- Resetar cores
				for _, b in pairs(Scroll:GetChildren()) do
					if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
				end
				pBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Selecionado
				selecionado = p
			end)
		end
	end
	Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end

-- Lógica do Teleport
TpBtn.MouseButton1Click:Connect(function()
	if selecionado and selecionado.Character and selecionado.Character:FindFirstChild("HumanoidRootPart") then
		lp.Character.HumanoidRootPart.CFrame = selecionado.Character.HumanoidRootPart.CFrame
	end
end)

-- Lógica do View (Espionar)
ViewBtn.MouseButton1Click:Connect(function()
	if selecionado and selecionado.Character then
		visualizando = not visualizando
		if visualizando then
			workspace.CurrentCamera.CameraSubject = selecionado.Character.Humanoid
			ViewBtn.Text = "UNVIEW"
			ViewBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		else
			workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
			ViewBtn.Text = "VIEW"
			ViewBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
		end
	end
end)

-- Inicialização e Eventos
atualizarLista()
Players.PlayerAdded:Connect(atualizarLista)
Players.PlayerRemoving:Connect(atualizarLista)
  	end    
})

Main:AddButton({
	Name = "Alma!",
	Callback = function()
      	-- SCRIPT ALMA: SKIN + FLY DIRECIONAL + NO-CLIP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- Configurações
local flyVelocidade = 60
local corEscura = Color3.fromRGB(20, 20, 20)
local corCabeca = Color3.fromRGB(255, 0, 0)

-- Variáveis de Estado
local voando = false
local originalColors = {}
local ferramenta = Instance.new("Tool")
ferramenta.Name = "Alma"
ferramenta.RequiresHandle = false
ferramenta.Parent = lp.Backpack

-- 1. FUNÇÃO DE APARÊNCIA (SKIN)
local function aplicarSkin(char, ativar)
	if ativar then
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") then
				if not originalColors[p.Name] then
					originalColors[p.Name] = p.Color
				end
				if p.Name == "Head" then
					p.Color = corCabeca
				else
					p.Color = corEscura
				end
			end
		end
	else
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") and originalColors[p.Name] then
				p.Color = originalColors[p.Name]
			end
		end
		originalColors = {}
	end
end

-- 2. PREPARAÇÃO DA FÍSICA
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

-- Evento de Equipar/Desequipar
ferramenta.Equipped:Connect(function()
	local char = lp.Character
	if char then aplicarSkin(char, true) end
end)

ferramenta.Unequipped:Connect(function()
	local char = lp.Character
	if char then 
		aplicarSkin(char, false) 
	end
	voando = false
	bodyVelocity.Parent = nil
end)

-- Ativar/Desativar com clique
ferramenta.Activated:Connect(function()
	voando = not voando
	if voando then
		bodyVelocity.Parent = lp.Character:WaitForChild("HumanoidRootPart")
		lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	else
		bodyVelocity.Parent = nil
	end
end)

-- 3. LOOP DE MOVIMENTO E NO-CLIP
RunService.RenderStepped:Connect(function()
	if voando and lp.Character then
		local root = lp.Character:FindFirstChild("HumanoidRootPart")
		if root then
			local camera = workspace.CurrentCamera
			-- Movimentação
			bodyVelocity.Velocity = camera.CFrame.LookVector * flyVelocidade
			root.CFrame = CFrame.new(root.Position, root.Position + camera.CFrame.LookVector)
			
			-- FUNÇÃO NO-CLIP: Desativa colisão de todas as partes do corpo
			for _, parte in pairs(lp.Character:GetDescendants()) do
				if parte:IsA("BasePart") then
					parte.CanCollide = false
				end
			end
		end
	end
end)
  	end    
})