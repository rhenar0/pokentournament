AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

util.AddNetworkString("SendSelf")

function ENT:PhysicsCollide(data, phys)
	self:EmitSound(self.BounceSnd)
	
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
end

function ENT:Initialize()
	self:SetModel("models/weapons/d_pokeball_thrown.mdl")
	self:PhysicsInit(SOLID_CUSTOM)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self.timer = CurTime() + 20
end

function ENT:Think()

end
			
function ENT:Settype(type)
	self.type = type
end
	
function ENT:SetEnt(ent)
	if IsValid(ent) and ent:IsNPC() then
		self.ent = ent
	end
end

function ENT:SetOwner(ply)
	self.GrenadeOwner = ply
	print("Set Owner to " .. ply .. "!")
end
	
function ENT:StartTouch(ent)
	if self:GetNWBool("HasHitNpc") then
		return false 
	end
	print(ent, self.GrenadeOwner)
	if ent ~= self.GrenadeOwner and (ent:IsPlayer() or ent:IsNPC()) and IsValid(ent) and ent:GetClass() ~= "npc_barnacle" then
		if not self:GetNWBool("HasHitNpc") and (ent:IsNPC() or ent:IsPlayer()) and IsValid(ent) then
			self:SetNWBool("HasHitNpc", true)
			self:EmitSound(self.CaptureSnd)
			if SERVER then
				local pball = "pokeball_adminbase"
				local ent1 = ents.Create(pball)
				if ent:IsNPC() then
					ent1.spawn = ent:GetClass()
					ent1.model = ent:GetModel()
				elseif ent:IsPlayer() then
					ent:SetNWBool("IsSpectatingPB", true)
					ent:StripWeapons()
					ent1.spawn = ent
					ent1.model = ent:GetModel()
				end
				ent1:SetPos(self:GetPos())
				ent1:Spawn()
				self:Remove()
			end
		elseif not self.Entity:GetNWBool("HasHitNpc") then
			if SERVER then
				local pball2 = "pokeball_capture"
				local ent2 = ents.Create(pball2)
				--set spawn
				ent2:SetPos(self:GetPos())
				ent2:Spawn()
				self:Remove()
			end
		end
	
		
		self.ent = ent
		self:DoColorstuff(ent)
	end
end

function ENT:DoColorstuff(ent) --Hacky way of doing this, but it looks cool so what the hell
	if ent ~= self.GrenadeOwner then
		ent:SetModelScale(0.25, 1)
		ent:SetColor(Color(255, 0, 0))
		if ent:IsPlayer() then
			ent:Spectate(OBS_MODE_CHASE)
			ent:SpectateEntity(self.GrenadeOwner)
		else 
			timer.Simple(3, function()
				ent:Remove()
			end)
		end
	else 
		
	end
end