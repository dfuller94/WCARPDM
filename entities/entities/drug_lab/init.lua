-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_combine/combine_mine01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, self.giveMoney, self)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, self.notifypl, self)
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",100)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Entity:GetNWEntity( "owner" )
	ply:GetTable().maxDrug=ply:GetTable().maxDrug + 1
	self.OwnerID = ply:UniqueID()
	self.Inactive = false
	self.unowned = false
	self.Entity:SetNWInt("power",0)
	self.Payout={CfgVars["druglabcost"],"Drug Lab"}
end

function ENT:giveMoney()
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		if !self.Inactive then
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 50 );
				Notify( ply, 2, 3, "Paid $50 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 35 );
				Notify( ply, 2, 3, "Paid $35 for selling drugs." );
			else
				ply:AddMoney( 25 );
				Notify( ply, 2, 3, "Paid $25 for selling drugs." );
			end
		elseif (self.Inactive) then
			Notify( ply, 4, 3, "A drug lab is inactive, press use on it to make it active again." );
		end
	end
end

function ENT:shutOff()
	local ply = self.Entity:GetNWEntity( "owner" )
	self.Inactive = true
	if ValidEntity(ply) then
		Notify( ply, 1, 3, "NOTICE: A DRUG LAB HAS GONE INACTIVE" );
		Notify( ply, 1, 3, "PRESS USE ON IT TO CONTINUE GETTING MONEY" );
		self.Entity:SetColor(255,0,0,255)
	end
end
function ENT:notifypl()
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		Notify( ply, 4, 3, "NOTICE: A DRUG LAB IS ABOUT TO GO INACTIVE" );
		Notify( ply, 4, 3, "PRESS USE ON IT TO PREVENT THIS" );
		self.Entity:SetColor(255,150,150,255)
	end
end

function ENT:Use(activator,caller)
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		self.Entity:SetNWBool("sparking",true)
		timer.Create( tostring(self.Entity) .. "drug", 30, 1, self.createDrug, self)
		timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
		timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, self.shutOff, self)
		timer.Destroy( tostring(self.Entity) .. "notifyoff")
		timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, self.notifypl, self)
		self.Inactive = false
		self.Entity:SetColor(255,255,255,255)
	end
end

function ENT:createDrug()
	local spos = self.SparkPos
	local ang = self.Entity:GetAngles()
	drug = ents.Create("item_drug")
	drug:SetPos(self.Entity:GetPos()+ang:Forward()*spos.x+ang:Right()*spos.y+ang:Up()*spos.z)
	drug:Spawn()
	self.Entity:SetNWBool("sparking",false)
end
 
function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false && !self.unowned) then
		//self.Entity:Remove()
		self.unowned = true
		self.Entity:noOwner()
	end
	self.Entity:NextThink(CurTime()+0.1)
	return true
end

function ENT:noOwner()
	self.Inactive = true
	self.Entity:SetColor(0,255,0,255)
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "findowner", 10, 12, self.ownerTick, self)
	timer.Create( tostring(self.Entity) .. "fail", 120, 1, self.Remove, self)
end

function ENT:ownerTick()
	local ply = player.GetByUniqueID(self.OwnerID)
	if (ValidEntity(ply)) then
		self.unowned = false
		self.Entity:SetNWEntity( "owner", ply )
		Notify(ply,0,3,"A Drug Lab is inactive where you left it")
		timer.Destroy(tostring(self.Entity) .. "findowner")
		timer.Destroy(tostring(self.Entity) .. "fail")
		self.Entity:SetColor(255,0,0,255)
		ply:GetTable().maxDrug=ply:GetTable().maxDrug + 1
	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity) .. "findowner")
	timer.Destroy(tostring(self.Entity) .. "fail")
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		ply:GetTable().maxDrug=ply:GetTable().maxDrug - 1
	end
end

