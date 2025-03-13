include( "Extracrap/util.lua" );
Extracrap = { }


Jackpot = 1000
Ticketsdrawn = 0

// upgrade command

function Upgrade(ply, args)
	args = Purify(args)
	if( args != "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if (!ValidEntity(tr.Entity)) then
		return "";
	end
	local targent = tr.Entity
	if (targent:GetClass()!="auto_turret" && targent:GetClass()!="dispenser" && targent:GetClass()!="drugfactory" && targent:GetClass()!="drug_lab" && targent:GetClass()!="still" && targent:GetClass()!="money_printer" && targent:GetClass()!="radartower" && targent:GetClass()!="gunfactory" && targent:GetClass()!="weedplant"&& targent:GetClass()!="meth_lab") then
		Notify(ply,4,3,"This cannot be upgraded.")
		return "" ;
	end
	
	if (targent:GetNWInt("owner")!=ply) then
		Notify( ply, 4, 3, "This is not yours." );
		return "" ;
	end
	local lvl = targent:GetNWInt("upgrade") + 1
	if (lvl>2) then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	
	local price = 0
	if targent:GetClass()== "auto_turret" then price = CfgVars["turretcost"]
	elseif targent:GetClass()== "dispenser" then price = CfgVars["dispensercost"]
	elseif targent:GetClass()== "drugfactory" then price = CfgVars["drugfactorycost"]
	elseif targent:GetClass()== "drug_lab" then price = CfgVars["druglabcost"]
	elseif targent:GetClass()== "still" then price = CfgVars["stillcost"]
	elseif targent:GetClass()== "money_printer" then price = CfgVars["printercost"]
	elseif targent:GetClass()== "meth_lab" then price = CfgVars["methlabcost"]
	elseif targent:GetClass()== "radartower" then price = CfgVars["radartowercost"]
	elseif targent:GetClass()== "weedplant" then price = CfgVars["weedcost"]
	elseif targent:GetClass()== "gunfactory" then price = CfgVars["gunfactorycost"]
	end
	price = price*CfgVars["upgradecost"]
	if (lvl==2) then price = price*2 end
	if (!ply:CanAfford(price)) then
		Notify(ply, 4, 3, "Cannot afford this. Cost is $" .. price)
		return "" ;
	end
	ply:AddMoney(price*-1)
	Notify( ply, 0, 3, "Applying level " .. lvl .. " upgrade.")
	targent:SetNWInt("upgrade", lvl)
	return "";
end
AddChatCommand( "/upgrade", Upgrade );

// refinery

function BuyRefinery( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
		if( ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "Must be a pharmacist");
			return "";
		end
		if( not ply:CanAfford( CfgVars["drugfactorycost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxdrugfactory >= CfgVars["maxdrugfactory"])then
			Notify( ply, 4, 3, "Max Drug Refineries Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["drugfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Drug Refinery" );
		local gunlab = ents.Create( "drugfactory" );
		gunlab:SetNWEntity( "owner", ply )
		gunlab:SetPos( tr.HitPos+Vector(0,0,40));
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buyrefinery", BuyRefinery );
AddChatCommand( "/buydrugfactory", BuyRefinery );
AddChatCommand( "/buydrugrefinery", BuyRefinery );

// gunfactory

function BuyGunFactory( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
	if( not ply:CanAfford( CfgVars["gunfactorycost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	if(ply:GetTable().maxgunfactory >= CfgVars["maxgunfactory"])then
		Notify( ply, 4, 3, "Max Gun Factories Reached!" );
		return "";
	end
	ply:AddMoney( CfgVars["gunfactorycost"] * -1 );
	Notify( ply, 0, 3, "You bought a Gun Factory" );
	local gunlab = ents.Create( "gunfactory" );
	gunlab:SetNWEntity( "owner", ply )
	gunlab:SetPos( tr.HitPos+Vector(0,0,10));
	gunlab:Spawn();
	return "";
end
AddChatCommand( "/buygunfactory", BuyGunFactory );
AddChatCommand( "/buyfactory", BuyGunFactory );

// radar tower

function BuyTower( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( not ply:CanAfford( CfgVars["radartowercost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	if(ply:GetTable().maxtower >= 1)then
		Notify( ply, 4, 3, "You already have a Radar Tower!" );
		return "";
	end
	ply:AddMoney( CfgVars["radartowercost"] * -1 );
	Notify( ply, 0, 3, "You bought a Radar Tower" );
	local gunlab = ents.Create( "radartower" );
	gunlab:SetNWEntity( "owner", ply )
	gunlab:SetPos( tr.HitPos+Vector(0,0,10));
	gunlab:Spawn();
	return "";
end
AddChatCommand( "/buytower", BuyTower );
AddChatCommand( "/buyradar", BuyTower );

// power plant

function BuyGenerator( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["generatorcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxgenerator >= CfgVars["maxgenerator"])then
			Notify( ply, 4, 3, "Max Power Plants Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["generatorcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Power Plant" );
		local gunlab = ents.Create( "powerplant" );
		gunlab:SetNWEntity( "owner", ply )
		gunlab:SetPos( tr.HitPos+Vector(0,0,10));
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buypowerplant", BuyGenerator );
AddChatCommand( "/buygenerator", BuyGenerator );

// Big Bomb

function BuyBomb( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( not ply:CanAfford( CfgVars["bigbombcost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	ply:AddMoney( CfgVars["bigbombcost"] * -1 );
	Notify( ply, 0, 3, "You bought the big bomb" );
	local vehiclespawn = ents.Create( "bigbomb" );
	vehiclespawn:SetPos( tr.HitPos + tr.HitNormal*15);
	vehiclespawn:SetNWEntity("owner", ply)
	vehiclespawn:Spawn();
	vehiclespawn:Activate();
	return "";
end
AddChatCommand( "/buybomb", BuyBomb );

// tranquilizer dart gun

function BuyDartgun( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
		Notify( ply, 4, 3, "BuyDartgun Disabled because there are Pharmacists.");
		return "";
	end
	if( not ply:CanAfford( CfgVars["dartguncost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	ply:AddMoney( CfgVars["dartguncost"] * -1 );
	Notify( ply, 0, 3, "You bought a dart gun" );
	local vehiclespawn = ents.Create( "spawned_weapon" );
	vehiclespawn:SetModel( "models/weapons/w_crossbow.mdl" );
	vehiclespawn:SetNWString("weaponclass", "weapon_tranqgun");
	vehiclespawn:SetPos( tr.HitPos + tr.HitNormal*15);
	vehiclespawn:SetNWEntity("owner", ply)
	vehiclespawn:Spawn();
	vehiclespawn:Activate();
	return "";
end
AddChatCommand( "/buydartgun", BuyDartgun );

// pipe bomb

function BuyPBomb( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( not ply:CanAfford( CfgVars["pipebombcost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	ply:AddMoney( CfgVars["pipebombcost"] * -1 );
	Notify( ply, 0, 3, "You bought pipe bombs" );
	local vehiclespawn = ents.Create( "spawned_weapon" );
	vehiclespawn:SetModel( "models/props_lab/pipesystem03b.mdl" );
	vehiclespawn:SetNWString("weaponclass", "weapon_pipebomb");
	vehiclespawn:SetPos( tr.HitPos + tr.HitNormal*15);
	vehiclespawn:SetNWEntity("owner", ply)
	vehiclespawn:Spawn();
	vehiclespawn:Activate();
	return "";
end
AddChatCommand( "/buypipebomb", BuyPBomb );

// buyknife

function BuyKnife( ply )
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a knife while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["knifecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["knifecost"] * -1 );
		Notify( ply, 0, 3, "You bought a knife" );
		
		ply:Give("weapon_knife2")
		return "";
end
AddChatCommand( "/buyknife", BuyKnife );

// buylockpick

function BuyLockPick( ply )
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a lockpick while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["lockpickcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["lockpickcost"] * -1 );
		Notify( ply, 0, 3, "You bought a lockpick" );
		
		ply:Give("lockpick")
		return "";
end
AddChatCommand( "/buylockpick", BuyLockPick );

// Teh weld0r

function BuyWelder( ply )
		if (CfgVars["allowwelder"] == 0) then
			Notify( ply, 4, 3, "Welder has been disabled!");
			return "";
		end
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a welder while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["weldercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["weldercost"] * -1 );
		Notify( ply, 0, 3, "You bought a blowtorch/welder" );
		
		ply:Give("weapon_welder")
		return "";
end
AddChatCommand( "/buywelder", BuyWelder );
AddChatCommand( "/buyblowtorch", BuyWelder );

// buy a sentry turret

function BuyTurret( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowturrets"] == 0) then
			Notify( ply, 4, 3, "Sentry turrets have been disabled!");
			return "";
		end
		if (not tr.HitWorld) then
			Notify( ply, 4, 3, "Please look at the ground to spawn sentry turret" );
			return "";
		end
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a sentry turret while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["turretcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxturret >= CfgVars["turretmax"])then
			Notify( ply, 4, 3, "Max sentry turrets Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		local SpawnAng = tr.HitNormal:Angle()
		for k, v in pairs( ents.FindInSphere(SpawnPos, 1250)) do
			if (v:GetClass() == "info_player_deathmatch" || v:GetClass() == "info_player_rebel" || v:GetClass() == "gmod_player_start" || v:GetClass() == "info_player_start" || v:GetClass() == "info_player_allies" || v:GetClass() == "info_player_axis" || v:GetClass() == "info_player_counterterrorist" || v:GetClass() == "info_player_terrorist") then
				Notify( ply, 4, 3, "Cannot create sentry turret near a spawn point!" );
				return "" ;
			end
		end
		ply:AddMoney( CfgVars["turretcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Sentry turret" );
		
		local ent = ents.Create( "auto_turret" )
		ent:SetPos( SpawnPos + (tr.HitNormal*-3) )
		ent:SetAngles( SpawnAng + Angle(90, 0, 0) )
		ent:SetNWEntity( "owner", ply )
		ent:SetNWString( "ally" , "")
		ent:SetNWString( "jobally", "")
		ent:SetNWString( "enemytarget", "")
		ent:SetNWBool( "hatetarget", false)
		ent:Spawn()
		ent:Activate()
		local head = ents.Create( "auto_turret_gun" )
		head:SetPos( SpawnPos + (tr.HitNormal*18) )
		head:SetAngles( SpawnAng + Angle(90, 0, 0) )
		head:Spawn()
		head:Activate()
		head:SetParent(ent)
		head.Body = ent
		ent.Head = head
		head:SetOwner(ply)
		return "";
end
AddChatCommand( "/buyturret", BuyTurret );

// buy a dispenser

function BuyDispenser( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowdispensers"] == 0) then
			Notify( ply, 4, 3, "Ammo dispensers have been disabled!");
			return "";
		end
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy an ammo dispenser while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["dispensercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxdispensers >= CfgVars["dispensermax"])then
			Notify( ply, 4, 3, "Max dispensers Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["dispensercost"] * -1 );
		Notify( ply, 0, 3, "You bought an ammo dispenser" );
		
		local ent = ents.Create( "dispenser" )
		ent:SetPos( SpawnPos + Vector(0,0,30) )
		ent:SetNWEntity( "owner", ply )
		ent:Spawn()
		ent:Activate()
		return "";
end
AddChatCommand( "/buydispenser", BuyDispenser );

// buy a methlab

function BuyMethlab( ply,args )
	args = Purify(args)
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxmethlab"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if ( ply:GetTable().Arrested ) then
		Notify( ply, 4, 3, "You can't buy a methlab while arrested!" );
		return "";
	end
	for i=1,count do
		if( not ply:CanAfford( CfgVars["methlabcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxmethlab >= CfgVars["maxmethlab"])then
			Notify( ply, 4, 3, "Max methlabs Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["methlabcost"] * -1 );
		Notify( ply, 0, 3, "You bought a meth lab. Good luck!" );
		
		local ent = ents.Create( "meth_lab" )
		ent:SetPos( SpawnPos + Vector(0,0,10) )
		ent:SetNWEntity( "owner", ply )
		ent:Spawn()
		ent:Activate()
	end
	return "";
end
AddChatCommand( "/buymethlab", BuyMethlab );

// buy a plant

function BuyPlant( ply,args )
	args = Purify(args)
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxweed"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a plant while arrested!" );
			return "";
		end
	for i=1,count do
		if( not ply:CanAfford( CfgVars["weedcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxweed >= CfgVars["maxweed"])then
			Notify( ply, 4, 3, "Max plants Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["weedcost"] * -1 );
		Notify( ply, 0, 3, "You bought a plant!" );
		
		local ent = ents.Create( "weedplant" )
		ent:SetPos( SpawnPos + Vector(0,0,20) )
		ent:SetNWEntity( "owner", ply )
		ent:Spawn()
		ent:Activate()
		if (math.Rand(0,1)>.75) then
			ent:Worthless()
			Notify( ply, 1, 3, "unluckily for you, it's hemp. You might as well destroy it.")
		end
	end
	return "";
end
AddChatCommand( "/buyplant", BuyPlant );
AddChatCommand( "/buyweed", BuyPlant );
AddChatCommand( "/buyweedplant", BuyPlant );

function BuySpawn( ply )
    
    if( args == "" ) then return ""; end
    	local trace = { }
    		trace.start = ply:GetPos()+Vector(0,0,1)
		trace.endpos = trace.start+Vector(0,0,90)
		trace.filter = ply
	trace = util.TraceLine(trace)
	if( trace.Fraction<1 ) then
            Notify( ply, 4, 3, "Need more room" );
            return "";
        end
        if( not ply:CanAfford( CfgVars["spawncost"] ) ) then
            Notify( ply, 4, 3, "Cannot afford this" );
            return "";
        end
	if(!ply:Alive())then
            Notify( ply, 4, 3, "Dead men buy no spawn points.");
            return "";
        end
	if ValidEntity(ply:GetTable().Spawnpoint) then
		ply:GetTable().Spawnpoint:Remove()
		Notify(ply,1,3, "Destroyed old spawnpoint to create this one.")
	end
        ply:AddMoney( CfgVars["spawncost"] * -1 );
        Notify( ply, 0, 3, "You bought a spawn point!" );
        local spawnpoint = ents.Create( "spawnpoint" );
        spawnpoint:SetNWEntity( "owner", ply )
        spawnpoint:SetPos( ply:GetPos());
	ply:SetPos(ply:GetPos()+Vector(0,0,3))
	spawnpoint:SetAngles(Vector(-90, 0, 0))
        spawnpoint:Spawn();
    return "";
end
AddChatCommand( "/buyspawnpoint", BuySpawn );

function AllyTurret(ply, args)
	Notify( ply, 1, 3, "Use the WCARPDM Allies menu instead of this")
	return "";
end
//AddChatCommand( "/setally", AllyTurret );
//AddChatCommand( "/addally", AllyTurret );

function UnAllyTurret(ply, args)
	Notify( ply, 1, 3, "Use the WCARPDM Allies menu instead of this")
	return""
end
AddChatCommand( "/clearally", UnAllyTurret );
//AddChatCommand( "/removeally", UnAllyTurret );
//AddChatCommand( "/unsetally", UnAllyTurret );

function JobAllyTurret(ply, args)
	Notify( ply, 1, 3, "Use the WCARPDM Allies menu instead of this")
	return""
end
//AddChatCommand( "/setjobally", JobAllyTurret );

function TargetTurret(ply, args)
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local targent = tr.Entity
	if (targent:GetClass()!="auto_turret") then
		return "" ;
	end
	if (targent:GetNWInt("owner")!=ply) then
		Notify( ply, 4, 3, "This is not your turret!" );
		return "" ;
	end
	Notify( ply, 0, 3, "Set turret target string to " .. args)
	targent:SetNWString("enemytarget", args)
	return "" ;
end
//AddChatCommand( "/settarget", TargetTurret );

// buy a jeep

function BuyJeep( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowjeeps"] == 0) then
			Notify( ply, 4, 3, "BuyJeep has been disabled!");
			return "";
		end
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy a jeep while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["jeepcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["jeepcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Jeep" );
		ang = ply:EyeAngles()
		ang.pitch = 0
		ang.roll = 0
		local vehiclespawn = ents.Create( "prop_vehicle_jeep" );
		vehiclespawn:SetModel("models/buggy.mdl")
		vehiclespawn:SetKeyValue("vehiclescript", "scripts/vehicles/jeep_test.txt")
		vehiclespawn:SetKeyValue("solid", 6)
		vehiclespawn:SetPos( tr.HitPos );
		vehiclespawn:SetAngles(ang)
		//vehiclespawn:SetOwner(ply)
		vehiclespawn:Spawn();
		undo.Create("Jeep")
		undo.SetPlayer(ply)
		undo.AddEntity(vehiclespawn)
		undo.Finish("Bought Jeep")
	return "";
end
AddChatCommand( "/buyjeep", BuyJeep );

// buy an airboat

function BuyAirboat( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowairboats"] == 0) then
			Notify( ply, 4, 3, "BuyAirboat has been disabled!");
			return "";
		end
		if ( ply:GetTable().Arrested ) then
			Notify( ply, 4, 3, "You can't buy an airboat while arrested!" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["airboatcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["airboatcost"] * -1 );
		Notify( ply, 0, 3, "You bought an Airboat" );
		ang = ply:EyeAngles()
		ang.pitch = 0
		ang.roll = 0
		local vehiclespawn = ents.Create( "prop_vehicle_airboat" );
		vehiclespawn:SetModel("models/airboat.mdl")
		vehiclespawn:SetKeyValue("vehiclescript", "scripts/vehicles/airboat.txt" )
		vehiclespawn:SetKeyValue("solid", 6)
		vehiclespawn:SetKeyValue("VehicleLocked", 0)
		vehiclespawn:SetKeyValue("EnableGun", 0)
		//vehiclespawn:SetKeyValue("actionScale", 1)
		vehiclespawn:SetPos( tr.HitPos );
		vehiclespawn:SetAngles(ang)
		//vehiclespawn:SetOwner(ply)
		vehiclespawn:Spawn();
		vehiclespawn:Activate();
		undo.Create("Airboat")
		undo.SetPlayer(ply)
		undo.AddEntity(vehiclespawn)
		undo.Finish("Bought Airboat")
	return "";
end
AddChatCommand( "/buyairboat", BuyAirboat );

// armor related shit.

function BuyArmor( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["hltvproxywashere"] == 0) then
			Notify( ply, 4, 3, "BuyArmor has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["armorcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["armorcost"] * -1 );
		Notify( ply, 0, 3, "You bought armor" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_armor" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*25, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyarmor", BuyArmor );

// helmet related shit.

function BuyHelmet( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowhelmet"] == 0) then
			Notify( ply, 4, 3, "BuyHelmet has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["helmetcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["helmetcost"] * -1 );
		Notify( ply, 0, 3, "You bought helmets" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_helmet" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*25, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyhelmet", BuyHelmet );

// toolkit

function BuyToolKit( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["toolkitcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["toolkitcost"] * -1 );
		Notify( ply, 0, 3, "You bought toolkits" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_toolkit" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*20, 10));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buytoolkit", BuyToolKit );

// scanner

function BuyScanner( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["scannercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["scannercost"] * -1 );
		Notify( ply, 0, 3, "You bought scanners" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_scanner" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*20, 10));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyscanner", BuyScanner );

// snipe shield

function BuyShield( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowsteroids"] == 0) then
			Notify( ply, 4, 3, "BuyShield has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["shieldcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["shieldcost"] * -1 );
		Notify( ply, 0, 3, "You bought snipe shields" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_snipeshield" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*20, 10));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyshield", BuyShield );

// steroid 

function BuySteroid( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowsteroids"] == 0) then
			Notify( ply, 4, 3, "BuySteroids has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["steroidcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuySteroid Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["steroidcost"] * -1 );
		Notify( ply, 0, 3, "You bought steroids" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_steroid" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buysteroids", BuySteroid );

// doublejump 

function BuyDoubleJump( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["doublejumpcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyDoubleJump Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["doublejumpcost"] * -1 );
		Notify( ply, 0, 3, "You bought double jump" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_doublejump" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buydoublejump", BuyDoubleJump );

// adrenaline 

function BuyAdrenaline( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["adrenalinecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyAdrenaline Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["adrenalinecost"] * -1 );
		Notify( ply, 0, 3, "You bought adrenaline" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_adrenaline" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyadrenaline", BuyAdrenaline );

// knockback 

function BuyKnockback( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["knockbackcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyKnockback Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["knockbackcost"] * -1 );
		Notify( ply, 0, 3, "You bought knockback" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_knockback" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyknockback", BuyKnockback );

// armorpiercer

function BuyArmorpiercer( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["armorpiercercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyArmorPiercer Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["armorpiercercost"] * -1 );
		Notify( ply, 0, 3, "You bought armorpiercer" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_armorpiercer" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyapiercer", BuyArmorpiercer );
AddChatCommand( "/buypiercer", BuyArmorpiercer );
AddChatCommand( "/buyarmorpiercer", BuyArmorpiercer );

// shockwave 

function BuyShockWave( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["shockwavecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyShockWave Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["shockwavecost"] * -1 );
		Notify( ply, 0, 3, "You bought shock wave" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_shockwave" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyshockwave", BuyShockWave );

// leech 

function BuyLeech( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["leechcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyLeech Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["leechcost"] * -1 );
		Notify( ply, 0, 3, "You bought leech" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_leech" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyleech", BuyLeech );

// double tap 

function BuyDoubleTap( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["doubletapcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyDoubleTap Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["doubletapcost"] * -1 );
		Notify( ply, 0, 3, "You bought double tap" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_doubletap" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buydoubletap", BuyDoubleTap );

// reflect 

function BuyReflect( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowreflect"] == 0) then
			Notify( ply, 4, 3, "BuyReflect has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["reflectcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyReflect Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["reflectcost"] * -1 );
		Notify( ply, 0, 3, "You bought reflect" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_reflect" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyreflect", BuyReflect );

// focus 

function BuyFocus( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowfocus"] == 0) then
			Notify( ply, 4, 3, "BuyFocus has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["focuscost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyFocus Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["focuscost"] * -1 );
		Notify( ply, 0, 3, "You bought focus" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_focus" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyfocus", BuyFocus );

// antidote 

function BuyAntidote( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowantidote"] == 0) then
			Notify( ply, 4, 3, "BuyAntidote has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["antidotecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyAntidote Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["antidotecost"] * -1 );
		Notify( ply, 0, 3, "You bought antidote" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_antidote" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyantidote", BuyAntidote );

// Amplifier 

function BuyAmp( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowamp"] == 0) then
			Notify( ply, 4, 3, "BuyAmplifier has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["ampcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["ampcost"] * -1 );
		Notify( ply, 0, 3, "You bought amplifier" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_amp" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyamp", BuyAmp );

// pain killer 
function BuyPainKiller( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowpainkiller"] == 0) then
			Notify( ply, 4, 3, "BuyPainKiller has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["painkillercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyPainKiller Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["painkillercost"] * -1 );
		Notify( ply, 0, 3, "You bought pain killers" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_painkiller" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buypainkiller", BuyPainKiller );
AddChatCommand( "/buypainkillers", BuyPainKiller );

// magic bullet 
function BuyMagicBullet( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["magicbulletcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyMagicBullet Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["magicbulletcost"] * -1 );
		Notify( ply, 0, 3, "You bought magic bullet" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_magicbullet" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buymagicbullet", BuyMagicBullet );
AddChatCommand( "/buymb", BuyMagicBullet );

// regeneration 

function BuyRegen( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (CfgVars["allowregen"] == 0) then
			Notify( ply, 4, 3, "BuyRegen has been disabled!");
			return "";
		end
		if( not ply:CanAfford( CfgVars["regencost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if( team.NumPlayers (7) > 0 and ply:Team() ~= 7 ) then
			Notify( ply, 4, 3, "BuyRegen Disabled because there are Pharmacists.");
			return "";
		end
		ply:AddMoney( CfgVars["regencost"] * -1 );
		Notify( ply, 0, 3, "You bought regeneration" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.Create( "item_regen" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		end
	return "";
end
AddChatCommand( "/buyregen", BuyRegen );

// counterfeit money printer

function BuyPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if not( ply:Team() == 4 or ply:Team() == 5 or ply:Team() == 11) then
			Notify( ply, 4, 3, "Must Be a Gangster" );
			return "";
		end
		if( not ply:CanAfford( CfgVars["printercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxPrinter >= CfgVars["maxprinters"])then
			Notify( ply, 4, 3, "Max Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["printercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Printer" );
		local druglab = ents.Create( "money_printer" );
		druglab:SetNWEntity( "owner", ply )
		druglab:SetPos( tr.HitPos + tr.HitNormal*148);
		druglab:Spawn();
	return "";
end
AddChatCommand( "/buyprinter", BuyPrinter );
AddChatCommand( "/buymoneyprinter", BuyPrinter );

// moonshine still

function BuyStill( ply,args )
	args = Purify(args)
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxstills"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	for i=1,count do
		if( not ply:CanAfford( CfgVars["stillcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxStill >= CfgVars["maxstills"])then
			Notify( ply, 4, 3, "Max Stills Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["stillcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Moonshine Still" );
		local druglab = ents.Create( "still" );
		druglab:SetNWEntity( "owner", ply )
		druglab:SetPos( tr.HitPos + tr.HitNormal*40);
		druglab:Spawn();
	end
	return "";
end
AddChatCommand( "/buystill", BuyStill );


function ccSetTeam( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
		local num = tonumber(args[2])
		if (num>0 && num<13) then
			target:SetTeam( num );
			if num==1 then target:UpdateJob( "Citizen" )
			elseif num==2 then target:UpdateJob( "Civil Protection" )
			elseif num==3 then target:UpdateJob( "Mayor" )
			elseif num==4 then target:UpdateJob( "Gangster" )
			elseif num==5 then target:UpdateJob( "Mob Boss" )
			elseif num==6 then target:UpdateJob( "Gun Dealer" )
			elseif num==7 then target:UpdateJob( "Pharmacist" )
			elseif num==8 then target:UpdateJob( "Cook" )
			elseif num==9 then target:UpdateJob( "OverWatch" )
			elseif num==10 then target:UpdateJob( "Spec Ops" )
			elseif num==11 then target:UpdateJob( "Hit Man" )
			elseif num==12 then target:UpdateJob( "???" )
			end
			target:ExitVehicle()
			target:KillSilent();
			
			local nick = "";
			
			if( ply:EntIndex() ~= 0 ) then
				nick = ply:Nick();
			else
				nick = "Console";
			end
		
			target:PrintMessage( 2, nick .. " changed your team to " .. args[2] );
		end
	else
	
		if( ply:EntIndex() == 0 ) then
			Msg( "Did not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Did not find player: " .. args[1] );
		end
		
		return;
	
	end

end
concommand.Add( "rp_team", ccSetTeam );


------------------------------------------
--                                      --
--        LOTTERY BULLSHIT              --
--                                      --
------------------------------------------

function BuyLottoTicket(ply, args)
	args = Purify(args)
	if( args == "" ) then return ""; end
	local num = -1
	if (tonumber(args)==nil) then
		return "";
	end
	if (tonumber(args)<0 || tonumber(args)>999) then
		Notify( ply, 4, 3, "must be a number between 0 and 999" )
		return "";
	else
		num = tonumber(args)
	end
	// Msg(num)
	if( not ply:CanAfford( CfgVars["lottoticketcost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	ply:AddMoney( CfgVars["lottoticketcost"] * -1 );
	Notify( ply, 0, 3, "You played the lottery number " .. num .. "" );
	
	Jackpot = Jackpot + math.ceil(CfgVars["lottoticketcost"]*.2)
	setJackpot(Jackpot)
	Ticketsdrawn = Ticketsdrawn + 1
	/*
	if (Ticketsdrawn>=CfgVars["lottoautodraw"] && CfgVars["lottoautodraw"]>0) then
		DrawNumber()
	end
	*/
	table.insert(ply:GetTable().tickets, num)
	return "";
end
AddChatCommand( "/buyticket", BuyLottoTicket );

function DrawNumber()
	/*
	timer.Destroy("lottery")
	if (CfgVars["lottodrawtime"]>0) then
		timer.Create("lottery", CfgVars["lottodrawtime"], 1, DrawNumber)
	end
	*/
	win = math.random(0,999)
	PrintMessageAll( HUD_PRINTTALK , "The winning number is: " .. win .. "")
	local playedtickets = 0
	local winrars = { }
	for k, v in pairs(player.GetAll()) do
		for l, t in ipairs(v:GetTable().tickets) do
			if (t!=nil) then
				playedtickets = playedtickets+1
				if (t==win) then
					table.insert(winrars, v)
				end
			end
		end
		v:GetTable().tickets = { }
	end
	if (table.Count(winrars)>0) then
		PrintMessageAll( HUD_PRINTTALK , "There are " .. table.Count(winrars) .. " winners! Pay out to each winning ticket is $" .. Jackpot/table.getn(winrars) .. "!")
	end
	if (table.Count(winrars)>0) then
		//local payout = Jackpot
		// DONOTWANT divide by 0. it can come through here as a 0, if some people on server A win, then server B draws and has someone who already bought a ticket before server A had a winner.
		if Jackpot==0 then Jackpot=1 end
		local payout = math.ceil(Jackpot/table.getn(winrars))
		for k, v in pairs(winrars) do
			v:AddMoney(payout)
			PrintMessageAll( HUD_PRINTTALK , v:Nick() .. " has a winning ticket!")
			Notify(v, 3, 2, "You have the winning number! You have won $" .. payout .. "!")
		end
		Jackpot = CfgVars["lottoticketcost"]
		setJackpot(Jackpot)
	else
		PrintMessageAll( HUD_PRINTTALK , "Nobody has a winning ticket. Jackpot stays at $" .. Jackpot )
	end
	Ticketsdrawn = 0
	PrintMessageAll( HUD_PRINTTALK , "To buy a lottery ticket for $" .. CfgVars["lottoticketcost"] .. ", say /buyticket #" )
end	

timer.Create("lottery", CfgVars["lottodrawtime"], 0, DrawNumber)


function setJackpot(amount)
	local IDSteam = "steam_jackpot"
	if tonumber(Jackpot)!=nil then
		local tbl,udt,err = mysql.query(db, "UPDATE rpdmmoney SET Money="..Jackpot.." WHERE SteamID='"..IDSteam.."'")
		if !udt then Msg(error.."\n") end
	end
end

function getJackpot()
	
	local IDSteam = "steam_jackpot"
	
	
	local table,succ,error = mysql.query(db, "SELECT Money FROM rpdmmoney WHERE SteamID='"..IDSteam.."'")
	if !succ then Msg(error.."\n") end
	local jpmoney = 1000
	if table[1]!=nil && tonumber(table[1][1])!=nil then
		jpmoney = math.ceil(tonumber(table[1][1]))
	else
		Msg("Adding new user: " ..IDSteam.."\n")
		local tbl,udt,err = mysql.query(db, "INSERT INTO rpdmmoney (SteamID, Money) values ('"..IDSteam.."', 1000)")
		if !udt then Msg(error.."\n") end
	end
	Jackpot = jpmoney
	if (Jackpot>2147483647) then
		jpmoney = 2147483647
	end
end

------------------------------------------
--                                      --
--        NPC ALLY STUFF                --
--                                      --
------------------------------------------

// may or may not ever be added.

function BuyNPC(ply,args)
	args = Purify(args)
	args = string.Explode(" ", args)
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

	local npctype = "npc_manhack"
	//npctype = args[1]
	npctype = "npc_metropolice"
	// lol wut
	if( true ) then
		
		/*if( not ply:CanAfford( CfgVars["deaglecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["deaglecost"] * -1 );
		*/
		Notify( ply, 0, 3, "You bought an npc" );
		local npc = ents.Create( npctype );
		npc:SetNWEntity("owner", ply);
		table.insert(ply:GetTable().NPCs, npc)
		npc:SetPos( tr.HitPos );
		if npctype=="npc_vortigaunt" then
			npc:SetModel("models/vortigaunt_slave.mdl")
		end
		npc:Spawn()
		npc:Give("weapon_mac102") // args[2]
		
		npc:AddRelationship("player D_FR 3")
		npc:AddRelationship("player D_HT 9")
		npc:AddRelationship("player D_LI 8")
		npc:AddRelationship("player D_NU 10")
		
		npc:AddEntityRelationship(ply,D_LI,99)
		npc:AddEntityRelationship(ply,D_HT,0)
		npc:AddEntityRelationship(ply,D_FR,5)
		npc:AddEntityRelationship(ply,D_NU,4)
		
		npc:SetNPCState(1)
		npc:SetLastPosition(ply:GetPos())
		npc:SetSchedule(71)
	else
		Notify( ply, 1, 3, "That's not an available NPC." );
	end
	return "";
end
//AddChatCommand( "/buynpc", BuyNPC );