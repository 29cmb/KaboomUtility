local banDS = game:GetService("DataStoreService"):GetDataStore("KaboomUtilityBans")
local remotes = game.ReplicatedStorage.Remotes
remotes.Kick.OnServerEvent:Connect(function(player, target)
    target:Kick()
end)

remotes.Ban.OnServerEvent:Connect(function(player, target)
    target:Kick()
    banDS:SetAsync(target.UserId, "You have been banned by an administrator.")
end)

game.Players.PlayerAdded:Connect(function(player)
    if banDS:GetAsync(player.UserId) then 
        player:Kick(banDS:GetAsync(player.UserId))
    end
end)

remotes.Bring.OnServerEvent:Connect(function(player, target)
    local playerChar, targetChar = player.Character or player.CharacterAdded:Wait(), target.Character or target.CharacterAdded:Wait()
    targetChar:WaitForChild("HumanoidRootPart").Position = playerChar:WaitForChild("HumanoidRootPart").Position
end)

remotes.To.OnServerEvent:Connect(function(player, target)
    local playerChar, targetChar = player.Character or player.CharacterAdded:Wait(), target.Character or target.CharacterAdded:Wait()
    playerChar:WaitForChild("HumanoidRootPart").Position = targetChar:WaitForChild("HumanoidRootPart").Position
end)