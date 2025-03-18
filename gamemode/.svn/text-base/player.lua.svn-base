
/*
CivModels = {

"models/player/gman_high.mdl",
"models/player/breen.mdl",
"models/player/monk.mdl",
"models/player/odessa.mdl",
"models/player/barney.mdl",
"models/player/alyx.mdl",
"models/player/kleiner.mdl",
"models/player/mossman.mdl"

}


HitManModels = {

"models/player/gman_high.mdl",
"models/player/breen.mdl",
"models/player/monk.mdl",
"models/player/odessa.mdl",
"models/player/barney.mdl",
"models/player/alyx.mdl",
"models/player/kleiner.mdl",
"models/player/mossman.mdl",
"models/player/eli.mdl",
"models/player/police.mdl",
"models/player/combine_soldier.mdl"

}
*/

function GM:PlayerSetModel( ply )
	if CfgVars["enforceplayermodel"]==1 then
		local team = ply:Team()
		local validmodel = false;
		local selectedmodel = player_manager.TranslatePlayerModel(ply:GetInfo("cl_playermodel"))
		if selectedmodel!=ply:GetTable().PlayerModel then
			for k, v in pairs( plmodels[team] ) do
				if( player_manager.TranslatePlayerModel(v) == selectedmodel ) then
					ply:GetTable().PlayerModel = selectedmodel;
					validmodel = true
					ply:SetModel( ply:GetTable().PlayerModel );
					break
				end
			end
		end
		for k, v in pairs( plmodels[team] ) do
			if( ply:GetTable().PlayerModel == player_manager.TranslatePlayerModel(v) ) then
				validmodel = true
				break
			end
		end
		if( !validmodel ) then
			ply:GetTable().PlayerModel = nil;
		end
		local model = ply:GetModel();	
		if( model ~= ply:GetTable().PlayerModel ) then
			for k, v in pairs( plmodels[team] ) do
				if( player_manager.TranslatePlayerModel(v) == model ) then
					ply:GetTable().PlayerModel = model;
					validmodel = true
					break
				end
			end
			if( !validmodel and !ply:GetTable().PlayerModel ) then
				local newmodel = plmodels[team][math.random( 1, #plmodels[team] )]
				ply:GetTable().PlayerModel = player_manager.TranslatePlayerModel(newmodel)
			end
			ply:SetModel( ply:GetTable().PlayerModel );
		end
	else
		local selectedmodel = player_manager.TranslatePlayerModel(ply:GetInfo("cl_playermodel"))
		ply:GetTable().PlayerModel = selectedmodel;
		ply:SetModel( ply:GetTable().PlayerModel );
	end
end

local meta = FindMetaTable( "Player" );

function meta:NewData()

	local function ModuleDelay( ply )
	
		umsg.Start( "LoadModules", ply ); 
			umsg.Short( #CSFiles );
			for n = 1, #CSFiles do
				umsg.String( CSFiles[n] );
			end
		umsg.End();
		
	end
	
	timer.Simple( .01, ModuleDelay, self );

	self:SetNWString( "job", "Citizen" );
	self:UpdateJob("Citizen")
	self.NPCs = {}
	timer.Create( self:SteamID() .. "NPCController", .5, 0, self.NPCControl, self );
	// normally starting money is 1000, but since noone can ever do anything out of just 1000, we give 5000, which is enough for a full base setup including a shipment of guns and some stills/labs
	self:GetTable().Money = 5000
	
	self:GetTable().Pay = 1;
	self:GetTable().LastPayDay = CurTime();
	
	self:GetTable().Owned = { }
	self:GetTable().OwnedNum = 0;
	
	self:GetTable().LastLetterMade = CurTime();
	self:GetTable().LastVoteCop = CurTime();
	
	self:SetTeam( 1 );
	
	if( self:IsSuperAdmin() or self:IsAdmin() ) then
	
		Admins[self:SteamID()] = { }
	
	end
	
end

function meta:IsAllied(ply)
	if tonumber(self:GetInfo("rpdm_ally_pl"..ply:EntIndex()))==1 then
		return true
	else
		return false
	end
end

function meta:NPCControl()
	for k,v in pairs(self.NPCs) do
		if ValidEntity(v) then
			if !v:HasCondition(COND_SEE_HATE) && !v:HasCondition(COND_SEE_ENEMY) then
				v:SetNPCState(1)
			end
			if (v:GetNPCState()!=3 || self.Entity:GetPos():Distance(v:GetPos())>1024) && self.Entity:GetPos():Distance(v:GetPos())>256 then
				local newpos = v:GetPos() + ((self.Entity:GetPos()-v:GetPos()):Normalize()*256)
				v:SetLastPosition(newpos)
				v:SetArrivalSpeed(1024)
				v:SetSchedule(SCHED_FORCED_GO_RUN)
				//v:SetNPCState(1)
			end
		end
	end
end

function meta:UpgradeGun( gun, bool)
	local weapon = self:GetWeapon(gun)
	if !ValidEntity(weapon) then return end
	weapon:Upgrade(bool)
end

function meta:CanAfford( amount ) 

	if( amount < 0 ) then return false; end

	if( self:GetTable().Money - amount < 0 ) then
		return false;
	end
	
	return true;

end

function meta:AddMoney( amount )

	local oldamount = self:GetTable().Money
	
	if (self:GetNWBool("AFK") && amount>0) then
		amount = -amount
		Notify(self,1,3,"You are AFK!, you just lost $" .. -amount .. "!!!")
	end
	self:GetTable().Money = oldamount + amount
	setMoney(self, amount);
	local plmoney = self:GetTable().Money
	// if its more than a long, just basically say A LOT
	if (self:GetTable().Money>2147483647) then
		plmoney = 2147483647
	end
	umsg.Start("MoneyChange", self)
		umsg.Short(amount)
		umsg.Long(plmoney)
	umsg.End()
end

function meta:PayDay()

	if( self:GetTable().Pay == 1 ) then
	
		local amount = 0;
	
		if( self:Team() == 1 ) then
			amount = math.random( 60, 95 );
		elseif (self:Team() == 2 || self:Team() == 9 || self:Team() == 10) then
			amount = math.random( 90, 135 );
		elseif self:Team()==3 then
			local cops = 0
			for k,v in pairs(player.GetAll()) do
				if v:Team() == 2 || v:Team() == 9 || v:Team() == 10 then
					cops=cops+1
				end
			end
			amount = math.random(65,100) + cops*10
		elseif self:Team()==5 then
			local mob = 0
			for k,v in pairs(player.GetAll()) do
				if v:Team() == 4 || v:Team() == 11 then
					mob=mob+1
				end
			end
			amount = math.random(65,95) + mob*5
		else
			amount = math.random( 65, 100 );
		end
		// since people are basically fucked when they have no money, help them out a little.
		if !self:CanAfford(20000) then
			amount = amount + math.random(10,25)
		end
		if !self:CanAfford(10000) then
			amount = amount + math.random(30,45)
		end
		if !self:CanAfford(5000) then
			amount = amount + math.random(20,35)
		end
		// if they are FLAT broke, help them more.
		if !self:CanAfford(500) then
			amount = amount + math.random(50,75)
		end
		self:AddMoney( amount );
		Notify( self, 2, 4, "Payday! You got " .. amount .. " dollars!" );
	
	end

end



function meta:UpdateJob( job )

	self:SetNWString( "job", job );

	if( string.lower( job ) != "mingebag") then
		
		self:GetTable().Pay = 1;
		self:GetTable().LastPayDay = CurTime();
		
		timer.Create( self:SteamID() .. "jobtimer", CfgVars["paydelay"], 0, self.PayDay, self );
		
	else
	
		timer.Destroy( self:SteamID() .. "jobtimer" );
	
	end

end

function meta:CheckOverdose()
	local drugnum = 0
	if(!self:GetNWBool("superdrug")) then
		if (self:GetNWBool("regened")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("roided")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("amped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("painkillered")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("mirrored")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("antidoted")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("focused")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("magicbulleted")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("shockwaved")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("leeched")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("doubletapped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("doublejumped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("adrenalined")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("knockbacked")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("armorpiercered")==true) then
			drugnum = drugnum+1
		end
		if (drugnum>=8 && math.random(1,10)>2) then
			self:TakeDamage(150,self)
			PoisonPlayer(self, 50, self, self)
			Notify(self, 1, 3, "You have overdosed!")
		elseif (drugnum>=6 && math.random(1,10)>4) then
			self:SetNWBool("shielded", false)
			self.Shielded = false
			self:TakeDamage(90,self)
			PoisonPlayer(self, 40, self, self)
			Notify(self, 1, 3, "You have overdosed!")
		elseif drugnum==5 && math.random(1,10)>7 then
			PoisonPlayer(self, 40, self, self)
			self:TakeDamage(60, self)
			Notify(self, 1, 3, "You are overdosing!")
		elseif drugnum==4 && math.random(1,10)>9 then
			PoisonPlayer(self, 30, self, self)
			self:TakeDamage(30, self)
			Notify(self, 1, 3, "You are overdosing!")
		end
	end
end

function meta:Arrest()
	if(self:GetNetworkedBool("warrant") == true) then
		self:SetNetworkedBool("warrant", false)
	end
	self:StripWeapons();
	self:GetTable().Arrested = true;
	if jailpos!=nil then
		self:SetPos(Vector(tonumber(jailpos[1]),tonumber(jailpos[2]),tonumber(jailpos[3]))) 
	end
	self:PrintMessage( HUD_PRINTCENTER, "You have been arrested for " .. CfgVars["jailtimer"] .. " seconds!" )  
	timer.Create( self:SteamID() .. "jailtimer", CfgVars["jailtimer"], 1, self.Jailed, self);

end

function meta:Unarrest()

	self:GetTable().Arrested = false;
	
	GAMEMODE:PlayerLoadout( self );
	timer.Stop(self:SteamID() .. "jailtimer")  
	timer.Destroy(self:SteamID() .. "jailtimer")  
	
end

function meta:Jailed()
	self:ExitVehicle()
	self:KillSilent( )
	self:Unarrest( )
end

function meta:UnownAllShit()

	for k, v in pairs( self:GetTable().Owned ) do
		
		v:UnOwn( self );
		self:GetTable().Owned[v:EntIndex()] = nil;
		
	end
	
	for k, v in pairs( player.GetAll() ) do
	
		for n, m in pairs( v:GetTable().Owned ) do
		
			if( m:AllowedToOwn( self ) ) then
				m:RemoveAllowed( self );
			end
		
		end
	
	end
	
	self:GetTable().OwnedNum = 0;

end

function meta:DoPropertyTax()

	if( CfgVars["propertytax"] == 0 ) then return; end
	if( ( self:Team() == 2 or self:Team() == 3 ) and CfgVars["cit_propertytax"] == 1 ) then return; end

	local numowned = self:GetTable().OwnedNum;
	//if( numowned <= 0 ) then return; end
	
	local price = 2;

	local stuff = self:GetCount("props")+self:GetCount("magnets")+self:GetCount("wheels")+self:GetCount("thrusters")+self:GetCount("hoverballs")+self:GetCount("buttons")+self:GetCount("baloons")+self:GetCount("spawners")+(self:GetCount("lamps")*3)+(self:GetCount("lights")*3)
	local tax = (price * numowned * numowned)+stuff
	if tax>384 then tax=384 end
	if tax==0 then return end
	if( self:CanAfford( tax ) ) then

		self:AddMoney( -tax );
		Notify( self, 0, 5, "Property tax! $" .. tax .. " added to lottery jackpot.");
		Jackpot=Jackpot+tax
		
	else

		Notify( self, 1, 8, "Can't pay the taxes! Your property has been taken away from you!" );
		self:UnownAllShit();
	
	end

end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	/*
	if (ValidEntity(ply:GetActiveWeapon())) then
		local class = ply:GetActiveWeapon():GetClass()
		if (class!="weapon_molotov" && class!="weapon_gasgrenade" && class!="cse_eq_flashbang" && class!="cse_eq_hegrenade" && class!="weapon_pipebomb" && class!="weapon_physgun" && class!="weapon_physcannon" && class!="gmod_tool" && class!="gmod_camera" && class!="keys" && class!="weapon_firestorm" && class!="weapon_welder" && class!="welder" && class!="arrest_stick" && class!="weapon_lightninggun" && class!="weapon_icegun") then
			local gun = ents.Create("spawned_weapon")
			gun:SetModel(ply:GetActiveWeapon():GetTable().WorldModel)
			gun:SetNWString("weaponclass", class)
			gun:SetPos(ply:GetPos()+Vector(0,0,30))
			gun:Spawn()
			ply:GetActiveWeapon():Remove()
		end
	end
	*/
	ply:CreateRagdoll()
	
	ply:AddDeaths( 1 )
	
	if ( attacker:IsValid() && attacker:IsPlayer() ) then
	
		if ( attacker == ply ) then
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )
		end
		
	end
	
end

function UpdateDrugs(ply)
	ply:GetTable().Roided = false
	ply:GetTable().Regened = false
	ply:GetTable().Shielded = false
	ply:GetTable().Tooled = false
	ply:GetTable().Focus = false
	ply:GetTable().Mirror = false
	ply:GetTable().Antidoted = false
	ply:GetTable().Poisoned = false
	ply:GetTable().Shielded = false
	ply:GetTable().Shieldon = false
	ply:GetTable().Stunned = false
	ply:GetTable().StunDuration = 0
	ply:GetTable().PoisonDuration = 0
	ply:GetTable().BurnDuration = 0
	ply:GetTable().Amp = false
	ply:GetTable().PainKillered = false
	ply:GetTable().MagicBulleted = false
	ply:GetTable().Adrenalined = false
	ply:GetTable().DoubleJumped = false
	ply:GetTable().ShockWaved = false
	ply:GetTable().DoubleTapped = false
	ply:GetTable().Leeched = false
	ply:GetTable().Knockbacked = false
	ply:GetTable().ArmorPiercered = false
	ply:GetTable().Superdrugoffense = false
	ply:GetTable().Superdrugdefense = false
	ply:GetTable().Superdrugweapmod = false
	ply:GetTable().Burned = false
	
	ply:SetNWBool("shielded", false)
	ply:SetNWBool("tooled", false)
	ply:SetNWBool("scannered", false)
	ply:SetNWBool("helmeted", false)
	ply:SetNWBool("roided", false)
	ply:SetNWBool("regened", false)
	ply:SetNWBool("amped", false)
	ply:SetNWBool("painkillered", false)
	ply:SetNWBool("magicbulleted", false)
	ply:SetNWBool("poisoned", false)
	ply:SetNWBool("focused", false)
	ply:SetNWBool("antidoted", false)
	ply:SetNWBool("mirrored", false)
	ply:SetNWBool("shockwaved", false)
	ply:SetNWBool("doubletapped", false)
	ply:SetNWBool("leeched", false)
	ply:SetNWBool("adrenalined", false)
	ply:SetNWBool("doublejumped", false)
	ply:SetNWBool("knockbacked", false)
	ply:SetNWBool("armorpiercered", false)
	ply:SetNWBool("burned", false)
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	timer.Destroy(IDSteam .. "ROID")
	timer.Destroy(IDSteam .. "REGEN")
	timer.Destroy(IDSteam .. "REGENTICK")
	timer.Destroy(IDSteam .. "AMP")
	timer.Destroy(IDSteam .. "PAINKILLER")
	timer.Destroy(IDSteam .. "MAGICBULLET")
	timer.Destroy(IDSteam .. "STUN")
	timer.Destroy(IDSteam .. "REFLECT")
	timer.Destroy(IDSteam .. "POISON")
	timer.Destroy(IDSteam .. "POISONTICK")
	timer.Destroy(IDSteam .. "BURN")
	timer.Destroy(IDSteam .. "ANTIDOTE")
	timer.Destroy(IDSteam .. "FOCUS")
	timer.Destroy(IDSteam .. "DOUBLETAP")
	timer.Destroy(IDSteam .. "LEECH")
	timer.Destroy(IDSteam .. "SHOCKWAVE")
	timer.Destroy(IDSteam .. "DOUBLEJUMP")
	timer.Destroy(IDSteam .. "ADRENALINE")
	timer.Destroy(IDSteam .. "KNOCKBACK")
	timer.Destroy(IDSteam .. "ARMORPIERCER")
	timer.Destroy(IDSteam .. "SUPERDRUGOFFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGDEFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGWEAPMOD")
end

function GM:PlayerDeath( ply, weapon, killer )
	ply:Ignite(0.001,0)
	ply:Extinguish()
	UpdateDrugs(ply)
	ply:ConCommand("pp_motionblur 0")
	ply:ConCommand("pp_dof 0")
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	
	//self.BaseClass:PlayerDeath( ply, weapon, killer );
	self:PlayerDeathNotify(ply,weapon,killer)
	
	ply:GetTable().DeathPos = ply:GetPos();
	
	if(ply ~= killer && killer:IsValid()) then
		local winrar = killer
		// in case of a backstab kill, credit the guy holding the knife.
		if (killer:IsWeapon()) then
			winrar = killer:GetOwner()
		end
		if (winrar:IsPlayer() && ply ~= winrar) then
			if (winrar:Team()==4 || winrar:Team()==5 || winrar:Team()==11) then
				if (ply:GetNWInt("hitlist")>0) then
					local hitcash = ply:GetNWInt("hitlist")
					local payout = math.random(5,15)+math.ceil(hitcash/math.random(10,20))
					if killer~=winrar then payout = math.ceil(payout*1.5) end
					if payout>hitcash then payout = hitcash end
					winrar:AddMoney(payout)
					ply:SetNWInt("hitlist", hitcash-payout)
					Notify(ply, 0, 3, "Mob hit!")
					Notify(winrar, 2, 3, "Paid $" .. payout .. " for mob hit")
				end
			end
		end
	end
	if( ply ~= killer or ply:GetTable().Slayed ) then
	
		ply:Unarrest()
		ply:GetTable().DeathPos = nil;
	
		ply:GetTable().Slayed = false;
		if(ply:GetNWBool("warrant")) then
			ply:SetNWBool("warrant", false)
		end
	end
	for k, v in pairs(ply:GetWeapons()) do
		local class = v:GetClass()
		if (class!="weapon_molotov" && class!="weapon_gasgrenade" && class!="cse_eq_flashbang" && class!="cse_eq_hegrenade" && class!="weapon_pipebomb" && class!="weapon_physgun" && class!="weapon_physcannon" && class!="gmod_tool" && class!="gmod_camera" && class!="keys" && class!="weapon_firestorm" && class!="weapon_welder" && class!="welder" && class!="arrest_stick" && class!="weapon_lightninggun" && class!="weapon_icegun") then
			local gun = ents.Create("spawned_weapon")
			gun:SetModel(v:GetTable().WorldModel)
			gun:SetNWString("weaponclass", class)
			gun:SetPos(ply:GetPos()+Vector(math.random(-10,10),math.random(-10,10),math.random(10,40)))
			gun:SetUpgraded(v:GetNWBool("upgraded"))
			gun:Spawn()
			v:Remove()
		end
	end

	
end


function GM:PlayerCanPickupWeapon( ply, wep )

	if( ply:GetTable().Arrested) then return false; end
	if wep:GetClass()=="weapon_worldslayer" && ValidEntity(ply:GetWeapon("weapon_worldslayer")) then return false end

	return true;

end


function GM:PlayerSpawn( ply )
	ply:Extinguish()
	GAMEMODE:PlayerSetModel(ply)
	UpdateDrugs(ply)
	if( ply:Team() == 8 ) then
   		ply:SetMaxHealth(110)
		ply:SetHealth(110)
	end
	ply:GetTable().Jump2 = false
	
	ply:ConCommand("pp_motionblur 0")
	ply:ConCommand("pp_dof 0")
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	
	ply:GetTable().Headshot = false
	//self.BaseClass:PlayerSpawn( ply );
	ply:UnSpectate()
	ply:StripWeapons()
	ply:RemoveAllAmmo()
	GAMEMODE:PlayerLoadout( ply )
	
	ply:CrosshairEnable();
	
	if( CfgVars["crosshair"] == 0 ) then
	
		ply:CrosshairDisable();
	
	end
	
	if( CfgVars["strictsuicide"] == 1 and ply:GetTable().DeathPos ) then
	
		ply:SetPos( ply:GetTable().DeathPos );
	
	end
	 
	if( ply:GetTable().Arrested ) then
	
		ply:SetPos( ply:GetTable().DeathPos );
		ply:Arrest();
	
	end
	
	if ( not ply:GetTable().Arrested and  ValidEntity(ply:GetTable().Spawnpoint ) and ( ply:GetTable().maxspawn > 0 ) ) and ( CfgVars["allowspawn"] == 1 ) then 
    		local cspawnpos = ply:GetTable().Spawnpoint:GetPos()
		local trace = { }
    			trace.start = cspawnpos+Vector(0,0,2)
			trace.endpos = trace.start+Vector(0,0,16)
			trace.filter = ply:GetTable().Spawnpoint
		trace = util.TraceLine(trace)
		if ValidEntity(trace.Entity) then
			local minge = player.GetByUniqueID(trace.Entity:GetVar("PropProtection"))
			if ValidEntity(minge) then
				if ply==minge then
					ply:SetTeam( 1 );
					ply:UpdateJob( "MingeBag" );
					ply:Arrest()
					ply:GetTable().Spawnpoint:Remove()
					Notify(ply,1,10,"You tried to protect your spawnpoint with a prop. The server does not like you.")
					trace.Entity:Remove()
				else
					if (tobool(trace.Entity:GetVar("PropProtection"))) then
						trace.Entity:Remove()
					end
					ply:SetPos(cspawnpos+Vector(0,0,16))
				end
			else
				if (trace.Entity:GetClass()=="prop_ragdoll" || trace.Entity:GetClass()=="prop_physics_multiplayer" || trace.Entity:GetClass()=="prop_physics_respawnable" || trace.Entity:GetClass()=="prop_physics" || trace.Entity:GetClass()=="phys_magnet" || trace.Entity:GetClass()=="gmod_spawner" || trace.Entity:GetClass()=="gmod_wheel" || trace.Entity:GetClass()=="gmod_thruster" || trace.Entity:GetClass()=="gmod_button") then
					trace.Entity:Remove()
				end
				ply:SetPos(cspawnpos+Vector(0,0,16))
			end
		else
			ply:SetPos(cspawnpos+Vector(0,0,16))
		end
    	end

end


function GM:PlayerLoadout( ply )

	if( ply:GetTable().Arrested ) then return; end

	local team = ply:Team();

	ply:Give( "keys" );
	ply:Give( "weapon_physcannon" );
	ply:Give( "gmod_camera" );
	
	if( CfgVars["toolgun"] == 1 or Admins[ply:SteamID()] or Tool[ply:SteamID()] ) then
	
		ply:Give( "gmod_tool" );

	end
	
	if( CfgVars["physgun"] == 1 or Admins[ply:SteamID()] or Phys[ply:SteamID()] ) then

		ply:Give( "weapon_physgun" );

	end
	--Citizen
	if (team==1) then
		ply:Give("weapon_p2282")
		ply:GiveAmmo(12, "Pistol")
	--Cop
	elseif( team == 2 ) then
	
		ply:Give( "weapon_glock2" );
		ply:UpgradeGun("weapon_glock2", true)
		
		ply:Give( "door_ram" );
		ply:Give( "stunstick" );
		
		ply:GiveAmmo( 60, "Pistol" );
	--Mayor
	elseif( team == 3 ) then
	
		ply:Give( "weapon_deagle2" );
		ply:UpgradeGun("weapon_deagle2", true)
		ply:Give( "weapon_tmp2" );
		ply:UpgradeGun("weapon_tmp2", true)
		ply:GiveAmmo( 60, "Pistol" );
		ply:SetArmor(30)
	--Gangster	
	elseif( team == 4 ) then
		ply:Give("weapon_p2282")
		ply:GiveAmmo( 24, "Pistol" );
		ply:SetArmor(10)
	--Mob Boss
	elseif( team == 5 ) then

		ply:Give( "lockpick" );
		//ply:Give( "unarrest_stick" );
		ply:Give( "weapon_usp2" );
		ply:Give( "weapon_mac102" );
		ply:UpgradeGun("weapon_usp2", true)
		ply:UpgradeGun("weapon_mac102", true)
		ply:GiveAmmo( 50, "Pistol" );
		ply:SetArmor(20)
	--Gun Dealer
	elseif( team == 6 ) then
		ply:Give("weapon_p2282")
		ply:UpgradeGun("weapon_p2282", true)
		ply:GiveAmmo( 32, "Pistol" );
		
	--Medic
    	elseif( team == 7 ) then
   		ply:Give("weapon_p2282")
		ply:UpgradeGun("weapon_p2282", true)
		ply:GiveAmmo( 16, "Pistol" );
       		ply:Give( "med_kit" );

	--Cook
    	elseif( team == 8 ) then
   		ply:Give("weapon_p2282")
		ply:UpgradeGun("weapon_p2282", true)
		ply:GiveAmmo( 32, "Pistol" );
		//ply:SetMaxHealth(110)
		//ply:SetHealth(110)
	--OverWatch
    	elseif (team == 9 ) then
		ply:GiveAmmo( 100, "Pistol" );
		ply:Give( "weapon_tmp2")
		ply:Give( "weapon_glock2")
		ply:Give( "door_ram")
		ply:Give( "stunstick" );
		//ply:Give( "arrest_stick" );
		ply:UpgradeGun("weapon_glock2", true)
		//ply:UpgradeGun("weapon_mac102", true)
	--Spec Ops
   	 elseif (team == 10 ) then
		ply:GiveAmmo( 65, "Pistol" );
		ply:GiveAmmo( 105, "smg1" )
		ply:Give( "weapon_usp2")
		ply:Give( "weapon_ump452")
		ply:Give( "door_ram")
		ply:Give( "weapon_knife2" );
		ply:Give( "stunstick" );
		ply:UpgradeGun("weapon_usp2", true)
		//ply:UpgradeGun("weapon_ump452", true)
		ply:UpgradeGun("weapon_knife2", true)
	-- Hit Man
    	elseif (team == 11 ) then
		ply:GiveAmmo( 65, "Pistol" );
		ply:Give("weapon_knife2")
		ply:Give("weapon_mac102")
		ply:UpgradeGun("weapon_knife2", true)
		//ply:UpgradeGun("weapon_mac102", true)
		ply:SetArmor(20)
	-- Grenadier. team thats not really to be used unless everyone is bored and were just screwing around
    	elseif (team == 12 ) then
		ply:GiveAmmo( 70, "Pistol" )
		ply:GiveAmmo( 80, "smg1" )
		
		ply:Give( "weapon_deagle2")
		ply:Give( "weapon_m42")
		ply:Give( "weapon_knife2")
		ply:UpgradeGun("weapon_deagle2", true)
		ply:Give( "cse_eq_hegrenade" )
		ply:GiveAmmo(3,"grenade")
		ply:Give( "cse_eq_flashbang" )
		ply:Give( "weapon_gasgrenade" )
		ply:UpgradeGun("weapon_knife2", true)
		ply:SetArmor(50)
	--???. this team will NEVER be used and cannot be accessed by anyone except someone at console doing lua_run commands. its just here for no reason.
    	elseif (team == 13 ) then
		ply:GiveAmmo( 200, "Pistol" );
		ply:GiveAmmo( 200, "smg1" )
		ply:GiveAmmo( 200, "357" )
		ply:GiveAmmo( 25, "grenade" )
		ply:Give( "weapon_357")
		ply:Give( "weapon_50cal2")
		ply:Give( "weapon_welder")
		ply:Give( "weapon_knife2" );
		ply:Give( "cse_eq_hegrenade" )
		ply:UpgradeGun("weapon_50cal2", true)
		ply:UpgradeGun("weapon_knife2", true)
		ply:SetArmor(100)
    	end
end


function GM:PlayerInitialSpawn( ply )

	self.BaseClass:PlayerInitialSpawn( ply );
	
	ply:NewData();
	//NetworkHelpLabels( ply );
	ply:SetNetworkedBool("helpMenu",false)
	ply:SetNWBool("warrant",false)
	ply:SetNWBool("helpCop",false)
	ply:GetTable().LastBuy=CurTime()	
	ply:GetTable().maxDrug= 0
	ply:GetTable().maxMicrowaves=0
	ply:GetTable().maxgunlabs=0
	ply:GetTable().maxdrugfactory=0
	ply:GetTable().maxvault=0
	ply:GetTable().maxgenerator=0
	ply:GetTable().maxgunfactory=0
	ply:GetTable().maxweed=0
	ply:GetTable().maxturret=0
	ply:GetTable().maxdispensers= 0
	ply:GetTable().maxspawn= 0
	ply:GetTable().maxPrinter= 0
	ply:GetTable().maxmethlab= 0
	ply:GetTable().maxStill= 0
	ply:GetTable().maxgunfactory= 0
	ply:GetTable().maxtower = 0
	ply:GetTable().maxsign = 0
	
	ply:SetNetworkedBool("warrant", false)
	ply:SetNWBool("zombieToggle", false)
	ply:SetNWBool("helpZombie", false)
	ply:SetNWBool("helpBoss", false)
	ply:SetNWBool("helpMedic", false)
	ply:SetNWBool("helpAdmin", false)
	ply:SetNWBool("shitwelding", false)
	ply:GetTable().shitweldcount = 0
	ply:SetNWBool("AFK", false)
	getMoney(ply);
	
	ply:GetTable().StunDuration = 0
	ply:GetTable().tickets = { }
	
	timer.Create( ply:SteamID() .. "propertytax", 240, 0, ply.DoPropertyTax, ply )
	
	// well have this double as being hitlisted, and how much there is available
	ply:SetNWInt("hitlist", 0)
	ply:SetNWBool("helpExtracrap", false)
	ply:SetNWBool("helpHitman", false) 
	
	ply:PrintMessage( HUD_PRINTTALK, "This server is running WCA RPDM v1.1! (basewars)" ) 
	ply:PrintMessage( HUD_PRINTTALK, "This is not really an RP server! Much killing happens. Think of it as base wars." )
	ply:PrintMessage( HUD_PRINTTALK, "No, seriously. Don't bring your bullcrap about 'new life rule'. it does not apply to a combat gamemode." )
	ply:PrintMessage( HUD_PRINTTALK, "There can never be enough warnings here. Some people don't read any of this. THIS IS NOT RP, THIS IS BASE WARS." )
end

function GM:PlayerDisconnected( ply )

	self.BaseClass:PlayerDisconnected( ply );
	
	ply:UnownAllShit();
	
	timer.Destroy( ply:SteamID() .. "jobtimer" );
	timer.Destroy( ply:SteamID() .. "propertytax" );
	timer.Destroy(ply:SteamID().."NPCController")
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	timer.Destroy(IDSteam .. "ROID")
	timer.Destroy(IDSteam .. "REGEN")
	timer.Destroy(IDSteam .. "REGENTICK")
	timer.Destroy(IDSteam .. "AMP")
	timer.Destroy(IDSteam .. "PAINKILLER")
	timer.Destroy(IDSteam .. "MAGICBULLET")
	timer.Destroy(IDSteam .. "STUN")
	timer.Destroy(IDSteam .. "MIRROR")
	timer.Destroy(IDSteam .. "BURN")
	timer.Destroy(IDSteam .. "POISON")
	timer.Destroy(IDSteam .. "POISONTICK")
	timer.Destroy(IDSteam .. "ANTIDOTE")
	timer.Destroy(IDSteam .. "FOCUS")
	timer.Destroy(IDSteam .. "DOUBLETAP")
	timer.Destroy(IDSteam .. "LEECH")
	timer.Destroy(IDSteam .. "SHOCKWAVE")
	timer.Destroy(IDSteam .. "AFK")
	timer.Destroy(IDSteam .. "ADRENALINE")
	timer.Destroy(IDSteam .. "DOUBLEJUMP")
	timer.Destroy(IDSteam .. "KNOCKBACK")
	timer.Destroy(IDSteam .. "ARMORPIERCER")
	timer.Destroy(IDSteam .. "SUPERDRUGOFFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGDEFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGWEAPMOD")
	vote.DestroyVotesWithEnt( ply );
	for k, v in pairs(player.GetAll()) do
		if ValidEntity(v) then
			v:ConCommand("rpdm_ally_pl"..ply:EntIndex().." 0\n")
		end
	end
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	ply:GetTable().Headshot = false
	if (ply:Team()==1) then
		dmginfo:ScaleDamage( 0.9 )
	end
	if ( hitgroup == HITGROUP_HEAD ) then
		ply:GetTable().Headshot = true
	 	if ply:GetNWBool("helmeted") then
			if (ply:Team()==1) then
				dmginfo:ScaleDamage( 0.18 )
			else
				dmginfo:ScaleDamage( 0.2 )
			end
			local effectdata = EffectData()
				effectdata:SetOrigin( ply:GetPos()+Vector(0,0,60) )
				effectdata:SetMagnitude( 1 )
				effectdata:SetScale( 1 )
				effectdata:SetRadius( 2 )
			util.Effect( "Sparks", effectdata )
		else
			if (ply:Team()==1) then
				dmginfo:ScaleDamage( 1.5 )
			else
				dmginfo:ScaleDamage( 1.75 )
			end
	 	end
	 end
	 
	// Less damage if we're shot in the arms or legs, or if its a citizen
	if ( hitgroup == HITGROUP_LEFTARM ||
		 hitgroup == HITGROUP_RIGHTARM || 
		 hitgroup == HITGROUP_LEFTLEG ||
		 hitgroup == HITGROUP_LEFTLEG ||
		 hitgroup == HITGROUP_GEAR ) then
	 
		if (ply:Team()==1) then
			dmginfo:ScaleDamage( 0.45 )
		else
			dmginfo:ScaleDamage( 0.5 )
		end
	 
	 end

end


function meta:SetAFK()
	self:SetNWBool("AFK", true)
end

function meta:ClearAFK()
	if (self:GetNWBool("AFK")) then
		self:SetNWBool("AFK", false)
	end
	timer.Create( self:SteamID() .. "AFK", CfgVars["afktime"], 1, self.SetAFK, self);
end

// copypasta from base gamemode

function GM:PlayerDeathNotify( Victim, Inflictor, Attacker )
	if (Inflictor:GetClass()=="env_physexplosion" || Inflictor:GetClass()=="env_fire") && ValidEntity(Inflictor:GetTable().attacker) then
		Attacker = Inflictor:GetTable().attacker
	end
	// Don't spawn for at least 3 seconds
	if Inflictor==Victim && Attacker==Victim then
		Victim.NextSpawnTime = CurTime() + 5
	else
		Victim.NextSpawnTime = CurTime() + 3
	end

	// Convert the inflictor to the weapon that they're holding if we can.
	// This can be right or wrong with NPCs since combine can be holding a 
	// pistol but kill you by hitting you with their arm.
	// fuck all of this.
	
	if ( Inflictor && Inflictor == Attacker && ( Inflictor:IsNPC() || Inflictor:IsPlayer()) ) then
		local weap = Inflictor:GetActiveWeapon()
		if ValidEntity(weap) then
			local class=weap:GetClass()
			if class=="weapon_stunstick" || class=="weapon_crowbar" || class=="weapon_pistol" || class=="weapon_357" || class=="weapon_smg1" || class=="weapon_ar2" || class=="weapon_shotgun" then
				
				Inflictor = Inflictor:GetActiveWeapon()
				if ( !Inflictor || Inflictor == NULL ) then Inflictor = Attacker end
			end
		end
	
	end
	
	// send the inflictor class independently in case the inflictor is not in client PVS
	if (Attacker == Victim) then
		if !ValidEntity(Inflictor) then Inflictor = Victim end
		umsg.Start( "PlrKilledSelf" )
			umsg.Entity( Victim )
			umsg.Entity( Inflictor )
			umsg.String( Inflictor:GetClass() )
			umsg.Bool(Victim:GetTable().Headshot)
		umsg.End()
		
		MsgAll( Attacker:Nick() .. " suicided using " .. Inflictor:GetClass() .. "!\n" )
		
	return end

	if ( Attacker:IsPlayer() ) then
	
		umsg.Start( "PlrKilledPlr" )
		
			umsg.Entity( Victim )
			umsg.Entity( Inflictor )
			umsg.Entity( Attacker )
			umsg.String( Inflictor:GetClass() )
			umsg.Bool(Victim:GetTable().Headshot)
		
		umsg.End()
		
		MsgAll( Attacker:Nick() .. " killed " .. Victim:Nick() .. " using " .. Inflictor:GetClass() .. "\n" )
		
	return end
	
	umsg.Start( "PlrKilled" )
	
		umsg.Entity( Victim )
		umsg.Entity( Inflictor )
		umsg.String( Attacker:GetClass() )
		umsg.String( Inflictor:GetClass() )
		umsg.Bool(Victim:GetTable().Headshot)

	umsg.End()
	
	MsgAll( Victim:Nick() .. " was killed by " .. Attacker:GetClass() .. "\n" )
	
end

local function LimitReachedProcess( ply, str )

	// Always allow in single player
	if (SinglePlayer()) then return true end

	local c = server_settings.Int( "sbox_max"..str, 0 )
	
	if ( ply:GetCount( str ) < c || c < 0 ) then return true end 
	
	ply:LimitHit( str ) 
	return false

end

function GM:SetupPlayerVisibility(ply)
	for k,v in pairs(ents.FindByClass("bigbomb")) do
		if v:GetNWBool("armed") then
			AddOriginToPVS(v:GetPos())
		end
	end
end

function GM:PlayerSpawnMagnet( ply, model )

	return LimitReachedProcess( ply, "magnets" )

end

function GM:PlayerSpawnedMagnet( ply, model, ent )

	ply:AddCount( "magnets", ent )
	
end