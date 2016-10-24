if (SERVER) then

--------------------------------------
-- Core
--------------------------------------

  function DB:CreateTablePlayer()

    if sql.TableExists("gm_prp_player") then
      Msg("-Erreur 011 : Check DB... \n")
    else
      Msg("-DB : Creation Table Joueurs... \n")
      sql.Query("CREATE TABLE gm_prp_player (id INT PRIMARY KEY, type INT, models VARCHAR(250), money INT, xp INT, level INT)")
      Msg("-DB : Creation Table Joueurs : OK \n")
    end

  end

  function DB:CheckTablePlayerExists()

    Msg("-DB : Check Table Joueurs... \n")

    if sql.TableExists("gm_prp_player") then
      Msg("-DB: Check Table Joueurs : OK \n")
    else
      Msg("-Erreur 010 : DB Non Existante... \n")
      Msg("-DB : Tentative de creation...")
      DB:CreateTablePlayer()
    end

  end

  function DB:InitializeTablePlayer()

    Msg("-DB : Initialisation Table Player... \n")
    DB:CheckTablePlayerExists()
    Msg("-DB : Initialisation : OK \n")

  end

-------------------------------------------
--Systeme
-------------------------------------------

  function GM:PlayerSpawn(ply)

    plys = ply:SteamID64()
    if sql.Query("SELECT id WHERE "..plys.." FROM gm_prp_player") then

    else
      Msg("-Nouveau Joueur : "..plys.." : Creation DATA...")
      sql.Query("INSERT INTO gm_prp_player (id, type, models, money, xp, level) VALUES (id = "..plys..", type = 0, models = 'models/test.mdl', money = 0, xp = 0, level = 1)")
      Msg("-Nouveau Joueur : "..plys.." : Creation DATA : OK")
    end

  end

end
