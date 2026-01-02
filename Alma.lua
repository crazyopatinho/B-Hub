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