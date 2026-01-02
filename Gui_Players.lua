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