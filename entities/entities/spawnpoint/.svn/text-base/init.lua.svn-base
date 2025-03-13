// copy pasta sent from ohlol
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

    self.Entity:SetModel( "models/props_trainstation/trainstation_clock001.mdl")
    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local ply = self.Entity:GetNWEntity( "owner" )
    local phys = self.Entity:GetPhysicsObject()
	phys:EnableMotion(false)
    if(phys:IsValid()) then phys:Wake() end
    self.Entity:SetNWInt("damage",100)
    local spawnpointp = true
    ply:GetTable().maxspawn = ply:GetTable().maxspawn + 1
    ply:GetTable().Spawnpoint = self.Entity
	self.Entity:SetNWInt("power",0)
	self.scrap = false
end

function ENT:MakeScraps()
	if !self.scrap then
		self.scrap = true
		local value = CfgVars["spawncost"]/8
		if value<5 then value = 5 end
		for i=0, 5, 1 do
			local scrap = ents.Create("prop_physics")
			scrap:SetModel( "models/gibs/metal_gib" .. math.random(1,5) .. ".mdl" );
			local randpos = Vector(math.random(-5,5), math.random(-5,5), math.random(0,5))
			scrap:SetNWEntity("owner", self.Entity:GetNWEntity("owner"))
			scrap:SetPos(self.Entity:GetPos()+randpos)
			scrap:Spawn()
			scrap:GetTable().ScrapMetal = true
			scrap:GetTable().Amount = math.random(3,value)
			scrap:Activate()
			scrap:GetPhysicsObject():SetVelocity(randpos*35)
			
		end 
	end
end

function ENT:Think( )
	if (ValidEntity(self.Entity:GetNWEntity("owner"))!=true) then
		self.Entity:Remove()
	end
end

function ENT:OnRemove( ) 
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		ply:GetTable().maxspawn = ply:GetTable().maxspawn - 1
	end
end