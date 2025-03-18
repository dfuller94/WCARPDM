// this was a cse flashbang.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel("models/props_junk/garbage_glassbottle003a.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	// Don't collide with the player
	// too bad this doesn't actually work.
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Sleep()
	end
	
	self.timer = CurTime() + 6
	self.solidify = CurTime() + 1
	self.Bastardgas = nil
	self.Spammed = false
	self.DidHit = false
end

function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false) then
		self.Entity:Remove()
	end
	if (self.solidify<CurTime()) then
		self.SetOwner(self.Entity)
	end
end

local sndIgnite = Sound("PropaneTank.Burst")
function ENT:FireStorm()
	self.Entity:EmitSound(sndIgnite)
	local pos = self.Entity:GetPos()
	local maxrange = 384
	local maxstun = 12
	
	local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
		effectdata:SetEntity( self.Entity )
		effectdata:SetStart( self.Entity:GetPos() )
		effectdata:SetNormal( Vector(0,0,1) )
		effectdata:SetScale( 10 )
	util.Effect( "HelicopterMegaBomb", effectdata )
	
	for i=0,20,1 do
		local Pos = self.Entity:GetPos()
		local Ang = Angle(-math.random(1,90),math.random(0,360),-math.random(1,90)):Forward()
		
		local trace = {}
		trace.start = Pos
		trace.endpos = Pos + (Ang*1024)
		trace.filter = self.Owner
		
		local traceRes = util.TraceLine(trace)
		local hitpos = traceRes.HitPos
		
		local vel = 0
		// add their own velocity to it to ensure that people who are running away are burned too.
		if ValidEntity(traceRes.Entity) then
			vel = traceRes.Entity:GetVelocity():Distance(Vector(0,0,0))
		end
		local jetlength = (hitpos - Pos):Length()+vel
		if jetlength > 384 then jetlength = 384 end
		if jetlength < 6 then jetlength = 6 end
		local effectdata = EffectData()
		effectdata:SetOrigin( hitpos )
		effectdata:SetEntity( self.Entity )
		effectdata:SetStart( Pos )
		effectdata:SetNormal( Ang )
		effectdata:SetScale( jetlength )
		//effectdata:SetAttachment( 1 )
		util.Effect( "flamepuffs", effectdata )
	end
	for i=1,7 do
		local fire = ents.Create("env_fire")
		local randvec = Vector(math.random(-100,100),math.random(-100,100),0)
		fire:SetKeyValue("StartDisabled","0")
		fire:SetKeyValue("health",math.random(17,23))
		fire:SetKeyValue("firesize",math.random(58,73))
		fire:SetKeyValue("fireattack","1")
		fire:SetKeyValue("ignitionpoint","0")
		fire:SetKeyValue("damagescale","2")
		fire:SetKeyValue("spawnflags",136)
		
		fire:SetPos(pos + randvec)
		fire:SetOwner(self.Entity:GetNWEntity("owner"))
		fire:Spawn()
		fire:Fire("StartFire","","0")
	end
	self.Entity:Remove()
	for k, v in pairs(ents.FindInSphere(pos, 384)) do
		local plpos = v:GetPos()
		local dist = -pos:Distance(plpos)+maxrange
		if (pos:Distance(plpos)<=maxrange) then
			local trace = {}
				trace.start = self.Entity:GetPos()
				trace.endpos = v:GetPos()+Vector(0,0,24)
				trace.filter = { v, self.Entity }
				//trace.mask = COLLISION_GROUP_PLAYER
			tr = util.TraceLine(trace)
			if tr.Fraction==1 then
				local stunamount = math.ceil(dist/(maxrange/maxstun))
				if v:IsPlayer() then
					BurnPlayer(v, stunamount, self.Entity:GetNWEntity("owner"), self.Entity:GetNWEntity("owner"):GetWeapon("weapon_molotov"))
				end
				v:TakeDamage(stunamount*3,self.Entity:GetNWEntity("owner"), self.Entity:GetNWEntity("owner"):GetWeapon("weapon_molotov"))
			end
		end
	end
end

function ENT:PhysicsUpdate()
	if self.DidHit then
		self.Entity:FireStorm()
	end
end

function ENT:PhysicsCollide(data,phys)
	data.HitNormal = data.HitNormal*-100
	local start = data.HitPos+data.HitNormal
	local endpos = data.HitPos+data.HitNormal*-1
	util.Decal("Scorch",start,endpos)
	local effectdata = EffectData()
	effectdata:SetOrigin( data.HitPos )
	util.Effect( "explosion_large", effectdata )
	self.DidHit=true
end
