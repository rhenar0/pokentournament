-------------------------------
-- Interface
-------------------------------

function InterfaceNewCharacter()

  draw.RoundedBox(0,0,0,0,0, Color(255,255,255,255))

  local MatCreateNewPlayer = Material("materials/pokemonrp/interface/newcharacter.png")

end

--------------------------------
-- VerificationType
--------------------------------

function CreateNewCharacter()

  InterfaceNewCharacter()

end

net.Receive("NewPlayer",CreateNewCharacter)
