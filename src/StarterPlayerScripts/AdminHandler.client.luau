if not script:FindFirstChild("ScreenGui") then warn("put the ui in the script")else 
local Admin = script.ScreenGui:Clone()
Admin.Parent = game.Players.LocalPlayer.PlayerGui

local playerList = Admin.Dark.Main.PlayerList
local kick = Admin.Dark.Main.Kick

kick.MouseButton1Click:Connect(function()
    if Admin.Dark.Main.SelectedPlayer.Value ~= nil then 
        game.ReplicatedStorage.Remotes.Kick:FireServer(Admin.Dark.Main.SelectedPlayer.Value)
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
            end
        end)
    end
end

refreshPlayerList()
end