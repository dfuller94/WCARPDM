-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

// copy pasta from DURG lab

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "drugfactory" )
	ent:SetNWEntity("owner", ply)
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/furniturestove001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then 
		//phys:SetMass(1000)
		phys:Wake()
	end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",250)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Entity:GetNWEntity( "owner" )
	ply:GetTable().maxdrugfactory=ply:GetTable().maxdrugfactory + 1
	self.LastUsed = CurTime()
	self.Booze = 0
	self.Drugs = 0
	self.RandomDrugs = 0
	self.SOffense = 0
	self.SDefense = 0
	self.SWeapmod = 0
	self.Entity:SetNWInt("power",0)
	self.scrap = false
	self.Refmode = 0
end

function ENT:Use(activator,caller)
	if self.LastUsed>CurTime() then 
		self.LastUsed = CurTime()+0.3
		return
	end
	self.LastUsed = CurTime()+0.3
	
	umsg.Start( "killdrugfactorygui", activator );
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
	umsg.Start( "drugfactorygui", activator );
		umsg.Short( self.Entity:GetNWInt("upgrade") )
		umsg.Short( self.Entity:EntIndex() )
		umsg.Short( self.Booze )
		umsg.Short( self.Drugs )
		umsg.Short( self.RandomDrugs )
		umsg.Short( self.SDefense )
		umsg.Short( self.SOffense )
		umsg.Short( self.SWeapmod )
		umsg.Short( self.Refmode )
	umsg.End()
end

function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false) then
		self.Entity:Remove()
	end
end

function ENT:DropDrug()
	local drug = ents.Create("item_random")
	drug:SetPos( self.Entity:GetPos()+Vector(0,0,50));
	drug:Spawn();
end

function ENT:DropSuperDrug()
	if self.Refmode==0 then
		Notify(self.Entity:GetNWEntity("owner"),2,3,"Paid $250 from refining drugs")
		self.Entity:GetNWEntity("owner"):AddMoney(250)
	else
		local stype = "offense"
		if self.Refmode==2 then stype="defense" elseif self.Refmode==3 then stype="weapmod" end
		local drug = ents.Create("item_superdrug"..stype)
		drug:SetPos( self.Entity:GetPos()+Vector(0,0,50));
		drug:Spawn();
	end
end

function ENT:EjectSuperDrugs()
	for i=1,self.SOffense,1 do
		local drug = ents.Create("item_superdrugoffense")
		drug:SetPos( self.Entity:GetPos()+Vector((i*10)-10,10,50));
		drug:Spawn();
	end
	self.SOffense=0
	for i=1,self.SDefense,1 do
		local drug = ents.Create("item_superdrugdefense")
		drug:SetPos( self.Entity:GetPos()+Vector((i*10)-10,0,50));
		drug:Spawn();
	end
	self.SDefense=0
	for i=1,self.SWeapmod,1 do
		local drug = ents.Create("item_superdrugweapmod")
		drug:SetPos( self.Entity:GetPos()+Vector((i*10)-10,-10,50));
		drug:Spawn();
	end
	self.SWeapmod=0
end

function ENT:DropUberDrug()
	local drug = ents.Create("item_uberdrug")
	drug:SetPos( self.Entity:GetPos()+Vector(0,0,50));
	drug:Spawn();
end

function ENT:OnRemove( )
	self.Entity:EjectSuperDrugs()
	timer.Destroy(self.Entity) 
	local ply = self.Entity:GetNWEntity( "owner" )
	if ValidEntity(ply) then
		ply:GetTable().maxdrugfactory=ply:GetTable().maxdrugfactory - 1
	end
end

function ENT:Touch(gun)
	if self.Entity:IsPowered() then
		local upgrade = self.Entity:GetNWInt("upgrade")
		local drugamt = 10
		local randamt = 10
		local boozeamt = 5
		if (upgrade==1) then
			drugamt = 7
			boozeamt = 4
		elseif (upgrade==2) then
			drugamt = 5
			boozeamt = 3
		end
		if (gun:GetClass()=="item_booze" && gun:GetTime()<CurTime()-5) then
			self.Booze=self.Booze+1
			if (self.Booze>=boozeamt) then
				self.Booze = 0
				self.Drugs = self.Drugs+1
				if (self.Drugs>=drugamt) then
					self.Drugs = 0
					self.Entity:DropDrug()
				end
			end
			gun:ResetTime()
			gun:Remove()	
		end
		if (gun:GetClass()=="item_drug" && gun:GetTime()<CurTime()-5) then
			self.Drugs=self.Drugs+1
			if (self.Drugs>=drugamt) then
				self.Drugs = 0
				self.Entity:DropDrug()
			end
			gun:ResetTime()
			gun:Remove()	
		end
		if (gun:GetClass()=="item_random" && upgrade>=1 && gun:GetTime()<CurTime()-5) then
			self.RandomDrugs=self.RandomDrugs+1
			if (self.RandomDrugs>=randamt) then
				self.RandomDrugs = 0
				self.Entity:DropSuperDrug()
			end
			gun:ResetTime()
			gun:Remove()	
		end
		if upgrade>=2 then
			if (gun:GetClass()=="item_superdrugoffense" && gun:GetTime()<CurTime()-5 && self.SOffense<3) then
				self.SOffense=self.SOffense+1
				gun:ResetTime()
				gun:Remove()
			end
			if (gun:GetClass()=="item_superdrugdefense" && gun:GetTime()<CurTime()-5 && self.SDefense<3) then
				self.SDefense=self.SDefense+1
				gun:ResetTime()
				gun:Remove()
			end
			if (gun:GetClass()=="item_superdrugweapmod" && gun:GetTime()<CurTime()-5 && self.SWeapmod<3) then
				self.SWeapmod=self.SWeapmod+1
				gun:ResetTime()
				gun:Remove()
			end
		end
	end
end

function ENT:MakeScraps()
	if !self.scrap then
		self.scrap = true
		local value = CfgVars["drugfactorycost"]/8
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

function ENT:CanRefine(mode,ply)
	if ply!=self.Entity:GetNWEntity("owner") && mode!="eject" then
		return "Only the owner of this Drug Refinery can change settings."
	end
	if !self.Entity:IsPowered() && mode=="uber" then
		return "Low power."
	end
	if mode=="eject" || mode=="money" then return true end
	if (mode=="offense" || mode=="defense" || mode=="weapmod") then
		if self.Entity:GetNWInt("upgrade")>=1 then
			return true
		else
			return "This Refinery is not upgraded enough."
		end
	end
	if mode=="uber" then
		if self.Entity:GetNWInt("upgrade")>=2 then
			if self.SOffense>=3 && self.SDefense>=3 && self.SWeapmod>=3 then
				return true
			else
				return "Not enough Superdrugs."
			end
		else
			return "This Refinery is not upgraded enough."
		end
	end
	return "You're doing it wrong."
end

function ENT:SetMode(mode)
	if mode=="eject" then
		self.Entity:EjectSuperDrugs()
	end
	if mode=="money" then
		self.Refmode=0
	elseif mode=="offense" then
		self.Refmode=1
	elseif mode=="defense" then
		self.Refmode=2
	elseif mode=="weapmod" then
		self.Refmode=3
	elseif mode=="uber" then
		self.Entity:DropUberDrug()
		self.SOffense=0
		self.SDefense=0
		self.SWeapmod=0
		UberDrugExists()
	end
end