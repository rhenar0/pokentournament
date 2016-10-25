if (SERVER) then
	AddCSLuaFile ("shared.lua")
	SWEP.Weight 			= 5
	SWEP.AutoSwitchTo 		= false
	SWEP.AutoSwitchFrom 	= false
	--net.Receive("give_monster",  function(len, ply) ply:Give("pokeball_base") ply:GetWeapon("pokeball_base"):SetSpawn(net.ReadString()) end)
end

if (CLIENT) then
	SWEP.PrintName 			= "Pokeball Pleine"
	SWEP.Slot 				= 1
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= true
	SWEP.ViewModelFOV		= 65
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= false
	SWEP.BounceWeaponIcon   = false
	SWEP.WepSelectIcon		= surface.GetTextureID("vgui/entities/pokeball_capture")
	print("!")
end

function SWEP:SetSpawn(ent)
	self.spawn = ent
end


SWEP.ent = "pb_base"
SWEP.spawn = "npc_zombine"
SWEP.model = ""
SWEP.mat = ""

SWEP.Author 		= "Baddog & Rhenar"
SWEP.Contact 		= "contact@pokemonrp.fr"
SWEP.Purpose 		= "Force things to fight"
SWEP.Category		= "Pokeballs"

SWEP.Spawnable 		= true
SWEP.AdminOnly = true

SWEP.ViewModel 		= "models/weapons/v_pokeball.mdl"
SWEP.WorldModel 	= "models/weapons/w_pokeball.mdl"

SWEP.Primary.ClipSize	 = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic	 = true
SWEP.Primary.Ammo 		 = "none"

SWEP.Secondary.ClipSize 	= 1
SWEP.Secondary.DefaultClip 	= 1
SWEP.Secondary.Automatic 	= true
SWEP.Secondary.Ammo 		= "none"


function SWEP:Initialize()
	self:SetWeaponHoldType("grenade")
	if type(self.spawn) ~= "string" then
		self:SetSpectation(self.spawn)
	end
end

function SWEP:Deploy()
	self.Weapon:SetNextPrimaryFire(CurTime()+1)
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Holster()
	self.Proned = false
	self.Throwing = false
	return true
end

function SWEP:Think()
	if self.Proned and not self.Owner:KeyDown ( IN_ATTACK ) and self.Owner:KeyReleased(IN_ATTACK) then
		self.Proned = false
		self.Throwing = true
		self.Weapon:SendWeaponAnim(ACT_VM_THROW)
		if self:IsValid() then
			timer.Simple( 0.35, function()
				self:Throw()
			end)
		end
	end
end

function SWEP:Throw()
	if !self.Throwing then return end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local tr = self.Owner:GetEyeTrace()

	if (!SERVER) then return end

	local ent = ents.Create (self.ent)

	ent.spawn = self.spawn
	ent.mat = self.mat
	ent.model = self.model


		local v = self.Owner:GetShootPos()
		v = v + self.Owner:GetForward() * 1
		v = v + self.Owner:GetRight() * 3
		v = v + self.Owner:GetUp() * 1
	ent:SetPos( v )
	ent:SetAngles (Angle(math.random(1,100),math.random(1,100),math.random(1,100)))
--	ent.GrenadeOwner = self.Owner
--	ent:SetOwner(self.Owner)
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	local shot_length = tr.HitPos:Length()

	phys:ApplyForceCenter(self.Owner:GetAimVector() *2500 *1.2 + Vector(0,0,200) )
	phys:AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.6 )

	timer.Simple(0.6,
	function()
		self.Weapon:Remove()
		self.Owner:ConCommand("lastinv")
	end)
end

function SWEP:SetSpectation(ent)
	ent:Spectate(OBS_MODE_CHASE)
	ent:SpectateEntity(self.Owner)
end

function SWEP:PrimaryAttack()
	if self.Throwing then return end
	if !self.Proned then
		self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
		self.Proned = true
	end
end
