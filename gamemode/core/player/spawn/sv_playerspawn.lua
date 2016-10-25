net.Receive("PlayerRetrieveDATASpawn", function()
  playersteam_playerspawn = net.ReadString()
  models_playerspawn = net.ReadString()
  type_playerspawn = net.ReadString()

  ply_playerspawn = player.GetBySteamID64(playersteam_playerspawn)
end)

function GiveWeapon()

  if type_playerspawn == 1 then
    ply_playerspawn:Give(pokeball)
  else type_playerspawn == 2 then
    net.Start("PokemonSpawn")
    net.WriteString(playersteam_playerspawn)
    net.WriteString(models_playerspawn)
    net.Send(ply_playerspawn)
  end

end

function GM:PlayerSpawn(ply)
    ply:SetModel(models_playerspawn)
    GiveWeapon()
end
