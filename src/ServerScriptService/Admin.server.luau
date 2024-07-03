local remotes = game.ReplicatedStorage.Remotes
remotes.Kick.OnServerEvent:Connect(function(player, target)
    target:Kick()
end)

remotes.Bring.OnServerEvent:Connect(function(player, target)
    local playerChar, targetChar = player.Character or player.CharacterAdded:Wait(), target.Character or target.CharacterAdded:Wait()
    targetChar:WaitForChild("HumanoidRootPart").Position = playerChar:WaitForChild("HumanoidRootPart")
end)