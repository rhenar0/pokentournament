include("core/database/player.lua")

-------------------------------------
--Core
-------------------------------------

function DB:InitializeTable()
  Msg("----Initilisation des DB...")
  DB:InitializeTablePlayer()
  Msg("----Initilisation des DB : OK")
end
