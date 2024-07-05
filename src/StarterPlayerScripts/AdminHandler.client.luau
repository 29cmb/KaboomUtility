local NexusButton = require(game.ReplicatedStorage.Modules.NexusButton)
local highlights = {}
if not script:FindFirstChild("ScreenGui") then warn("put the ui in the script")else 
	local Admin = script.ScreenGui:Clone()
	Admin.Parent = game.Players.LocalPlayer.PlayerGui

	local playerList = Admin.Dark.Main.PlayerList
	local kick = Admin.Dark.Main.Kick
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
        if highlights[Admin.Dark.Main.SelectedPlayer.Value.Name] ~= nil then 
            highlights[Admin.Dark.Main.SelectedPlayer.Value.Name]:Destroy()
            highlights[Admin.Dark.Main.SelectedPlayer.Value.Name] = nil
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

	refreshPlayerList()
end