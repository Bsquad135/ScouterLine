local Config = {
	Names             = false,
	NamesOutline      = false,
	NamesColor        = Color3.fromRGB(255,255,255),
	NamesOutlineColor = Color3.fromRGB(0,0,0),
	NamesFont         = 2, -- 0,1,2,3
	NamesSize         = 13
}
function CreateEsp(Player)
	local Name = Drawing.new("Text")
	local Updater = game:GetService("RunService").RenderStepped:Connect(function()
		if Player.Character ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") ~= nil then
			local Target2dPosition,IsVisible = workspace.CurrentCamera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
			local scale_factor = 1 / (Target2dPosition.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
			local width, height = math.floor(40 * scale_factor), math.floor(60 * scale_factor)
			if Config.Names then
				Name.Visible = IsVisible
				Name.Color = Config.NamesColor
				Name.Text = Player.Name.." "..math.floor((workspace.CurrentCamera.CFrame.p - Player.Character.HumanoidRootPart.Position).magnitude).."m"
				Name.Center = true
				Name.Outline = Config.NamesOutline
				Name.OutlineColor = Config.NamesOutlineColor
				Name.Position = Vector2.new(Target2dPosition.X,Target2dPosition.Y - height * 0.5 + -15)
				Name.Font = Config.NamesFont
				Name.Size = Config.NamesSize
			else
				Name.Visible = false
			end
		end
	end)
end

for _,v in pairs(game:GetService("Players"):GetPlayers()) do
	if v ~= game:GetService("Players").LocalPlayer then
		CreateEsp(v)
		v.CharacterAdded:Connect(CreateEsp(v))
	end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
	if v ~= game:GetService("Players").LocalPlayer then
		CreateEsp(v)
		v.CharacterAdded:Connect(CreateEsp(v))
	end
end)
return Config