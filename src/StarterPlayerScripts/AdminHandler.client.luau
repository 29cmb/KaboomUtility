local Admin = script.ScreenGui:Clone()
Admin.Parent = game.Players.LocalPlayer.PlayerGui

local playerList = Admin.Dark.Main.PlayerList

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
    end
end

refreshPlayerList()