// this was rickster's ak47.

if ( SERVER ) then
	AddCSLuaFile( "cl_init.lua" )
	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Plasma Gun"			
	SWEP.Author				= "HLTV Proxy"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 13
	SWEP.IconLetter			= ","
	SWEP.ViewModelFlip		= false

	killicon.AddFont( "shot_energy", "HL2MPTypeDeath", SWEP.IconLetter, Color( 100, 100, 100, 255 ) )
	
end


SWEP.Base				= "weapon_cs_base2"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_irifle.mdl"
SWEP.WorldModel			= "models/weapons/w_irifle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_AR2.Double" )
SWEP.Primary.Recoil			= 0.00000000001
SWEP.Primary.Damage			= 2
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0001
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay			= 0.25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Battery		= 100
SWEP.Primary.Chargerate		= .25
SWEP.Primary.Mode		= 1

SWEP.Secondary.Sound			= Sound( "Weapon_AR2.Double" )
SWEP.Secondary.Recoil			= 1
SWEP.Secondary.Damage			= 40
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0.0001
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.Delay			= 1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.Ammo			= "none"


SWEP.IronSightsPos 		= Vector( -2.7, -8, 2.225 )
SWEP.IronSightsAng 		= Vector( 0, -4, 0 )

// laser upgrade = more charge

function SWEP:Upgrade(bool)
	self.Weapon:SetNWBool("upgraded",bool)
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self:SetIronsights( false )
	self.Owner:SetFOV(90,.3)
end

function SWEP:Think()
	if self.LastCharge<CurTime()-self.Primary.Chargerate && self.Primary.Battery<100 then
		self.Primary.Battery=self.Primary.Battery+2
		if self.Primary.Battery>100 then self.Primary.Battery=100 end
		self.LastCharge = CurTime()
	end
end

function SWEP:PrimaryAttack()

	local delay = self.Primary.Delay
	self.Weapon:SetNextSecondaryFire( CurTime() + delay )
	self.Weapon:SetNextPrimaryFire( CurTime() + delay )
	
	self.LastCharge = CurTime()+delay*1.5
	if ( self.Primary.Battery<5) then 
		return 
	end
	self.Primary.Battery=self.Primary.Battery-5
	// Play shoot sound
	self.Weapon:EmitSound( self.Primary.Sound )
	if SERVER then
		self.Weapon:FireShot()
	end
	// Punch the player's view

	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	
	
	// In singleplayer this doesn't get called on the client, so we use a networked float
	// to send the last shoot time. In multiplayer this is predicted clientside so we don't need to 
	// send the float.
	if ( (SinglePlayer() && SERVER) || CLIENT ) then
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
	end
	
end

function SWEP:Initialize()

	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	
	self.Weapon:SetNetworkedBool( "Ironsights", false )
	self.LastCharge = CurTime()
	self.Halfcharge = false
end

function SWEP:FireShot( recoil )

	local object = ents.Create("shot_energy")
	if ValidEntity(object) then
		object:SetOwner(self.Owner)
		object:SetPos(self.Owner:GetShootPos()+self.Owner:EyeAngles():Right()*5)
		object:SetAngles(self.Owner:EyeAngles())
		object:SetVelocity(self.Owner:GetAimVector()*1000)
		object:Spawn()
		if SERVER then
			if self.Weapon:GetNWBool("upgraded") then
				object:Upgrade()
				object:SetNWBool("upgraded", true)
			end
			object:SetColor(tonumber(self.Owner:GetInfo("rpdm_clcolor_r")),tonumber(self.Owner:GetInfo("rpdm_clcolor_g")),tonumber(self.Owner:GetInfo("rpdm_clcolor_b")),255)
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

function SWEP:GetViewModelPosition( pos, ang )
	local Mul = 1.0
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

function SWEP:SecondaryAttack()
end