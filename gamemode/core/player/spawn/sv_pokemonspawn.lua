----------------------------------------
--Core
----------------------------------------

function RetrievePlayer()

  plys = net.ReadString()
  ply = player.GetBySteamID64(plys)

end

net.Receive("PokemonSpawnPlayer", RetrievePlayer)

function RetrievePokemon()

  

end

net.Receive("PokemonSpawnModels", RetrievePokemon)
