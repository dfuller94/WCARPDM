
TOOL.Category		= "Construction"
TOOL.Name			= "#No Collide"
TOOL.Command		= nil
TOOL.ConfigName		= nil


cleanup.Register( "nocollide" )

function TOOL:LeftClick( trace )

	if (!trace.Entity ) then return end
	if (!trace.Entity:IsValid()) then return end
	if (trace.Entity:IsPlayer()) then return end
	
	// If there's no physics object then we can't constraint it!
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	local iNum = self:NumObjects()
	
	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )
	
	if (CLIENT) then
	
		if ( iNum > 0 ) then
			self:ClearObjects()
		end
		
		return true 
		
	end
	
	if ( iNum > 0 ) then
		
		local Ent1,  Ent2  = self:GetEnt(1),	self:GetEnt(2)
		local Bone1, Bone2 = self:GetBone(1),	self:GetBone(2)

		local constraint = constraint.NoCollide(Ent1, Ent2, Bone1, Bone2)
	
		undo.Create("NoCollide")
		undo.AddEntity( constraint )
		undo.SetPlayer( self:GetOwner() )
		undo.Finish()
		
		self:GetOwner():AddCleanup( "nocollide", constraint )
		
		self:ClearObjects()
	
	else
		
		self:SetStage( iNum+1 )
	
	end
		
	return true
	
end

function TOOL:RightClick( trace )

	if (!trace.Entity ) then return end
	if (!trace.Entity:IsValid()) then return end
	if (trace.Entity:IsPlayer()) then return end
	if SERVER then
		if (self:GetOwner():GetNWBool("shitwelding")) then 
			Notify(self:GetOwner(), 1, 3, "You cannot use this when people have welded your stuff or have recently bombed you!")
			return false;
		end
	end
	if ( CLIENT ) then return true end
	
	if ( trace.Entity.CollisionGroup == COLLISION_GROUP_WORLD ) then
	
		trace.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
		trace.Entity.CollisionGroup = COLLISION_GROUP_NONE
	
	else
	
		trace.Entity:SetCollisionGroup( COLLISION_GROUP_WORLD )
		trace.Entity.CollisionGroup = COLLISION_GROUP_WORLD
		
	end
	
	return true
	
end

function TOOL:Reload( trace )

	if (!trace.Entity:IsValid() || trace.Entity:IsPlayer() ) then return false end
	if ( CLIENT ) then return true end
	
	local  bool = constraint.RemoveConstraints( trace.Entity, "NoCollide" )
	return bool
	
end
