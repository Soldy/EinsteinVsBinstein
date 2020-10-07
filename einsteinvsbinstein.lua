specOps ={}
specOpsCount = 0;

specOpsAttackEinstein =  function()
    local lz = templom.Location
    if einstein.IsDead == false then lz = einstein.Location end
    local start = Map.CenterOfCell(Map.RandomEdgeCell()) + WVec.New(0, 0, Actor.CruiseAltitude("badr"))
    local transport = Actor.Create("badr", true, { CenterPosition = start, Owner = creeps, Facing = (Map.CenterOfCell(lz) - start).Facing })

    for i=1, 10 do
        specOpsCount = specOpsCount + 1;
        local start = Map.CenterOfCell(Map.RandomEdgeCell())
        specOps[specOpsCount] = Actor.Create('e1', false, {Owner = creeps })
        transport.LoadPassenger(specOps[specOpsCount])
        Trigger.OnIdle(specOps[specOpsCount], function(a) a.AttackMove(lz) end)
     end
     transport.Paradrop(lz)
     Trigger.AfterDelay(DateTime.Seconds(45), specOpsAttackEinstein);
end


specOpsAttackBinstein =  function()
    local lz = templom.Location
    if binstein.IsDead == false then lz = binstein.Location end
    local start = Map.CenterOfCell(Map.RandomEdgeCell()) + WVec.New(0, 0, Actor.CruiseAltitude("badr"))
    local transport = Actor.Create("badr", true, { CenterPosition = start, Owner = creeps, Facing = (Map.CenterOfCell(lz) - start).Facing })

    for i=1, 10 do
        specOpsCount = specOpsCount + 1;
        local start = Map.CenterOfCell(Map.RandomEdgeCell())
        specOps[specOpsCount] = Actor.Create('e1', false, {Owner = creeps })
        transport.LoadPassenger(specOps[specOpsCount])
        Trigger.OnIdle(specOps[specOpsCount], function(a) a.AttackMove(lz) end)
     end
     transport.Paradrop(lz)
     Trigger.AfterDelay(DateTime.Seconds(45), specOpsAttackBinstein);
end


playerOneWin = function()
    Media.PlaySpeechNotification(playerOne, "Win")
    Media.PlaySpeechNotification(playerTwo, "Lose")
    playerTwo.MarkFailedObjective(twoO)
    playerOne.MarkCompletedObjective(oneO)
end

playerTwoWin = function()
    Media.PlaySpeechNotification(playerTwo, "Win")
    Media.PlaySpeechNotification(playerOne, "Lose")
    playerOne.MarkFailedObjective(oneO)
    playerTwo.MarkCompletedObjective(twoO)
end

WorldLoaded = function()
     creeps = Player.GetPlayer("Creeps")
     playerOne = Player.GetPlayer("Multi0")
     playerTwo = Player.GetPlayer("Multi1")
     rocky.AttackMove(zom10.Location);
     zom496.AttackMove(einstein.Location);
     zom493.AttackMove(einstein.Location);
     oneO = playerOne.AddPrimaryObjective("Defend Einstein")
     twoO = playerTwo.AddPrimaryObjective("Defend Binstein")
     Trigger.AfterDelay(DateTime.Seconds(25), specOpsAttackEinstein);
     Trigger.AfterDelay(DateTime.Seconds(25), specOpsAttackBinstein);
     Trigger.OnKilled(einstein, playerTwoWin)
     Trigger.OnKilled(binstein, playerOneWin)
end
