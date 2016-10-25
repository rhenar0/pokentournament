AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("core/database/db.lua")
include("shared.lua")

--- files

resource.AddFile( "models/weapons/v_pokeball.mdl" )
resource.AddFile( "models/weapons/w_pokeball.mdl" )
resource.AddFile( "models/weapons/w_pokeball_thrown.mdl" )
resource.AddFile( "materials/models/weapons/v_models/orangenade/orange.vmt" )
resource.AddFile( "materials/models/weapons/v_models/orangenade/orange.vtf" )
resource.AddFile( "materials/models/weapons/w_models/orangenade/orange.vmt" )
resource.AddFile( "materials/models/weapons/w_models/orangenade/orange.vtf" )
resource.AddFile( "materials/VGUI/entities/pokeball_base.vmt" )
resource.AddFile( "materials/VGUI/entities/pokeball_base.vmf" )
resource.AddFile( "materials/VGUI/entities/pokeball_capture.vmt" )
resource.AddFile( "materials/VGUI/entities/pokeball_capture.vtf" )
resource.AddFile( "materials/VGUI/entities/pokeball_revive.vmt" )
resource.AddFile( "materials/VGUI/entities/pokeball_revive.vtf" )
