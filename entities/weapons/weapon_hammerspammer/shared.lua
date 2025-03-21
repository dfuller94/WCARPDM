

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Hammer Spammer"			
	SWEP.Author				= "HLTV Proxy"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 5
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= false
	SWEP.IconLetter			= "i"
	
	surface.CreateFont( "HalfLife2", ScreenScale( 60 ), 500, true, true, "HL2SelectIcons" )
	killicon.AddFont( "shot_rocket", "HL2MPTypeDeath", "3", Color( 100, 100, 100, 255 ) )
end


SWEP.Base				= "weapon_cs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_RPG.Single" )
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 70
SWEP.Primary.NumShots		= 5
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 50
SWEP.Primary.Delay			= 0.5
SWEP.Primary.DefaultClip	= 1000
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG_Round"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 6.1, -14, 2.5 )
SWEP.IronSightsAng 		= Vector( 2.8, 0, 0 )

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
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	// self.Owner:GiveAmmo(100, "RPG_Round")
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:FireRocket( recoil )

	local object = ents.Create("shot_bhammer")
	// grenade_ar2
	if ValidEntity(object) then	
		
		object:SetOwner(self.Owner)
		object:SetPos(self.Owner:GetPos()+self.Owner:GetAngles():Right()*40+Vector(0,0,65))
		//object:SetAngles(Angle(0,40,0))
		object:SetVelocity(self.Owner:GetAimVector()*400)
		object:Spawn()
		if (self.Weapon:GetNWBool("upgraded") && SERVER) then
			object:Upgrade()
			object:SetNWBool("upgraded", true)
		end
	end
	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 		// View model animation
	self.Owner:MuzzleFlash()								// Crappy muzzle light
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
	
	draw.SimpleText( self.IconLetter, "HL2SelectIcons", x + wide/2, (y + tall*0.2)-10, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
	if (self.Weapon:GetNWBool("upgraded")) then
		draw.SimpleText("K", "CSKillIcons", x + wide-20, y + tall-25, Color(200,200, 200, 255), TEXT_ALIGN_CENTER )
	end
end

function SWEP:Upgrade(bool)
	self.Weapon:SetNWBool("upgraded",bool)
end

function SWEP:ShouldDropOnDie()
	return true
end