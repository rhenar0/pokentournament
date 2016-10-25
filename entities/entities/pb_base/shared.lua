if (SERVER) then
AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.PrintName		= ""
ENT.Author			= "Baddog & Rhenar"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Base = "base_gmodentity"
ENT.spawn = "npc_zombine"
ENT.BounceSnd = Sound("Pokeballs/bounce.wav")
ENT.mat = ""
ENT.model = ""
ENT.player = nil

function ENT:PhysicsCollide(data,phys)
	self:EmitSound(self.BounceSnd)

	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
end

function ENT:Initialize()
	self:SetModel("models/weapons/d_pokeball_thrown.mdl")
	self:PhysicsInit( SOLID_CUSTOM)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	if type(self.spawn) ~= "string" then
		self:SetSpectation(self.spawn)
	end
end

ReleaseSnd = Sound("Pokeballs/release.wav")

function ENT:Think()
	if SERVER then
		self:Release()
		self:DoEffects()
	end
end

function ENT:SetSpectation(ent)
	ent:Spectate(OBS_MODE_CHASE)
	ent:SpectateEntity(self)
end

function ENT:DoEffects()
	local effectdata = EffectData()
	effectdata:SetStart( self:GetPos() )
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetScale( 10 )
	util.Effect( "cball_explode", effectdata )
	self:EmitSound(ReleaseSnd)
	self:Remove()
end

function ENT:Jump()
	if SERVER then
		self:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, 1000))
	end
end

function ENT:Release()
	if type(self.spawn) == "string" then
		local makenpc = ents.Create(self.spawn)

		if self.spawn  == "npc_combine_s" then
			local weps = {"weapon_ar2" , "weapon_smg1"}
			local s = math.random(1, 2)
			makenpc:SetKeyValue( "additionalequipment", weps[s] )
			makenpc:SetKeyValue( "NumGrenades", 5 )
			makenpc:SetKeyValue( "spawnflags", 8192 )
		elseif self.spawn == "npc_metropolice" then
			makenpc:SetKeyValue( "additionalequipment", "weapon_pistol" )
			makenpc:SetKeyValue( "spawnflags", 8192 )
		elseif self.spawn == "npc_monk" then
			makenpc:Give("weapon_annabelle")
			makenpc:SetKeyValue( "spawnflags", 8192 )
		elseif self.spawn == "npc_alyx" then
			makenpc:Give("weapon_alyxgun")
			makenpc:SetKeyValue( "spawnflags", 8192 )
		elseif self.spawn == "npc_barney" then
			makenpc:Give("weapon_pistol")
			makenpc:SetKeyValue( "spawnflags", 8192 )
		elseif self.spawn == "npc_citizen" then
			makenpc:Give("weapon_pistol")
			makenpc:SetKeyValue( "spawnflags", 8192 )
		else
			makenpc:SetKeyValue( "spawnflags", 8192 )
		end
		makenpc:SetNWBool("garrymon", true)
		makenpc:SetOwner( self.GrenadeOwner )
		makenpc:SetPos( self:GetPos() )
		if self.model ~= "" then
			makenpc:SetModel(self.model)
			makenpc:SetMaterial(self.mat)
		end
		makenpc:Spawn()
		makenpc:Activate()

		makenpc:AddRelationship("player d_li 97")

		for k, v in pairs(ents.FindByClass("npc_*")) do
			if v:GetClass() ~= "npc_barnacle" then
				makenpc:AddRelationship(v:GetClass() .. " d_ht 99")
				makenpc:SetEnemy(v)
			end
		end
	else
		self.spawn:UnSpectate()
		self.spawn:SetColor(Color(255, 255, 255))
		self.spawn:Spawn()
		self.spawn:SetPos(self:GetPos())
		self.spawn:SetModelScale(1, 1)
	end
end

if (CLIENT) then

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:IsTranslucent()
	return true
end

end
