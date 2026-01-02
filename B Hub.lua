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

local Players = Window:MakeTab({
	Name = "Players",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Players:AddSection({
	Name = "Players"
})

Players:AddButton({
	Name = "Imortalidade!",
	Callback = function()
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
  	end    
})

Players:AddButton({
	Name = "Esp TrackerV2",
	Callback = function()
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
  	end    
})

Players:AddButton({
	Name = "Empurrador De Playes!",
	Callback = function()
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
  	end    
})

Players:AddButton({
	Name = "Inspect_Players!",
	Callback = function()
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
  	end    
})

