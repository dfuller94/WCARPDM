
 if( SERVER ) then

	AddCSLuaFile( "shared.lua" );
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end


 

SWEP.PrintName      = "Medic Kit"   
SWEP.Author   = "Jake Johnson"
SWEP.Slot         = 5;
SWEP.SlotPos            = 7;
SWEP.Description        = "Heals the wounded and cures poison"
SWEP.Contact            = ""
SWEP.Purpose            = ""
SWEP.Instructions      = "Left Click to heal player in front of user."

 
SWEP.Spawnable      = true --  Change to false to make Admin only.
SWEP.AdminSpawnable  = true
 
SWEP.ViewModel      = "models/weapons/v_c4.mdl"
SWEP.WorldModel   = "models/weapons/w_c4.mdl"
 
SWEP.Primary.Recoil  = 0
SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic    = false
SWEP.Primary.Delay    = 2
SWEP.Primary.Ammo      = "none"
 
SWEP.Secondary.Recoil      = 0
SWEP.Secondary.ClipSize  = -1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Delay        = .5
SWEP.Secondary.Ammo  = "none"
 

util.PrecacheSound("HL1/fvox/medical_repaired.wav")
util.PrecacheSound("HL1/fvox/radiation_detected.wav")
util.PrecacheSound("HL1/fvox/automedic_on.wav")

function SWEP:PrimaryAttack()
 
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
 
	trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = trace.start + (self.Owner:GetAimVector() * 105)
		trace.filter = { self.Owner, self.Weapon }
	tr = util.TraceLine( trace )
 
	if (tr.HitNonWorld) then
		local enthit = tr.Entity

		if enthit:IsPlayer() then
			enthit:SetHealth( enthit:GetMaxHealth() );
			self.Owner:PrintMessage( HUD_PRINTTALK, "*Medic Kit* Healing Player." );
			if enthit:GetNWBool("poisoned") then
				UnPoison(enthit)
				self.Owner:PrintMessage( HUD_PRINTTALK, "*Medic Kit* Antidote given to player." );
			end
		end
	end
end 
	 

function SWEP:SecondaryAttack()
end

function SWEP:ShouldDropOnDie()
	return true
end

