-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel( "models/props/cs_office/plant01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, self.giveMoney, self)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
	timer.Create( tostring(self.Entity) .. "notifyoff", 600, 1, self.notifypl, self)
	self.Entity:SetNWInt("damage",110)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Entity:GetNWEntity( "owner" )
	ply:GetTable().maxweed=ply:GetTable().maxweed + 1
	self.Inactive = false
	self.Entity:SetNWInt("power",0)
	self.Hemp = false
	self.Payout = {CfgVars["weedcost"],"Plant"}
end

function ENT:giveMoney()
	local ply = self.Entity:GetNWEntity( "owner" )
	
	if(ply:Alive() && !self.Inactive) then
		if self.Hemp==true then
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 3 );
				Notify( ply, 2, 3, "Paid $3 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 2 );
				Notify( ply, 2, 3, "Paid $2 for selling drugs." );
			else
				ply:AddMoney( 1 );
				Notify( ply, 2, 3, "Paid $1 for selling drugs." );
			end
		else
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 10 );
				Notify( ply, 2, 3, "Paid $10 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 7 );
				Notify( ply, 2, 3, "Paid $7 for selling drugs." );
			else
				ply:AddMoney( 5 );
				Notify( ply, 2, 3, "Paid $5 for selling drugs." );
			end
		end
	end
		
end

function ENT:shutOff()
	local ply = self.Entity:GetNWEntity( "owner" )
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A PLANT HAS DIED FROM LACK OF WATER" );
	Notify( ply, 1, 3, "YOU SUCK." );
	self.Entity:Remove()
end
function ENT:notifypl()
	local ply = self.Entity:GetNWEntity( "owner" )
	Notify( ply, 4, 3, "NOTICE: A PLANT NEEDS WATER" );
	Notify( ply, 4, 3, "PRESS USE ON IT TO WATER IT" );
	self.Entity:SetColor(255,150,0,255)
end

function ENT:Explode()
	
end

function ENT:Use(activator,caller)
	timer.Create( tostring(self.Entity) .. "drug", 30, 1, self.createDrug, self)
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 600, 1, self.notifypl, self)
	self.Inactive = false
	if self.Hemp then
		self.Entity:SetColor(200,255,200,255)
	else
		self.Entity:SetColor(255,255,255,255)
	end
end

function ENT:createDrug()
	
end
 
function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false) then
		self.Entity:Remove()
	end
	self.Entity:NextThink(CurTime()+0.1)
	return true
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		ply:GetTable().maxweed=ply:GetTable().maxweed - 1
	end
end

function ENT:Worthless()
	self.Hemp=true
	self.Entity:SetNWInt("damage",40)
	self.Entity:SetColor(200,255,200,255)
end