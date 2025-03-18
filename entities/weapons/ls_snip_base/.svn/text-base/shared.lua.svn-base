if(SERVER) then
	AddCSLuaFile( "cl_init.lua" )
	AddCSLuaFile( "shared.lua" )
end

SWEP.DrawCrosshair 		= false
SWEP.Base				= "weapon_cs_base"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false


SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 100
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0001
SWEP.Primary.UnscopedCone	= 0.5
SWEP.Primary.Delay			= .7

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ViewModelFOV = 70

/*---------------------------------------------------------
---------------------------------------------------------*/
function SWEP:Initialize()

	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	
	self.Weapon:SetNetworkedBool( "Ironsights", false )
	
end

/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	
	self.Weapon:SetNextSecondaryFire( CurTime() )
	if self.Owner:GetNWBool("doubletapped") then
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay*drugeffect_doubletapmod )
	else
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	end
	//self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if ( !self:CanPrimaryAttack() ) then return end
	
	// Play shoot sound
	self.Weapon:EmitSound( self.Primary.Sound )
	local rcone = self.Primary.Cone
	if (self.Owner:GetNWBool("focused")) then
		rcone = rcone*0.85
	end
	local rcone2 = self.Primary.UnscopedCone
	if (self.Owner:GetNWBool("focused")) then
		rcone2 = rcone2*0.85
	end
	// Shoot the bullet
	if( self.Owner:GetNetworkedInt( "ScopeLevel", 0 ) > 0 ) then 
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, rcone )
	else
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, rcone2 )	
	end
	
	// Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	// Punch the player's view
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	
	// In singleplayer this function doesn't get called on the client, so we use a networked float
	// to send the last shoot time. In multiplayer this is predicted clientside so we don't need to 
	// send the float.
	if ( (SinglePlayer() && SERVER) || CLIENT ) then
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
	end
	
	--self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
	
	--if(SERVER) then
	--	self.Owner:SetFOV( 0, 0 )
	--end	
	
	--self:SetIronsights( false )
	
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:CSShootBullet( dmg, recoil, numbul, cone )

	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01

	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()			// Source
	bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
	bullet.Spread 	= Vector( cone, cone, 0 )			// Aim Cone
	bullet.Tracer	= 4									// Show a tracer on every x bullets 
	bullet.Force	= 5									// Amount of force to give to phys objects
	if self.Owner:GetTable().ShockWaved then
		bullet.Damage	= 0
		bullet.SDamage  = dmg
	else
		bullet.Damage 	= dmg
	end
	bullet.Attacker = self.Owner
	bullet.Callback = function(attacker,tr,dmginfo)
		if attacker:GetTable().ShockWaved then
			local radius = bullet.SDamage*2
			if radius<32 then radius=32 elseif radius>64 then radius = 64 end
			util.BlastDamage(dmginfo:GetInflictor(),attacker,tr.HitPos, radius, bullet.SDamage*drugeffect_shockwavemultiplier)
			if SERVER then
				ShockWaveExplosion(tr.HitPos, self.Owner, tr.HitNormal, radius)
			end
		end
		
		if attacker:GetTable().MagicBulleted && ValidEntity(tr.Entity) && math.random(0,1)==1 then
			if tr.Entity:IsPlayer() then
				local ply = tr.Entity
				local firedoneoff = false
				for k, v in pairs(player.GetAll()) do
					if !firedoneoff && ply:GetPos():Distance(v:GetPos())<2048 && attacker:GetPos():Distance(v:GetPos())>ply:GetPos():Distance(v:GetPos()) && v!=attacker && v!=ply && v:Alive() then
						local traceshit = {}
							traceshit.start = ply:GetPos()+Vector(0,0,25)
							traceshit.endpos = v:GetPos()+Vector(0,0,25)
							traceshit.filter = { ply, v, attacker }
							traceshit.mask = COLLISION_GROUP_PLAYER
						traceshit = util.TraceLine(traceshit)
						if traceshit.Fraction==1 then
							local shotdir = (v:GetPos()+Vector(0,0,30))-(ply:GetPos()+Vector(0,0,30))
							firedoneoff = true
							local magshot = {}
								magshot.Num = 1
								magshot.Src = ply:GetShootPos()
								magshot.Dir = shotdir:GetNormal()
								magshot.Spread = Vector( 0,0,0 )
								magshot.Tracer = 1
								magshot.Force = 5
								magshot.Damage = 0
								magshot.attacker = attacker
							ply:FireBullets(magshot)
							v:TakeDamage(dmginfo:GetDamage()*.5, attacker, attacker)
						end
					end
				end
			end
		end
	end
	
	self.Weapon:FireBullets( bullet )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 		// View model animation
	self.Owner:MuzzleFlash()								// Crappy muzzle light
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				// 3rd Person Animation
	
	// CUSTOM RECOIL !
	if ( (SinglePlayer() && SERVER) || ( !SinglePlayer() && CLIENT ) ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil
		self.Owner:SetEyeAngles( eyeang )
	
	end

end

local IRONSIGHT_TIME = 0.25

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	if ( self.Weapon:GetNetworkedBool( "Ironsights" ) == b ) then return end
	self.Weapon:SetNetworkedBool( "Ironsights", b )

end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
	if( self.Owner:GetNetworkedInt( "ScopeLevel" ) == nil ) then
		self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
	end
	
	if(self.Owner:GetNetworkedInt( "ScopeLevel" ) == 0) then
	
		if(SERVER) then
			self.Owner:SetFOV( 45, 0 )
		end	
		
		self.Owner:SetNetworkedInt( "ScopeLevel", 1 )
		self:SetIronsights( true )
		
	else if(self.Owner:GetNetworkedInt( "ScopeLevel" ) == 1) then
	
		if(SERVER) then
			self.Owner:SetFOV( 15, 0 )
		end	
		
		self.Owner:SetNetworkedInt( "ScopeLevel", 2 )
		self:SetIronsights( true )
		
	else

		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
		end		
		
		self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
		self:SetIronsights( false )
		
	end
	end
	
end

function SWEP:Holster()

	if(SERVER) then
		self.Owner:SetFOV( 0, 0 )
	end
	if ValidEntity(self.Owner) then
		self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
	end
	self:SetIronsights( false )
	
	return true
	
end

function SWEP:Deploy()
	self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
	self:SetIronsights( false )
	return true
end

function SWEP:Reload()

	if(SERVER) then
		self.Owner:SetFOV( 0, 0 )
	end
	
	self.Owner:SetNetworkedInt( "ScopeLevel", 0 )

	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self:SetIronsights( false )
	
	return true
	
end

/*---------------------------------------------------------
	DrawHUD
	
	Just a rough mock up showing how to draw your own crosshair.
	
---------------------------------------------------------*/
function SWEP:DrawHUD()

	// No crosshair when ironsights is on
	if ( self.Weapon:GetNetworkedBool( "Ironsights" ) ) then return end

	//gets the center of the screen 
local x = ScrW() / 2.0 
local y = ScrH() / 2.0 
//set the drawcolor 
surface.SetDrawColor( 0, 0, 0, 255 ) 
local gap = 10 
local length = gap + 15 
//draw the crosshair 
surface.DrawLine( x - length, y, x - gap, y ) 
surface.DrawLine( x + length, y, x + gap, y ) 
surface.DrawLine( x, y - length, x, y - gap ) 
surface.DrawLine( x, y + length, x, y + gap ) 

end

/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------*/
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
	
	// try to fool them into thinking they're playing a Tony Hawks game
	if (self.Weapon:GetNWBool("upgraded")) then
		draw.SimpleText("K", "CSKillIcons", x + wide-20, y + tall-25, Color(200,200, 200, 255), TEXT_ALIGN_CENTER )
	end
end

function SWEP:ShouldDropOnDie()
	return true
end