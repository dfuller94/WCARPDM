

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Dart Gun"			
	SWEP.Author				= "HLTV Proxy"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= false
	SWEP.IconLetter			= "g"
	SWEP.DrawCrosshair		= true
	
	surface.CreateFont( "HalfLife2", ScreenScale( 60 ), 500, true, true, "HL2SelectIcons" )
	killicon.AddFont( "shot_tranq", "HL2MPTypeDeath", "1", Color( 100, 100, 100, 255 ) )
	killicon.AddFont("weapon_tranqgun","CSKillIcons","C",Color(100,200,100,255))
end


SWEP.Base				= "ls_snip_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_crossbow.mdl"
SWEP.WorldModel			= "models/weapons/w_crossbow.mdl"

SWEP.Weight				= 4
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_Crossbow.Single" )
SWEP.Primary.Recoil			= 10
SWEP.Primary.Damage			= 70
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 0, 0, -20 )
SWEP.IronSightsAng 		= Vector( 2.8, 0, 0 )

// upgraded tranq gun = poison darts

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if ( !self:CanPrimaryAttack() ) then return end

	self.Weapon:EmitSound( self.Primary.Sound )
	if (SERVER) then
		self:FireRocket( self.Primary.Recoil )
	end
	self:TakePrimaryAmmo( 1 )
	
	if ( self.Owner:IsNPC() ) then return end

	self.Owner:ViewPunch( Angle( math.Rand(-0.2,0.2) * self.Primary.Recoil, math.Rand(-0.2,0.2) *self.Primary.Recoil, 0 ) )
	if ( (SinglePlayer() && SERVER) || CLIENT ) then
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
	end
	if (self:Clip1()<=0) then
		self:DefaultReload( ACT_VM_RELOAD )
	end
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:FireRocket( recoil )

	local object = ents.Create("shot_tranq")
	// grenade_ar2
	if object:IsValid() then	
		
		object:SetOwner(self.Owner)
		object:SetPos(self.Owner:GetShootPos()+self.Owner:EyeAngles():Right()*5+self.Owner:EyeAngles():Up()*-5)
		object:SetAngles(self.Owner:EyeAngles()+Angle(90,0,-90))
		if (self.Weapon:GetNWBool("upgraded")==true) then
			object:Poisonous()
			object:SetNWBool("upgraded", true)
		end
		object:Spawn()
		// object:SetVelocity(self.Owner:GetAimVector()*50000)
	end
	self.Owner:EmitSound("Weapon_Crossbow.BoltFly")
	self.Owner:EmitSound("Weapon_Crossbow.Reload")
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 		// View model animation
	// self.Owner:MuzzleFlash()								// Crappy muzzle light
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
	if ( (SinglePlayer() && SERVER) || ( !SinglePlayer() && CLIENT ) ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil
		self.Owner:SetEyeAngles( eyeang )
	
	end

end

/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------*/
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	draw.SimpleText( self.IconLetter, "HL2SelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
	
	if (self.Weapon:GetNWBool("upgraded")) then
		draw.SimpleText("K", "CSKillIcons", x + wide-20, y + tall-25, Color(200,200, 200, 255), TEXT_ALIGN_CENTER )
	end
end

function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
	if( self.Owner:GetNetworkedInt( "ScopeLevel" ) == nil ) then
		self.Owner:SetNetworkedInt( "ScopeLevel", 0 )
	end
	
	if(self.Owner:GetNetworkedInt( "ScopeLevel" ) == 0) then
	
		if(SERVER) then
			self.Owner:SetFOV(70, 0 )
		end	
		
		self.Owner:SetNetworkedInt( "ScopeLevel", 1 )
		self:SetIronsights( true )
		
	else if(self.Owner:GetNetworkedInt( "ScopeLevel" ) == 1) then
	
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
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

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:Upgrade(bool)
	self.Weapon:SetNWBool("upgraded",bool)
end