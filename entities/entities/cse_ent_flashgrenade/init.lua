// this was a cse flashbang.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel("models/weapons/w_eq_flashbang.mdl")
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
	
	self.timer = CurTime() + 1
	self.solidify = CurTime() + 1
end

function ENT:Think()
	if (ValidEntity(self.Entity:GetNWEntity("owner"))==false) then
		self.Entity:Remove()
	end
	if (self.solidify<CurTime()) then
		self.SetOwner(self.Entity)
	end
	if self.timer < CurTime() then
		local pos = self.Entity:GetPos()
		local maxrange = 512
		local maxstun = 70
		for k,v in pairs(player.GetAll()) do
			local plpos = v:GetPos()
			local dist = -pos:Distance(plpos)+maxrange
			if (pos:Distance(plpos)<=maxrange) then
				local trace = {}
					trace.start = self.Entity:GetPos()
					trace.endpos = v:GetPos()+Vector(0,0,24)
					trace.filter = { v, self.Entity }
					trace.mask = COLLISION_GROUP_PLAYER
				tr = util.TraceLine(trace)
				if (tr.Fraction==1) then
					local stunamount = math.ceil(dist/(maxrange/maxstun))
					v:ViewPunch( Angle( stunamount*((math.random()*4)-2), stunamount*((math.random()*4)-2), stunamount*((math.random()*2)-1) ) )
					StunPlayer(v, stunamount)
				end
			end
		end
		local exp = ents.Create("env_explosion")
			exp:SetKeyValue("spawnflags",461)
			exp:SetPos(pos)
		exp:Spawn()
		exp:Fire("explode","",0)
		self.Entity:EmitSound(Sound("Flashbang.Explode"))
		self.Entity:Remove()
	end
end