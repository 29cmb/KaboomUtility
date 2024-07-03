local remotes = game.ReplicatedStorage.Remotes
remotes.Kick.OnServerEvent:Connect(function(player, target)
    target:Kick()
end)