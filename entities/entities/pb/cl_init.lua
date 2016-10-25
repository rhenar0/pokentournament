include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

function ENT:IsTranslucent()
	return true
end

local pokeball, entity

net.Receive("SendSelf", function()
	pokeball = net.ReadEntity()
	entity = net.ReadEntity()
end)