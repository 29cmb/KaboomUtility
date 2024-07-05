-- 0.6 transparency

local NexusButton = require(game.ReplicatedStorage.Modules:WaitForChild("NexusButton"))
local highlights = {}
local TweenService = game:GetService("TweenService")
if not script:FindFirstChild("ScreenGui") then warn("put the ui in the script") else 
	local Admin = script.ScreenGui:Clone()
	Admin.Parent = game.Players.LocalPlayer.PlayerGui

	local playerList = Admin.Dark.Main.PlayerList
	local kick = Admin.Dark.Main.Kick
	local ban = Admin.Dark.Main.Ban
	local bring = Admin.Dark.Main.Bring
    local to = Admin.Dark.Main.To
    local track = Admin.Dark.Main.Track
    local untrack = Admin.Dark.Main.Untrack
	local SelectedPlayer = Admin.Dark.Main.SelectedPlayer

	kick.MouseButton1Click:Connect(function()
		if SelectedPlayer.Value ~= nil then 
			game.ReplicatedStorage.Remotes.Kick:FireServer(SelectedPlayer.Value)
		end
	end)

	ban.MouseButton1Click:Connect(function()
		if SelectedPlayer.Value ~= nil then 
			game.ReplicatedStorage.Remotes.Ban:FireServer(SelectedPlayer.Value)
		end
	end)

	bring.MouseButton1Click:Connect(function()
		if SelectedPlayer.Value ~= nil then 
			game.ReplicatedStorage.Remotes.Bring:FireServer(SelectedPlayer.Value)
		end
	end)

    to.MouseButton1Click:Connect(function()
        if SelectedPlayer.Value ~= nil then 
			game.ReplicatedStorage.Remotes.To:FireServer(SelectedPlayer.Value)
		end
    end)

    track.MouseButton1Click:Connect(function()
        if SelectedPlayer.Value ~= nil then
            if highlights[SelectedPlayer.Value.Name] ~= nil then return end
            local char = SelectedPlayer.Value.Character or SelectedPlayer.Value.CharacterAdded:Wait()
            local highlight = Instance.new("Highlight", char)
            highlights[SelectedPlayer.Value.Name] = highlight
        end
    end)

    untrack.MouseButton1Click:Connect(function()
        if highlights[SelectedPlayer.Value.Name] ~= nil then 
            highlights[SelectedPlayer.Value.Name]:Destroy()
            highlights[SelectedPlayer.Value.Name] = nil
        end
    end)


	function refreshPlayerList()
		for _,v in pairs(playerList:GetChildren()) do 
			if v:IsA("Frame") and v.Name ~= "PlayerTemplate" then 
				v:Destroy()
			end
		end

		for _,plr in pairs(game.Players:GetPlayers()) do 
			local template = playerList.PlayerTemplate:Clone()
			template.Parent = playerList
			template.Visible = true
			template.Username.Text = plr.Name
			template.User.Image = `rbxthumb://type=AvatarHeadShot&id={plr.UserId}&w=420&h=420`

			template.Click.MouseButton1Click:Connect(function()
				if game.Players:FindFirstChild(plr.Name) then 
					Admin.Dark.Main.SelectedPlayer.Value = plr
					Admin.Dark.Main.Username.Text = plr.DisplayName .." (@" .. plr.Name .. ")"
				end
			end)
		end
	end
	local debounce = false

	local frame = Instance.new("Frame", Admin)
	frame.Size = UDim2.new(1,0,1,0)
	frame.BackgroundTransparency = 1
	local frame2 = Instance.new("Frame", Admin)
	frame2.Size = UDim2.new(1,0,1,0)
	frame2.BackgroundTransparency = 1
	frame2.Position = UDim2.new(0,0,0.3,0)

	local OpenButton = NexusButton.new()
	OpenButton.Size = UDim2.new(0,200,0.1,0)
	OpenButton.Position = UDim2.new(0,20,0.875,0)
	OpenButton.BackgroundColor3 = Color3.new(0,170/255,255/255)
	OpenButton.BorderColor3 = Color3.new(0,140/255,225/255)
	OpenButton.BorderTransparency = 0.25
	OpenButton.Parent = frame

	local CloseButton = NexusButton.new()
	CloseButton.Size = UDim2.new(0,200,0.1,0)
	CloseButton.Position = UDim2.new(0,20,0.875,0)
	CloseButton.BackgroundColor3 = Color3.new(170/255,0,0)
	CloseButton.BorderColor3 = Color3.new(124/255, 0, 0)
	CloseButton.BorderTransparency = 0.25
	CloseButton.Parent = frame2

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Size = UDim2.new(1,0,0.9,0)
	TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
	TextLabel.Position = UDim2.new(0.5,0,0.5,0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.ZIndex = 5
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.TextColor3 = Color3.new(1,1,1)
	TextLabel.TextStrokeColor3 = Color3.new(0,0,0)
	TextLabel.TextStrokeTransparency = 0
	TextLabel.TextScaled = true
	TextLabel.Text = "Open"
	TextLabel.Parent = OpenButton:GetAdornFrame()

	local TextLabel2 = Instance.new("TextLabel")
	TextLabel2.Size = UDim2.new(1,0,0.9,0)
	TextLabel2.AnchorPoint = Vector2.new(0.5,0.5)
	TextLabel2.Position = UDim2.new(0.5,0,0.5,0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.ZIndex = 5
	TextLabel2.Font = Enum.Font.SourceSansBold
	TextLabel2.TextColor3 = Color3.new(1,1,1)
	TextLabel2.TextStrokeColor3 = Color3.new(0,0,0)
	TextLabel2.TextStrokeTransparency = 0
	TextLabel2.TextScaled = true
	TextLabel2.Text = "Close"
	TextLabel2.Parent = CloseButton:GetAdornFrame()

	OpenButton.MouseButton1Click:Connect(function()
		if debounce == false then 
			debounce = true
			TweenService:Create(frame, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0,0,0.3,0)}):Play()
			TweenService:Create(frame2, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0,0,0,0)}):Play()
			TweenService:Create(Admin.Dark, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.6}):Play()
			TweenService:Create(Admin.Dark.Main, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
			task.wait(1.7)
			debounce = false
		end

		refreshPlayerList()
	end)

	CloseButton.MouseButton1Click:Connect(function()
		if debounce == false then 
			debounce = true
			TweenService:Create(frame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0,0,0,0)}):Play()
			TweenService:Create(frame2, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0,0,0.3,0)}):Play()
			TweenService:Create(Admin.Dark, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
			TweenService:Create(Admin.Dark.Main, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 1.5, 0)}):Play()
			task.wait(1.7)
			debounce = false
		end
	end)
end