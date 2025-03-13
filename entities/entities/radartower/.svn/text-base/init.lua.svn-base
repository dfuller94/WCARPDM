-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_wasteland/gaspump001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	
	self.Dish = ents.Create("prop_dynamic_override")
	self.Dish:SetModel( "models/props_rooftop/roof_dish001.mdl" )
	self.Dish:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Up()*25)
	//self.Dish:SetAngles(Angle(0,90,90))
	self.Dish:SetParent(self.Entity)
	self.Dish:SetSolid(SOLID_NONE)
	//self.Dish:PhysicsInit(SOLID_NONE)
	self.Dish:SetMoveType(MOVETYPE_NONE)
	
	timer.Create( tostring(self.Entity), 120, 0, self.giveMoney, self)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, self.notifypl, self)
	self.Entity:SetNWInt("damage",200)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Entity:GetNWEntity( "owner" )
	ply:GetTable().maxtower=ply:GetTable().maxtower + 1
	ply:GetTable().Tower = self.Entity
	self.Inactive = false
	self.Entity:SetNWInt("power",0)
	self.Scans = 1
	self.scrap = false
	self.BombNotify=false
end

function ENT:giveMoney()
	local ply = self.Entity:GetNWEntity( "owner" )
	if(ply:Alive() && !self.Inactive) then
		self.Scans = self.Scans + 1
		if self.Scans>10 then
			Notify( ply, 4, 3, "Radar tower is fully charged at 10 charges.")
			self.Scans = 10
		else
			// why did i bother? im not a grammar nazi.
			if self.Scans!=1 then
				Notify( ply, 2, 3, "Radar tower is ready to scan. " .. self.Scans .. " Charges available.")
			else
				Notify( ply, 2, 3, "Radar tower is ready to scan. 1 Charge available.")
			end
		end
	elseif (self.Inactive) then
		Notify( ply, 4, 3, "A radar tower is inactive, press use on it for it to continue charging" );
	end
end

function ENT:shutOff()
	local ply = self.Entity:GetNWEntity( "owner" )
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A RADAR TOWER HAS GONE INACTIVE" );
	Notify( ply, 1, 3, "PRESS USE ON IT FOR IT TO BE ABLE TO KEEP CHARGING" );
	self.Entity:SetColor(255,0,0,255)
	self.Dish:SetColor(255,0,0,255)
end

function ENT:notifypl()
	local ply = self.Entity:GetNWEntity( "owner" )
	Notify( ply, 4, 3, "NOTICE: A RADAR TOWER IS ABOUT TO GO INACTIVE" );
	Notify( ply, 4, 3, "PRESS USE ON IT TO KEEP IT CHARGING" );
	self.Entity:SetColor(255,150,150,255)
	self.Dish:SetColor(255,150,150,255)
end

function ENT:MakeScraps()
	if !self.scrap then
		self.scrap = true
		local value = CfgVars["radartowercost"]/8
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
function ENT:Use(activator,caller)
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, self.notifypl, self)
	self.Inactive = false
	self.Entity:SetColor(255,255,255,255)
	self.Dish:SetColor(255,255,255,255)
end
 
function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false) then
		self.Entity:Remove()
	end
	self.Entity:NextThink(CurTime()+0.1)
	local pos = self.Entity:GetPos()
	local sawbomb=false
	for k,v in pairs(ents.FindByClass("bigbomb")) do
		if v:GetPos():Distance(pos)<2048 then
			sawbomb=true
			if !self.BombNotify then
				Notify(self.Entity:GetNWEntity("owner"),1,3, "Radar tower has detected a Big Bomb")
				self.BombNotify=true
			end
		end
	end
	if !sawbomb then self.BombNotify=false end
	return true
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		ply:GetTable().maxtower=ply:GetTable().maxtower - 1
	end
end

