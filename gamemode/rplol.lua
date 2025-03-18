
VoteCopOn = false;

function foodHeal( pl )
	if( GetGlobalInt( "hungermod" ) == 0 ) then
		// LOL at what used to be here.
		pl:SetHealth(pl:Health()+math.random(25,45))
		if (pl:Health()>pl:GetMaxHealth()*1.25) then
			pl:SetHealth(pl:GetMaxHealth()*1.25)
		end
	else
		pl:SetNWInt( "Energy", 100 );
        	umsg.Start( "AteFoodIcon", pl )
		umsg.End()
	end
	return "";
end

function DrugPlayer(pl)
	pl:ConCommand("pp_motionblur 1")  
	pl:ConCommand("pp_motionblur_addalpha 0.05")  
	pl:ConCommand("pp_motionblur_delay 0.035")  
	pl:ConCommand("pp_motionblur_drawalpha 0.75")  
	pl:ConCommand("pp_dof 1")  
	pl:ConCommand("pp_dof_initlength 9")  
	pl:ConCommand("pp_dof_spacing 100") 

	local IDSteam = string.gsub(pl:SteamID(), ":", "")
	
	
	// lol.
	if (pl:GetTable().Antidoted) then
		timer.Create( IDSteam, 5, 1, UnDrugPlayer, pl)
	else
		timer.Create( IDSteam, 10, 1, UnDrugPlayer, pl)
	end
end

function UnDrugPlayer(pl)
	pl:ConCommand("pp_motionblur 0")  
	pl:ConCommand("pp_dof 0")  
end

function BoozePlayer(pl)
	pl:ConCommand("pp_motionblur 1")  
	pl:ConCommand("pp_motionblur_addalpha 0.05")  
	pl:ConCommand("pp_motionblur_delay 0.035")  
	pl:ConCommand("pp_motionblur_drawalpha 0.75")  
	pl:ConCommand("pp_dof 1")  
	pl:ConCommand("pp_dof_initlength 9")  
	pl:ConCommand("pp_dof_spacing 100") 

	local IDSteam = string.gsub(pl:SteamID(), ":", "")
	
	
	// lol.
	if (pl:GetTable().Antidoted) then
		timer.Create( IDSteam, 5, 1, UnBoozePlayer, pl)
	else
		timer.Create( IDSteam, 10, 1, UnBoozePlayer, pl)
	end
end

function UnBoozePlayer(pl)
	pl:ConCommand("pp_motionblur 0")  
	pl:ConCommand("pp_dof 0")  
end

function dropWeapon( ply )

	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local ent = ply:GetActiveWeapon()
	if !ValidEntity(ent) then return  ""; end
	local diddrop = true
	local upgrade = ent:GetNWBool("upgraded")
	if(ent:GetClass( ) == "weapon_deagle2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_deagle2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_fiveseven2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fiveseven2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_glock2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "weapon_glock2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_ak472") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
		weapon:SetNWString("weaponclass", "weapon_ak472");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_mp52") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mp52");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_m42") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_m42");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_galil2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
		weapon:SetNWString("weaponclass", "weapon_galil2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_aug2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
		weapon:SetNWString("weaponclass", "weapon_aug2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_mac102") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mac102");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_ump452") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
		weapon:SetNWString("weaponclass", "weapon_ump452");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_50cal2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_mach_m249para.mdl" );
		weapon:SetNWString("weaponclass", "weapon_50cal2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_pumpshotgun2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_pumpshotgun2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_autoshotgun2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
		weapon:SetNWString("weaponclass", "weapon_autoshotgun2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_tmp2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_tmp2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "ls_sniper") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
		weapon:SetNWString("weaponclass", "ls_sniper");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_autosnipe") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_autosnipe");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_turretgun") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_turretgun");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_flamethrower") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_flamethrower");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_usp2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_usp2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_elites2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_elite_dropped.mdl" );
		weapon:SetNWString("weaponclass", "weapon_elites2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_p2282") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p2282");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_p902") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p902");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_knife2") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_knife_t.mdl" );
		weapon:SetNWString("weaponclass", "weapon_knife2");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_rocketlauncher") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
		weapon:SetNWString("weaponclass", "weapon_rocketlauncher");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_tranqgun") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_crossbow.mdl" );
		weapon:SetNWString("weaponclass", "weapon_tranqgun");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_worldslayer") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
		weapon:SetNWString("weaponclass", "weapon_worldslayer");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_grenadegun") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_sg552.mdl" );
		weapon:SetNWString("weaponclass", "weapon_grenadegun");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	else
		// wont include energy weapons as dropable since people will drop it to reload it.
		Notify( ply, 4, 3, "You can only drop Approved Weapons!" );
		diddrop = false
	end
	return "";
end
AddChatCommand( "/drop", dropWeapon );

function scanPlayer( ply, args )
	args = Purify(args)
	if args=="" then return "" end
	if( not ply:CanAfford( CfgVars["scancost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	if !ValidEntity(ply:GetTable().Tower) then
		Notify(ply,4,3,"You must have a Radar Tower to use this command. say /buyradar")
	else
		local userExists = false
		local tower = ply:GetTable().Tower
		if tower:GetTable().Scans<=0 || !tower:IsPowered() then
			Notify(ply,4,3,"Your radar tower is not charged enough to scan or does not have any power.")
		else
			local target = FindPlayer(args)
			if ValidEntity(target) then
				userExists = true
				tower:GetTable().Scans = tower:GetTable().Scans-1
				umsg.Start("RadarScan")
					umsg.Entity(target)
					umsg.Vector(target:GetPos())
					umsg.Short(target:EntIndex())
				umsg.End()
				local effectdata = EffectData()
					effectdata:SetOrigin(target:GetPos())
					effectdata:SetRadius(512)
				util.Effect("scanring", effectdata)
				ply:AddMoney( CfgVars["scancost"] * -1 );
				Notify( ply, 0, 3, "Scanning..." );
				Notify(target,1,3, ply:GetName() .. " has scanned you")
				
				if tower:GetNWInt("upgrade")>=1 then
					SpyScan(ply,target,false)
				end
				if tower:GetNWInt("upgrade")>=2 then
					ReconScan(ply,target)
				end
			end 
			
			if(!userExists) then
				Notify( ply, 4, 3, "Player not found." );
			end
		end
	end
	return "";
end
AddChatCommand( "/scan", scanPlayer );

function playerMobhit( ply, args )
	args = Purify(args)
	args = string.Explode(" ", args)
	if not( ply:Team() == 5 or ply:Team() == 11) then
		Notify( ply, 4, 3, "You must be Hitman or Mob Boss." );
	else
		//local useridExists = false
		//for k, v in pairs(player.GetAll()) do  
		local v = FindPlayer(args[1])
		if ValidEntity(v) then
			//if(v:Alive()) then
				//if(v:UserID( ) == tonumber(args[1])) then
					//useridExists = true
					if (tonumber(args[2])==nil) then
						Notify( ply, 4, 3, "Mob hit must be at least $100!")
					elseif( not ply:CanAfford( tonumber(args[2]) ) ) then
						Notify( ply, 4, 3, "Cannot afford this" );
					elseif ( tonumber(args[2])<100) then
						Notify( ply, 4, 3, "Mob hit must be at least $100!")
					else
						ply:AddMoney( tonumber(args[2]) * -1 );
						v:SetNWInt("hitlist", v:GetNWInt("hitlist")+math.Round(tonumber(args[2])/2))
						Jackpot = Jackpot+math.Round(tonumber(args[2])/2)
						Notify( ply, 0, 3, "Mob hit set for $" .. math.Round(tonumber(args[2])/2) );
						for a, b in pairs(player.GetAll()) do  
							if(b:Alive() && ((b:Team()==4 || b:Team()==5 || b:Team()==11) || b==v)) then
								b:PrintMessage( HUD_PRINTCENTER, v:Nick() .. " Has had a mob hit placed on them!" ) 
							end
						end
					end  
				//end
			//end
		end 
	
		/*if(useridExists == false) then
			Notify( ply, 4, 3, "UserId does not exist." );
		end*/
	end
	return "";
end
AddChatCommand( "/placehit", playerMobhit );

function helpCop( ply )
	if(ply:GetNWBool("helpCop") == true) then
		ply:SetNWBool("helpCop",false)
	else
		ply:SetNWBool("helpCop",true)
	end
	return "";
end
AddChatCommand( "/cophelp", helpCop );

function helpMedic( ply )
	if(ply:GetNWBool("helpMedic") == true) then
		ply:SetNWBool("helpMedic",false)
	else
		ply:SetNWBool("helpMedic",true)
	end
	return "";
end
AddChatCommand( "/medichelp", helpMedic );
AddChatCommand( "/pharmacisthelp", helpMedic );
AddChatCommand( "/drughelp", helpMedic );

function helpBoss( ply )
	if(ply:GetNWBool("helpBoss") == true) then
		ply:SetNWBool("helpBoss",false)
	else
		ply:SetNWBool("helpBoss",true)
	end
	return "";
end
AddChatCommand( "/mobbosshelp", helpBoss );

function helpHitman( ply )
	if(ply:GetNWBool("helpHitman") == true) then
		ply:SetNWBool("helpHitman",false)
	else
		ply:SetNWBool("helpHitman",true)
	end
	return "";
end
AddChatCommand( "/hitmanhelp", helpHitman );

function helpAdmin( ply )
	if(ply:GetNWBool("helpAdmin") == true) then
		ply:SetNWBool("helpAdmin",false)
	else
		ply:SetNWBool("helpAdmin",true)
	end
	return "";
end
AddChatCommand( "/adminhelp", helpAdmin );

function BuyPistol( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

	
	
	if( args == "deagle" ) then
		if( not ply:CanAfford( CfgVars["deaglecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["deaglecost"] * -1 );
		Notify( ply, 0, 3, "You bought a deagle!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_deagle2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "fiveseven" ) then
		if( not ply:CanAfford( CfgVars["fivesevencost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["fivesevencost"] * -1 );
		Notify( ply, 0, 3, "You bought a fiveseven!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fiveseven2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "glock" ) then
		if( not ply:CanAfford( CfgVars["glockcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["glockcost"] * -1 );
		Notify( ply, 0, 3, "You bought a glock!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "weapon_glock2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "p228" ) then
		if( not ply:CanAfford( CfgVars["p228cost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["p228cost"] * -1 );
		Notify( ply, 0, 3, "You wasted your money on a shitty pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "weapon_p2282");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "mac10" ) then
		if( not ply:CanAfford( CfgVars["mac10pistcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["mac10pistcost"] * -1 );
		Notify( ply, 0, 3, "You bought a machine pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mac102");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "tmp" ) then
		if( not ply:CanAfford( CfgVars["tmppistcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["tmppistcost"] * -1 );
		Notify( ply, 0, 3, "You bought a silenced machine pistol!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_tmp2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "usp" ) then
		if( not ply:CanAfford( CfgVars["uspcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["uspcost"] * -1 );
		Notify( ply, 0, 3, "You bought a USP!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_usp2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	elseif( args == "elites" || args == "dualies" || args == "baretta" ) then
		if( not ply:CanAfford( CfgVars["elitescost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["elitescost"] * -1 );
		Notify( ply, 0, 3, "You bought elites!" );
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_elite_dropped.mdl" );
		weapon:SetNWString("weaponclass", "weapon_elites2");
		weapon:SetPos( tr.HitPos );
		weapon:Spawn();
	else
		Notify( ply, 1, 3, "That's not an available weapon." );
	end
	return "";
end
AddChatCommand( "/buypistol", BuyPistol );

function ccBuyPistol(ply,command,args)
	if ply:GetTable().LastBuy+3<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		BuyPistol(ply,tostring(args[1]))
	end
end
concommand.Add("buypistol",ccBuyPistol)

function BuyWeapons( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	local mult=1	
	local tr = util.TraceLine( trace );

	if( team.NumPlayers (6) > 0 && ply:Team() ~= 6 && (args != "flashbang" && args != "stungrenade" && args != "stun" && args != "flash" && ply:Team()!=2 && ply:Team()!=9 && ply:Team()!=10) && ( args != "grenade" && args != "frag" && args != "fraggrenade" && ply:Team()!=2 && ply:Team()!=9 && ply:Team()!=10 && ply:Team()!=11 && ply:Team()!=5 )) then
		mult = 2
		Notify(ply,3,3, "Price is double because there are Gun Dealers.")
		//return "";
	end
	
	if( args == "ak47" || args == "ak" ) then
		if( not ply:CanAfford( CfgVars["ak47cost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( (CfgVars["ak47cost"]*mult) * -1 );
		Notify( ply, 0, 3, "You bought a shipment of ak47s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
			weapon:SetNWString("weaponclass", "weapon_ak472");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "aug") then
		if( not ply:CanAfford( CfgVars["augcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( (CfgVars["augcost"]*mult) * -1 );
		Notify( ply, 0, 3, "You bought a shipment of augs!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
			weapon:SetNWString("weaponclass", "weapon_aug2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "flamethrower") then
		if( not ply:CanAfford( CfgVars["flamethrowercost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( (CfgVars["flamethrowercost"]*mult) * -1 );
		Notify( ply, 0, 3, "You bought a shipment of flamethrowers!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg1.mdl" );
			weapon:SetNWString("weaponclass", "weapon_flamethrower");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "galil" ) then
		if( not ply:CanAfford( CfgVars["galilcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( (CfgVars["galilcost"]*mult) * -1 );
		Notify( ply, 0, 3, "You bought a shipment of galils!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
			weapon:SetNWString("weaponclass", "weapon_galil2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "mp5" || args== "mp5navy" ) then
		if( not ply:CanAfford( CfgVars["mp5cost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["mp5cost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of mp5s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mp52");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "tmp") then
		if( not ply:CanAfford( CfgVars["tmpcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["tmpcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of TMPs!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
			weapon:SetNWString("weaponclass", "weapon_tmp2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "m16" || args == "m4") then
		if( not ply:CanAfford( CfgVars["m16cost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["m16cost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of m4s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" );
			weapon:SetNWString("weaponclass", "weapon_m42");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "mac10" ) then
		if( not ply:CanAfford( CfgVars["mac10cost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["mac10cost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of mac10s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mac102");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "ump" || args == "ump45" ) then
		if( not ply:CanAfford( CfgVars["umpcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["umpcost"]*mult* -1 );
		Notify( ply, 0, 3, "You bought a shipment of ump45s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
			weapon:SetNWString("weaponclass", "weapon_ump452");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "shotgun" || args == "pumpshotgun") then
		if( not ply:CanAfford( CfgVars["shotguncost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["shotguncost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of shotguns!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "weapon_pumpshotgun2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "autoshotgun" || args == "noobcannon" || args=="m1014" || args=="xm1014" || args== "autoshotty") then
		if( not ply:CanAfford( CfgVars["autoshotguncost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["autoshotguncost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of m1014s!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
			weapon:SetNWString("weaponclass", "weapon_autoshotgun2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "sniper" || args == "awp") then
		if( not ply:CanAfford( CfgVars["snipercost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["snipercost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of sniper rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
			weapon:SetNWString("weaponclass", "ls_sniper");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "autosniper" || args == "autosnipe" || args == "psg1" || args=="g3" || args=="g3sg1") then
		if( not ply:CanAfford( CfgVars["autosnipecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["autosnipecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of automatic sniper rifles!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
			weapon:SetNWString("weaponclass", "weapon_autosnipe");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "rpg" || args == "rocketlauncher" ) then
		if( not ply:CanAfford( CfgVars["rpgcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["rpgcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of rocket launchers!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
			weapon:SetNWString("weaponclass", "weapon_rocketlauncher");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "para" || args == "50cal" || args == "hmg" ) then
		if( not ply:CanAfford( CfgVars["paracost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["paracost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of Paras!" );
		for i=-5, 5, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_mach_m249para.mdl" );
			weapon:SetNWString("weaponclass", "weapon_50cal2");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "flashbang" || args == "stungrenade" || args == "stun" || args == "flash" ) then
		// it may say flashbang, but these are stun nades now.
		if( not ply:CanAfford( CfgVars["flashbangcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["flashbangcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of stun grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "cse_eq_flashbang");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "smoke" || args == "smokegrenade" || args == "gasgrenade" || args == "bastardgas" || args=="teargas" || args=="mustardgas" || args =="gas") then
		if( not ply:CanAfford( CfgVars["gasgrenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["gasgrenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of gas grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_smokegrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_gasgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "grenade"  || args == "frag" || args == "fraggrenade" ) then
		if( not ply:CanAfford( CfgVars["grenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["grenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
			weapon:SetNWString("weaponclass", "cse_eq_hegrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "molotov"  || args == "firebomb") then
		if( not ply:CanAfford( CfgVars["molotovcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["molotovcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought molotovs!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
			weapon:SetNWString("weaponclass", "weapon_molotov");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	else
		Notify( ply, 4, 3, "That's not an available weapon." );
	end
	
	return "";
end
AddChatCommand( "/buyshipment", BuyWeapons );

function ccBuyWeapons(ply,command,args)
	if ply:GetTable().LastBuy+3<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		BuyWeapons(ply,tostring(args[1]))
	end
end
concommand.Add("buyshipment",ccBuyWeapons)

function BuyDrug( ply, args )
	args = Purify(args)
	//if( args == "" ) then return ""; end
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxdruglabs"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
	if not( ply:Team() == 4 or ply:Team() == 5  or ply:Team() == 11 or ply:Team() == 7) then
		Notify( ply, 4, 3, "Must Be a Gangster or Pharmacist" );
		return "";
	end
	for i=1,count do
		if( not ply:CanAfford( CfgVars["druglabcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxDrug >= CfgVars["maxdruglabs"])then
			Notify( ply, 4, 3, "Max Drug Labs Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["druglabcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Drug Lab" );
		local druglab = ents.Create( "drug_lab" );
		druglab:SetNWEntity( "owner", ply )
		druglab:SetPos( tr.HitPos+Vector(0,0,i*10));
		druglab:Spawn();
	end
	return "";
end
AddChatCommand( "/buydruglab", BuyDrug );

function BuyMicrowave( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["microwavecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxMicrowaves == CfgVars["maxmicrowaves"])then
			Notify( ply, 4, 3, "Max Microwaves Reached!" );
			return "";
		end
		if( ply:Team() == 8 ) then
			ply:AddMoney( CfgVars["microwavecost"] * -1 );
			Notify( ply, 0, 3, "You bought a Microwave" );
			local microwave = ents.Create( "microwave" );
			microwave:SetNWEntity( "owner", ply )
			microwave:SetPos( tr.HitPos );
			microwave:Spawn();
			return "";
		else
			Notify( ply, 4, 3, "You Must be the Cook to buy this" );
		end
	return "";
end
AddChatCommand( "/buymicrowave", BuyMicrowave );

function BuyGunlab( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["gunlabcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxgunlabs >= CfgVars["maxgunlabs"])then
			Notify( ply, 4, 3, "Max Gun Labs Reached!" );
			return "";
		end
		if( ply:Team() == 6 ) then
			ply:AddMoney( CfgVars["gunlabcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Gun Lab" );
			local gunlab = ents.Create( "gunlab" );
			gunlab:SetNWEntity( "owner", ply )
			gunlab:SetPos( tr.HitPos + Vector(0,0,64));
			gunlab:Spawn();
			return "";
		else
			Notify( ply, 4, 3, "Must be a Gun Dealer!" );
		end
	return "";
end
AddChatCommand( "/buygunlab", BuyGunlab );

function BuyGunvault( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["gunvaultcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxvault >= CfgVars["maxgunvaults"])then
			Notify( ply, 4, 3, "Max Gun Vaults/Pill Boxes Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["gunvaultcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Gun Vault" );
		local gunlab = ents.Create( "gunvault" );
		gunlab:SetNWEntity( "owner", ply )
		gunlab:SetPos( tr.HitPos );
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buygunvault", BuyGunvault );

function BuyPillBox( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["pillboxcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxvault >= CfgVars["maxgunvaults"])then
			Notify( ply, 4, 3, "Max Gun Vaults/Pill Boxes Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["pillboxcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Pill Box" );
		local gunlab = ents.Create( "pillbox" );
		gunlab:SetNWEntity( "owner", ply )
		gunlab:SetPos( tr.HitPos+Vector(0,0,40));
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buypillbox", BuyPillBox );

function BuyAmmo( ply, args )
	args = Purify(args)
	if( args == "" ) then return ""; end
 
	if(args == "rifle") then
		if( not ply:CanAfford( CfgVars["ammoriflecost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(120, "smg1")
		ply:AddMoney( CfgVars["ammoriflecost"] * -1 );
	elseif(args == "shotgun") then
		if( not ply:CanAfford( CfgVars["ammoshotguncost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(50, "buckshot")
		ply:AddMoney( CfgVars["ammoshotguncost"] * -1 );
	elseif(args == "pistol") then
		if( not ply:CanAfford( CfgVars["ammopistolcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(60, "pistol")
		ply:AddMoney( CfgVars["ammopistolcost"] * -1 );
	elseif(args == "fuel") then
		if( not ply:CanAfford( CfgVars["ammofuelcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(250, "CombineCannon")
		ply:AddMoney( CfgVars["ammofuelcost"] * -1 );
	elseif(args == "rocket") then
		if( not ply:CanAfford( CfgVars["ammorocketcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(6, "rpg_round")
		ply:AddMoney( CfgVars["ammorocketcost"] * -1 );
	elseif(args == "fuel") then
		if( not ply:CanAfford( CfgVars["ammofuelcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(250, "CombineCannon")
		ply:AddMoney( CfgVars["ammofuelcost"] * -1 );
	elseif(args == "sniper") then
		if( not ply:CanAfford( CfgVars["ammosnipercost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(20, "SniperRound")
		ply:AddMoney( CfgVars["ammosnipercost"] * -1 );
	elseif(args == "dart") then
		if( not ply:CanAfford( CfgVars["ammodartcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:GiveAmmo(8, "XBowBolt")
		ply:AddMoney( CfgVars["ammodartcost"] * -1 );
	else
		Notify( ply, 4, 3, "That ammo is not available." );
	end
	return "";
end
AddChatCommand( "/buyammo", BuyAmmo );

function ccBuyAmmo(ply,command,args)
	if ply:GetTable().LastBuy+3<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		BuyAmmo(ply,tostring(args[1]))
	end
end
concommand.Add("buyammo",ccBuyAmmo)


function BuyHealth( ply )
	local medcost = CfgVars["healthcost"]
	if (team.NumPlayers(7) > 0) then
		medcost = medcost*4
	end
	if( not ply:CanAfford( medcost ) ) then
		Notify( ply, 4, 3, "Cannot afford this" );
		return "";
	end
	
	ply:AddMoney( medcost * -1 );
	Notify(ply, 0, 3, "You bought a health kit")
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 80;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local vehiclespawn = ents.Create( "item_buyhealth" );
	vehiclespawn:SetPos( tr.HitPos + Vector(0, 0, 15));
	vehiclespawn:Spawn();
	return "";
end
AddChatCommand( "/buyhealth", BuyHealth );

function jailPos( ply )
	if( Admins[ply:SteamID()] or ply:Team() == 2 or ply:Team() == 3 or ply:Team()==9 or ply:Team()==10) then
			local jailPos = ply:GetPos()
			file.Write( "DarkRP/" .. game.GetMap() .. "_jailpos.txt",tostring(jailPos) )
			setJailPos()
			Notify( ply, 0, 4,  "Jail position set." );
	else
			Notify( ply, 4, 4,  "You have to be a cop or admin!" );
			return "";	
	end
	return "";
end
AddChatCommand( "/jailpos", jailPos );

function setJailPos()
	if file.Exists("DarkRP/" .. game.GetMap() .. "_jailpos.txt") then   
		local tempJailPos = file.Read("DarkRP/" .. game.GetMap() .. "_jailpos.txt")
		jailpos = (string.Explode(" " ,tempJailPos))
	end
end

function createJailPos()
	if not( file.Exists( "DarkRP/rp_cscdesert_v2-1_jailpos.txt" ) ) then
		file.Write( "DarkRP/rp_cscdesert_v2-1_jailpos.txt", "2709.2385 -8764.8623 9.7399")
	end
	
	if not( file.Exists( "DarkRP/rp_hometown1999_jailpos.txt" ) ) then
		file.Write( "DarkRP/rp_hometown1999_jailpos.txt", "7.3057 -1095.3040 -127.9688")
	end

	if not( file.Exists( "DarkRP/rp_omgcity_final_jailpos.txt" ) ) then
		file.Write( "DarkRP/rp_omgcity_final_jailpos.txt", "-760.5652 3085.5781 256.0313")
	end
end

function becomeGang( ply )
	if( CfgVars["allowgang"] == 1 ) then
		if (team.NumPlayers (4) < CfgVars["maxgangsters"]) then
			ply:SetTeam( 4 );
			ply:UpdateJob( "Gangster" );
			ply:ExitVehicle()
			ply:KillSilent();
		else
			Notify( ply, 4, 4, "Max Gangsters Reached" );
		end
	else
		Notify( ply, 4, 4, "Gangsters are disabled" );
	end
	return ""
end
AddChatCommand( "/gangster", becomeGang );

function becomeMobBoss( ply )
	if( CfgVars["allowgang"] == 1 ) then
		if (team.NumPlayers (5) < 1 || Admins[ply:SteamID()]) then
			ply:SetTeam( 5 );
			ply:UpdateJob( "Mob Boss" );
			ply:ExitVehicle()
			ply:KillSilent();
			NotifyAll( 3, 4, ply:Nick() .. " has been made the Mob Boss!" );
		else
			Notify( ply, 4, 4, "There can be only one." );
		end
	else
		Notify( ply, 4, 4, "Gangsters are disabled" );
	end
	return ""
end
AddChatCommand( "/mobboss", becomeMobBoss );

function makeAgenda( ply, args )
	args = Purify(args)
	if(ply:Team() == 5) then
		local ftext = string.gsub( args, "//", "\n" );
		umsg.Start( "UpdateMobAgenda");
			umsg.String( ftext )
		umsg.End()
		for k, v in pairs(player.GetAll()) do  
			if(v:Team() == 4) or (v:Team() == 5) or (v:Team()==11) then
				v:PrintMessage( HUD_PRINTTALK, "Mob Boss Updated Agenda" )
			else
				Notify( ply, 3, 4, "Mob Boss Updated Agenda" );
			end
		end  
	else
		Notify( ply, 4, 4, "Must be a Mob Boss to use this command." );
	end
	return "";
end
AddChatCommand( "/agenda", makeAgenda );

function GetHelp( ply, args )
	args = Purify(args)
	umsg.Start( "ToggleHelp", ply ); umsg.End();
	
	return "";

end
AddChatCommand( "/help", GetHelp );

function WriteLetter( ply, args )
	args = Purify(args)
	if( CfgVars["letters"] == 0 ) then
		
		Notify( ply, 4, 4, "Letter writing disabled" );
		return "";
	
	end
	
	if( CurTime() - ply:GetTable().LastLetterMade < 5 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 5 - ( CurTime() - ply:GetTable().LastLetterMade ) ) .. " seconds to make a letter" );
		return "";
	
	end

	ply:GetTable().LastLetterMade = CurTime();
	
	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = ply:EyePos();
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector();
	tr.filter = ply;
	local trace = util.TraceLine( tr );
	
	local letter = ents.Create( "prop_physics" );
		letter:SetModel( "models/props_c17/paper01.mdl" );
		letter:SetPos( trace.HitPos );
	letter:Spawn();
	
	letter:GetTable().Letter = true;
	letter:GetTable().type = 1
	// WHY IN THE FUCK WAS THIS A NETWORKED STRING?!?!?!!!??!?!
	letter:GetTable().content = ftext
	
	PrintMessageAll( 2, ply:Nick() .. " created a letter." );
	ply:PrintMessage( 2, "CREATED LETTER:\n" .. args );
	
	return "";

end
AddChatCommand( "/write", WriteLetter );


function WriteSign( ply, args )
	args = Purify(args)
	if( CfgVars["letters"] == 0 ) then
		
		Notify( ply, 4, 4, "Letter writing disabled" );
		return "";
	
	end
	
	if( CurTime() - ply:GetTable().LastLetterMade < 20 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 20 - ( CurTime() - ply:GetTable().LastLetterMade ) ) .. " seconds to make a sign" );
		return "";
	
	end
	if ply:GetTable().maxsign>CfgVars["maxsigns"] then
		Notify(ply,4,3,"Max signs reached")
		return ""
	end
	ply:GetTable().LastLetterMade = CurTime();
	
	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = ply:EyePos();
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector();
	tr.filter = ply;
	local trace = util.TraceLine( tr );
	
	local letter = ents.Create( "sign" );
		letter:SetNWString( "text", ftext );
		letter:SetPos( trace.HitPos );
		letter:SetNWEntity("owner",ply)
		letter:SetColor(tonumber(ply:GetInfo("rpdm_clcolor_r")),tonumber(ply:GetInfo("rpdm_clcolor_g")),tonumber(ply:GetInfo("rpdm_clcolor_b")),255)
	letter:Spawn();
	
	PrintMessageAll( 2, ply:Nick() .. " created a sign." );
	ply:PrintMessage( 2, "CREATED SIGN:\n" .. args );
	
	return "";

end
AddChatCommand( "/buysign", WriteSign );
AddChatCommand( "/sign", WriteSign );

function TypeLetter( ply, args )
	args = Purify(args)
	if( CfgVars["letters"] == 0 ) then
		
		Notify( ply, 4, 4, "Letter typing disabled" );
		return "";
	
	end
	
	if( CurTime() - ply:GetTable().LastLetterMade < 5 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 5 - ( CurTime() - ply:GetTable().LastLetterMade ) ) .. " seconds to make a letter" );
		return "";
	
	end

	ply:GetTable().LastLetterMade = CurTime();

	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = ply:EyePos();
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector();
	tr.filter = ply;
	local trace = util.TraceLine( tr );
	
	local letter = ents.Create( "prop_physics" );
		letter:SetModel( "models/props_c17/paper01.mdl" );
		letter:SetPos( trace.HitPos );
	letter:Spawn();
	
	letter:GetTable().Letter = true;
	letter:GetTable().type = 2
	letter:GetTable().content = ftext
	
	PrintMessageAll( 2, ply:Nick() .. " created a letter." );
	ply:PrintMessage( 2, "CREATED LETTER:\n" .. args );
	
	return "";

end
AddChatCommand( "/type", TypeLetter );

function ChangeJob( ply, args )
    args = Purify(args)
    if( args == "" ) then return ""; end
	
	NotifyAll( 3, 4, ply:Nick() .. " has set job to " .. args .. "!" );
	ply:UpdateJob( args );
	
	return "";

end
AddChatCommand( "/job", ChangeJob );

function PM( ply, args )
	args = Purify(args)
	local namepos = string.find( args, " " );
	if( not namepos ) then return ""; end
	
	local name = string.sub( args, 1, namepos - 1 );
	local msg = string.sub( args, namepos + 1 );
	
	target = FindPlayer( name );
		
	if( target ) then
	
		target:PrintMessage( 2, ply:Nick() .. ": (PM) " .. msg );
		target:PrintMessage( 3, ply:Nick() .. ": (PM) " .. msg );
		
		ply:PrintMessage( 2, ply:Nick() .. ": (PM) " .. msg );
		ply:PrintMessage( 3, ply:Nick() .. ": (PM) " .. msg );
		
	else
		
		Notify( ply, 4, 3, "Could not find player: " .. name );
		
	end
	
	return "";

end
AddChatCommand( "/pm", PM );


function Whisper( ply, args )
	args = Purify(args)
	TalkToRange( "(WHISPER)" .. ply:Nick() .. ": " .. args, ply:EyePos(), CfgVars["whisperradius"] );
	
	return "";

end
AddChatCommand( "/w", Whisper );


function Yell( ply, args )
	args = Purify(args)
	TalkToRange( "(YELL)" .. ply:Nick() .. ": " .. args, ply:EyePos(), CfgVars["yellradius"] );
	
	return "";

end
AddChatCommand( "/y", Yell );

function OOC( ply, args )
	args = Purify(args)
	if( CfgVars["ooc"] == 0 ) then 
		Notify( ply, 4, 3, "OOC is disabled" );
		return "";
	end
	Notify( ply, 3, 3, "You don't really need OOC tags on this server.")
	return "(OOC) " .. args;

end
AddChatCommand( "//", OOC, true );
AddChatCommand( "/a ", OOC, true );
AddChatCommand( "/ooc", OOC, true );


function GiveMoney( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetPos():Distance( ply:GetPos() ) < 150 and trace.Entity:GetNWBool("AFK")==false) then
	
		local amount = tonumber( args );
		if amount==nil then return "" end
		if( not ply:CanAfford( amount ) ) then
		
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		
		end
		if  (amount!=math.Round(amount)) then
			Notify(ply, 4, 3, "Must be a whole number" );
			return "";
		end
		trace.Entity:AddMoney( amount );
		ply:AddMoney( amount * -1 );
		
		Notify( trace.Entity, 2, 4, ply:Nick() .. " has given you " .. amount .. " dollars!" );
		Notify( ply, 0, 4, "Gave " .. trace.Entity:Nick() .. " " .. amount .. " dollars!" );
		
	else
	
		Notify( ply, 1, 3, "Must be looking at and be within distance of another player that is not AFK!" );
		
	end
	return "";
end
AddChatCommand( "/give", GiveMoney );

function DropMoney( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	
	local amount = tonumber( args );
	if amount==nil then return "" end
	if( not ply:CanAfford( amount ) ) then
		
		Notify( ply, 4, 3, "Cannot afford this!" );
		return "";
		
	end
	
	if( amount < 10 || amount!=math.Round(amount)) then
	
		Notify( ply, 4, 4, "Invalid amount of money! Must be atleast 10 dollars!" );
		return "";
	
	end
	
	ply:AddMoney( amount * -1 );
	
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local moneybag = ents.Create( "prop_physics" );
	moneybag:SetModel( "models/props/cs_assault/money.mdl" );
	moneybag:SetPos( tr.HitPos );
	moneybag:Spawn();
	
	moneybag:GetTable().MoneyBag = true;
	moneybag:GetTable().Amount = amount;
	
	return "";

end
AddChatCommand( "/moneydrop", DropMoney );


function SetDoorTitle( ply, args )
	args = Purify(args)
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		if( trace.Entity:OwnedBy( ply ) ) then
			trace.Entity:SetNWString( "title", args );
		else
			Notify( ply, 4, 3, "You don't own this!" );
		end
	
	end
	
	return "";

end
AddChatCommand( "/title", SetDoorTitle );

function RemoveDoorOwner( ply, args )
	args = Purify(args)
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		target = FindPlayer( args );
		
		if( target ) then
	
			if( trace.Entity:OwnedBy( ply ) ) then
				if( trace.Entity:AllowedToOwn( target ) ) then
					trace.Entity:RemoveAllowed( target );
				end
				
				if( trace.Entity:OwnedBy( target ) ) then
					trace.Entity:RemoveOwner( target );
				end
			else
				Notify( ply, 4, 3, "You don't own this!" );
			end
		
		else
		
			Notify( ply, 4, 3, "Could not find player: " .. args );
		
		end
		
	end
	
	return "";

end
AddChatCommand( "/removeowner", RemoveDoorOwner );


function AddDoorOwner( ply, args )
	args = Purify(args)
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 110 ) then
	
		target = FindPlayer( args );
		
		if( target ) then
	
			if( trace.Entity:OwnedBy( ply ) ) then
				if( not trace.Entity:OwnedBy( target ) and not trace.Entity:AllowedToOwn( target ) ) then
					trace.Entity:AddAllowed( target );
				else
					Notify( ply, 4, 3, "Player already owns this door, or is allowed to own!" );
				end
			else
				Notify( ply, 4, 3, "You don't own this!" );
			end
		
		else
		
			Notify( ply, 4, 3, "Could not find player: " .. args );
		
		end
		
	end
	
	return "";

end
AddChatCommand( "/addowner", AddDoorOwner );

function FinishVoteMayor( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 3 );
		ply:UpdateJob( "Mayor" );
		ply:ExitVehicle()
		ply:KillSilent();
		
		NotifyAll( 3, 4, ply:Nick() .. " has been made Mayor!" );
	
	else
	
		NotifyAll( 3, 4, ply:Nick() .. " has not been made Mayor!" );
	
	end

end

function FinishVoteCop( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 2 );
		ply:UpdateJob( "Civil Protection" );
		ply:ExitVehicle()
		ply:KillSilent();
		
		NotifyAll( 3, 4, ply:Nick() .. " has been made Civil Protection!" );
	
	else
	
		NotifyAll( 3, 4, ply:Nick() .. " has not been made Civil Protection!" );
	
	end

end

function FinishVoteOW( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 9 );
		ply:UpdateJob( "OverWatch" );
		ply:ExitVehicle()
		ply:KillSilent();
		
		NotifyAll( 3, 4, ply:Nick() .. " has been made OverWatch!" );
	
	else
	
		NotifyAll( 3, 4, ply:Nick() .. " has not been made OverWatch!" );
	
	end

end

function FinishVoteSpec( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 10 );
		ply:UpdateJob( "Spec Ops" );
		ply:ExitVehicle()
		ply:KillSilent();
		
		NotifyAll( 3, 4, ply:Nick() .. " has been made Spec Ops!" );
	
	else
	
		NotifyAll( 3, 4, ply:Nick() .. " has not been made Spec Ops!" );
	
	end

end

function FinishVoteHitman( choice, ply )

	VoteCopOn = false;

	if( choice == 1 ) then
	
		ply:SetTeam( 11 );
		ply:UpdateJob( "Hitman" );
		ply:ExitVehicle()
		ply:KillSilent();
		
		NotifyAll( 3, 4, ply:Nick() .. " has been made a Hitman!" );
	
	else
	
		NotifyAll( 3, 4, ply:Nick() .. " has not been made a Hitman!" );
	
	end

end

function DoVoteMayor( ply, args )
	args = Purify(args)
	if( CfgVars["mayorvoting"] == 0 ) then
	
		Notify( ply, 4, 4,  "Mayor voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 80 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 80 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to votemayor!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 4, 4,  "There is already a vote!" );
		return "";
	
	end
	
	if( CfgVars["cptomayoronly"] == 1 ) then
	
		if( ply:Team() == 1 ) then
		
			Notify( ply, 4, 4,  "You have to be a Cop!" );
			return "";	
		
		end
		
	end
	
	if( ply:Team() == 3 ) then
	
		Notify( ply, 4, 4,  "You're already Mayor!" );
		return "";
	
	end
	
	if( team.NumPlayers( 3 ) >= CfgVars["maxmayor"] ) then
	
		Notify( ply, 4, 4,  "Max number of Mayor's: " .. CfgVars["maxmayor"] );
		return "";	
	
	end
	
	vote:Create( ply:Nick() .. ":\nwants to be Mayor", ply:EntIndex() .. "votecop", ply, 12, FinishVoteMayor );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;
	
	return "";

end
AddChatCommand( "/votemayor", DoVoteMayor );

function DoVoteCop( ply, args )
	args = Purify(args)
	if( ply:Team() ~= 2 ) then
		ply:SetTeam( 2 );
		ply:UpdateJob( "Civil Protection" );
		ply:ExitVehicle()
		ply:KillSilent();
	else
		Notify( ply, 4, 4, "You're Already a Cop!" )
	end
	return "";
end
AddChatCommand( "/votecop", DoVoteCop );
AddChatCommand( "/votecp", DoVoteCop );

function DoVoteOW( ply, args )
	args = Purify(args)
	if( CfgVars["cpvoting"] == 0 ) then
	
		Notify( ply, 4, 4,  "Cop voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 120 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 120 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to vote for OverWatch!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 4, 4,  "There is already a vote for OverWatch!" );
		return "";
	
	end
	
	if( ply:Team() ~= 2 and ply:Team() ~= 3 ) then
	
		Notify( ply, 4, 4,  "Only cop or mayor can vote to be OverWatch!" );
		return "";	
	
	end
	
	if( team.NumPlayers( 9 ) >= CfgVars["maxow"] ) then

		Notify( ply, 4, 4,  "Max number of OverWatch is: " .. CfgVars["maxow"] );
		return "";	

	end

	vote:Create( ply:Nick() .. ":\nwants to be an OverWatch", ply:EntIndex() .. "votecop", ply, 12, FinishVoteOW );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;

	return "";

end
AddChatCommand( "/voteow", DoVoteOW );
// for people who are used to newer versions of darkrp, we'll make chief call overwatch vote.
AddChatCommand( "/votechief", DoVoteOW );
AddChatCommand( "/chief", DoVoteOW );
AddChatCommand( "/voteoverwatch", DoVoteOW );

function DoVoteSpec( ply, args )
	args = Purify(args)
	if( CfgVars["cpvoting"] == 0 ) then
	
		Notify( ply, 4, 4,  "Cop voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 300 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 300 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to vote for Spec Ops!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 4, 4,  "There is already a vote for Spec Ops!" );
		return "";
	
	end
	
	if( ply:Team() ~= 9) then
	
		Notify( ply, 4, 4,  "Only OverWatch can vote to be Spec Ops!" );
		return "";	
	
	end
	
	if( team.NumPlayers( 10 ) >= CfgVars["maxspec"] ) then

		Notify( ply, 4, 4,  "Max number of Spec Ops is: " .. CfgVars["maxspec"] );
		return "";	

	end

	vote:Create( ply:Nick() .. ":\nwants to be Spec Ops", ply:EntIndex() .. "votecop", ply, 12, FinishVoteSpec );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;

	return "";

end
AddChatCommand( "/votespecops", DoVoteSpec );

function DoVoteHitman( ply, args )
	args = Purify(args)
	if( CfgVars["cpvoting"] == 0 ) then
	
		Notify( ply, 4, 4,  "Hitman voting is disabled!" );
		return "";
	
	end

	if( CurTime() - ply:GetTable().LastVoteCop < 60 ) then
	
		Notify( ply, 4, 4, "Wait another " .. math.ceil( 60 - ( CurTime() - ply:GetTable().LastVoteCop ) ) .. " seconds to vote for Hitman!" );
		return "";
	
	end
	
	if( VoteCopOn ) then
	
		Notify( ply, 4, 4,  "There is already a vote for Hitman!" );
		return "";
	
	end
	
	if( ply:Team() ~= 4 and ply:Team() ~= 5 ) then
	
		Notify( ply, 4, 4,  "Only gangster or mobboss can vote to be a Hitman!" );
		return "";	
	
	end
	
	if( team.NumPlayers( 11 ) >= CfgVars["maxhitman"] ) then

		Notify( ply, 4, 4,  "There can only be " .. CfgVars["maxhitman"] .. " hitmen." );
		return "";	

	end

	vote:Create( ply:Nick() .. ":\nwants to be a Hitman", ply:EntIndex() .. "votecop", ply, 12, FinishVoteHitman );
	ply:GetTable().LastVoteCop = CurTime();
	VoteCopOn = true;

	return "";

end
AddChatCommand( "/votehitman", DoVoteHitman );

function MakeMayor( ply, args )
	args = Purify(args)
	if( Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if( ply:Team() ~= 3 ) then
			ply:SetTeam( 3 );
			ply:UpdateJob( "Mayor" );
			ply:ExitVehicle()
			ply:KillSilent();
		else
			Notify( ply, 4, 4, "You're Already Mayor!" );
		end
		return "";
	else
		Notify( 4, 4, "You Must be an Admin!" );
	end
	return "";
end
AddChatCommand( "/mayor", MakeMayor );

function MakeCitizen( ply, args )
	args = Purify(args)
	if( ply:Team() ~= 1 ) then
		ply:SetTeam( 1 );
		ply:UpdateJob( "Citizen" );
		ply:ExitVehicle()
		ply:KillSilent();
	else
		Notify( ply, 4, 3, "You're already a Citizen!" );
	end
	return "";
end
AddChatCommand( "/citizen", MakeCitizen );


function MakeCP( ply, args )
	args = Purify(args)
	if( ply:Team() ~= 2 ) then
		ply:SetTeam( 2 );
		ply:UpdateJob( "Civil Protection" );
		ply:ExitVehicle()
		ply:KillSilent();
	else
		Notify( ply, 4, 4, "You're Already a Cop!" )
	end
	return "";
end
AddChatCommand( "/cp", MakeCP );
AddChatCommand( "/cop", MakeCP );

function MakeHitman( ply, args )
	args = Purify(args)
	if( CP[ply:SteamID()] or Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if( ply:Team() ~= 11 ) then
			ply:SetTeam( 11 );
			ply:UpdateJob( "Hitman" );
			ply:ExitVehicle()
			ply:KillSilent();
		else
			Notify( ply, 4, 4, "You're Already a Hitman!" )
		end
		return "";
	else
		Notify( ply, 4, 4, "You have to be an Admin!" );
	end
	return "";
end
AddChatCommand( "/hitman", MakeHitman );

function MakeOW( ply, args )
	args = Purify(args)
	if( Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if( ply:Team() ~= 9 ) then
			ply:SetTeam( 9 );
			ply:UpdateJob( "OverWatch" );
			ply:ExitVehicle()
			ply:KillSilent();
		else
			Notify( ply, 4, 4, "You're Already an OverWatch!" )
		end
		return "";
	else
		Notify( ply, 4, 4, "You have to be an Admin!" );
	end
	return "";
end
AddChatCommand( "/ow", MakeOW );

function MakeSpec( ply, args )
	args = Purify(args)
	if( Admins[ply:SteamID()] or Mayor[ply:SteamID()] ) then
		if( ply:Team() ~= 10 ) then
			ply:SetTeam( 10 );
			ply:UpdateJob( "Spec Ops" );
			ply:ExitVehicle()
			ply:KillSilent();
		else
			Notify( ply, 4, 4, "You're Already a Spec Ops!" )
		end
		return "";
	else
		Notify( ply, 4, 4, "You have to be an Admin!" );
	end
	return "";
end
AddChatCommand( "/specops", MakeSpec );

function MakeDealer( ply, args )
	args = Purify(args)
	if( CfgVars["allowdealers"] == 1 ) then
		// I got tired of mingebags who go gundealer for no reason, and then ask "Hwo d0es ey3 git gunz?",
		// and when they are told how, don't even have enough money to afford the cheapest shipment.
		// Then after realizing they cannot afford ANY weapon, they still NEVER actually get off of gundealer. Fuck these people.
		if( not ply:CanAfford( CfgVars["mac10cost"] ) ) then
			Notify( ply, 4, 3, "You do not even have enough money to buy ANY gun shipment. You cannot be a Gun Dealer!" );
			return "";
		end
		if (team.NumPlayers (6) < CfgVars["maxgundealers"]) then
			if( ply:Team() ~= 6 ) then
				ply:SetTeam( 6 );
				ply:ExitVehicle()
				ply:UpdateJob( "GunDealer" );
				ply:KillSilent();
			else
				Notify( ply, 4, 4, "You're Already a Gun Dealer!" );
			end
			return "";
		else
			Notify( ply, 4, 4, "Max Gun Dealers Reached" );
		end
		return "";
	else
		Notify( ply, 1, 4, "Gun Dealers Disabled!" );
	end
	return "";
end
AddChatCommand( "/gundealer", MakeDealer );

function MakeMedic( ply, args )
	args = Purify(args)
	if( CfgVars["allowmedics"] == 1 ) then
		if (team.NumPlayers (7) < CfgVars["maxmedics"]) then
			if( ply:Team() ~= 7 ) then
				ply:SetTeam( 7 );
				ply:UpdateJob( "Pharmacist" );
				ply:ExitVehicle()
				ply:KillSilent();
			else
				Notify(ply, 4, 4, "You're Already a Pharmacist!" );
			end
			return "";
		else
			Notify( ply, 4, 4, "Max Pharmacists Reached!" );
		end
		return "";
	else
		Notify( ply, 4, 4, "Pharmacists Disabled!" );
	end
	return "";
end
AddChatCommand( "/medic", MakeMedic );
AddChatCommand( "/pharmacist", MakeMedic );
// think of drug dealer as a "street pharmacist"
AddChatCommand( "/drugdealer", MakeMedic );

function MakeCook( ply, args )
	args = Purify(args)
	if( CfgVars["allowcooks"] == 1 ) then
		if (team.NumPlayers (8) < CfgVars["maxcooks"]) then
			if( ply:Team() ~= 8 ) then
				ply:SetTeam( 8 );
				ply:UpdateJob( "Cook" );
				ply:ExitVehicle()
				ply:KillSilent();
			else
				Notify( ply, 4, 4, "You're Already a Cook!" );
			end
			return "";
		else
			Notify( ply, 4, 4, "Max Cooks Reached!" );
		end
		return "";
	else
		Notify( ply, 4, 4, "Cooks Disabled!" );
	end
	return "";
end
AddChatCommand( "/cook", MakeCook );

function CombineRadio( ply, args )
	args = Purify(args)
	if( ply:Team() == 2 or ply:Team() == 3 or ply:Team() == 9 or ply:Team() == 10) then
	
		for k, v in pairs( player.GetAll() ) do
		
			if( v:Team() == 2 or v:Team() == 3 or v:Team() == 9 or v:Team() == 10) then
			
				v:ChatPrint( ply:Nick() .. ": (RADIO) " .. args );
				v:PrintMessage( 2, ply:Nick() .. ": (RADIO) " .. args );
			
			end
		
		end
	
	end
	
	return "";

end
AddChatCommand( "/r", CombineRadio );

function CombineRequest( ply, args )
	args = Purify(args)
	if( ply:Team() ~= 2 && ply:Team() ~= 9 && ply:Team() ~= 10) then
	
		ply:ChatPrint( ply:Nick() .. ": (REQUEST!) " .. args );
		ply:PrintMessage( 2, ply:Nick() .. ": (REQUEST!) " .. args );	
	
	end
	
	for k, v in pairs( player.GetAll() ) do
		
		if( v:Team() == 2 || v:Team() == 9 || v:Team() == 10) then
			
			v:ChatPrint( ply:Nick() .. ": (REQUEST!) " .. args );
			v:PrintMessage( 2, ply:Nick() .. ": (REQUEST!) " .. args );
			
		end
		
	end
	
	
	return "";

end
AddChatCommand( "/cr", CombineRequest );

function GM:PlayerSpawnProp( ply, model )
	ply:ClearAFK()
	if( not self.BaseClass:PlayerSpawnProp( ply, model ) ) then return false; end
	
	local allowed = false;
	
	if( ply:GetTable().Arrested ) then return false; end
	if (ply:GetNWBool("shitwelding")) then 
		Notify(ply, 4, 3, "You cannot spawn props when people have welded your stuff or have recently bombed you!")
		return false;
	end
	if( ( CfgVars["allowedprops"] == 0 and CfgVars["banprops"] == 0 ) or Admins[ply:SteamID()] ) then allowed = true; end
	if( CfgVars["propspawning"] == 0 ) then return false; end
	
	if( CfgVars["allowedprops"] == 1 ) then
	
		for k, v in pairs( AllowedProps ) do
		
			if( v == model ) then allowed = true; end
		
		end
		
	end
	if( CfgVars["banprops"] == 1 ) then
	
		for k, v in pairs( BannedProps ) do
			if( string.lower(v) == string.lower(model) ) then return false; end
		
		end
		
	end
	
	if( allowed ) then
	
		if( CfgVars["proppaying"] == 1 ) then
		
			if( ply:CanAfford( CfgVars["propcost"] ) ) then
			
				Notify( ply, 0, 4, "Deducted $" .. CfgVars["propcost"] );
				ply:AddMoney( -CfgVars["propcost"] );
				
				return true;
			
			else
			
				Notify( ply, 4, 4, "Need $" .. CfgVars["propcost"] );
				return false;
			
			end
		
		else
		
			return true;
		
		end
	
	end
		
	return true;

end

local function CanDupe(ply, tr, mode)
	// Msg(mode .. " " .. tostring(ply:GetNWBool("shitwelding")) .. "\n")
	if mode=="duplicator" && ply:GetNWBool("shitwelding") then
		Notify(ply,4,3,"You cannot spawn props when people have welded your stuff or have recently bombed you!")
		return false
	end
end
hook.Add( "CanTool", "CanDupe", CanDupe )


function GM:SetupMove( ply, move )

	if( ply == nil or not ply:Alive() ) then
		return;
	end
	if ply:IsOnGround() then
		ply:GetTable().Jump2 = false
	end
	if( ply:GetTable().Arrested) then
	
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(90)
		return;	
	
	end
	if ( ply:GetTable().Roided) then
		ply:SetWalkSpeed(330-(ply:GetTable().StunDuration)*2)
		ply:SetRunSpeed(550-(ply:GetTable().StunDuration)*2.75)
		return;
	end
	// give gangsters the small speed boost, since cops already get guns AND bigger payday, just to balance the game a little.
	if ply:Team() == 4 then
		ply:SetWalkSpeed(240-(ply:GetTable().StunDuration)*1.5)
		ply:SetRunSpeed(385-(ply:GetTable().StunDuration)*2.5)
	elseif (ply:Team() == 5 || ply:Team() == 11 || ply:Team() == 1 || ply:Team()==3) then
		ply:SetWalkSpeed(235-(ply:GetTable().StunDuration)*1.5)
		ply:SetRunSpeed(375-(ply:GetTable().StunDuration)*2.5)
	elseif ply:Team()==10 then
		ply:SetWalkSpeed(220-(ply:GetTable().StunDuration)*1.5)
		ply:SetRunSpeed(330-(ply:GetTable().StunDuration)*2.5)
	else
		ply:SetWalkSpeed(230-(ply:GetTable().StunDuration)*1.5)
		ply:SetRunSpeed(350-(ply:GetTable().StunDuration)*2.5)
	end
	return;

end


function GM:ShowSpare1( ply )

	umsg.Start( "ToggleClicker", ply ); umsg.End();

end

function GM:ShowSpare2( ply )
	
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsOwnable() and ply:GetPos():Distance( trace.Entity:GetPos() ) < 115 ) then
	
		if( trace.Entity:OwnedBy( ply ) ) then
			Notify( ply, 0, 4, "You've unowned this door!" );
			trace.Entity:UnOwn( ply );
			ply:GetTable().Owned[trace.Entity:EntIndex()] = nil;
			ply:GetTable().OwnedNum = ply:GetTable().OwnedNum - 1;
		else
			
			if( trace.Entity:IsOwned() and not trace.Entity:AllowedToOwn( ply ) ) then
			
				Notify( ply, 4, 3, "Already owned" );
				return;
			
			end
			
			if( not ply:CanAfford( CfgVars["doorcost"] ) ) then
		
				Notify( ply, 4, 4, "You cannot afford this!" );
				return;
		
			end
			
			ply:AddMoney( CfgVars["doorcost"] * -1 );
		
			Notify( ply, 0, 4, "You've owned this door for " .. CfgVars["doorcost"] .. " bucks!" );
			
			trace.Entity:Own( ply );
			
			ply:GetTable().OwnedNum = ply:GetTable().OwnedNum + 1;
			
			ply:GetTable().Owned[trace.Entity:EntIndex()] = trace.Entity;
			
		end
		
	end

end

function GM:KeyPress( ply, code )
	ply:ClearAFK()
	self.BaseClass:KeyPress( ply, code );
	
	if( code == IN_JUMP && !ply:GetTable().Jump2 && !ply:IsOnGround() && ply:GetTable().DoubleJumped) then
		ply:SetVelocity(ply:GetForward()*150+Vector(0,0,300))
		ply:GetTable().Jump2 = true
	end
	
	if( code == IN_USE ) then
	
		local trace = { }
	
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 95;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );

		if( tr.Entity!=nil and ValidEntity(tr.Entity) and not ply:KeyDown( IN_ATTACK ) ) then
		
			if( tr.Entity:GetTable().Letter ) then
	
				umsg.Start( "ShowLetter", ply );
					umsg.Short( tr.Entity:GetTable().type );
					umsg.Vector( tr.Entity:GetPos() );
					umsg.String( tr.Entity:GetTable().content );
				umsg.End();
			
			end

			if( tr.Entity:GetTable().MoneyBag ) then
	
				Notify( ply, 2, 4, "You found $" .. tr.Entity:GetTable().Amount );
				ply:AddMoney( tr.Entity:GetTable().Amount );
				
				tr.Entity:Remove();
			
			end
			if( tr.Entity:GetTable().ScrapMetal ) then
	
				Notify( ply, 2, 4, "You found scrap metal worth $" .. tr.Entity:GetTable().Amount );
				ply:AddMoney( tr.Entity:GetTable().Amount );
				
				tr.Entity:Remove();
			
			end
		else
		
			umsg.Start( "KillLetter", ply ); umsg.End();
		
		end
	
	end

end


function GM:EntityTakeDamage(ply, inflictor, attacker, damage, dmginfo)
	local ignoredrug = false
	if inflictor:GetClass()=="env_fire" || inflictor:GetClass()=="env_physexplosion" || inflictor:GetClass()=="auto_turret_gun" || inflictor:GetClass()=="weapon_molotov" || inflictor:GetClass()=="weapon_flamethrower" ||inflictor:GetClass()=="weapon_knife2" || inflictor:GetClass()=="weapon_gasgrenade" || inflictor:GetClass()=="weapon_tranqgun" || inflictor:GetClass()=="bigbomb" then
		ignoredrug = true
	end
	local scaler = 1
	if (inflictor:GetClass()=="env_physexplosion" || inflictor:GetClass()=="env_fire") && ValidEntity(inflictor:GetTable().attacker) then
		attacker = inflictor:GetTable().attacker
	end
	if (attacker.Amp == true && !inflictor:IsPlayer() && inflictor:GetClass()!="auto_turret_gun" && inflictor:GetClass()!="weapon_knife2" && inflictor:GetClass()!="weapon_gasgrenade" && inflictor:GetClass()!="weapon_tranqgun" && inflictor:GetClass()!="bigbomb") then
		//dmginfo:ScaleDamage(1.5)
		scaler = scaler*1.4
	end
	// before even applying painkiller or anything, take the max damage it can be, then bounce back part of that.
	// dont bounce knife damage because we dont want to risk bouncing poison
	// dont bounce burning damage because itl get annoying for people to have to burn with other people
	if (ply:GetTable().Mirror == true && attacker!=ply && !inflictor:IsPlayer() && ((dmginfo:IsExplosionDamage() && inflictor:GetClass()!="bigbomb" ) || !ignoredrug)) then
		attacker:TakeDamage(scaler*damage*0.25, ply, ply)
	end
	if (ply.PainKillered == true && attacker:IsPlayer() && attacker!=ply && inflictor:IsPlayer()==false) then
		//dmginfo:ScaleDamage(0.675)
		scaler = scaler*.675
	end
	
	// fuck the mingebags and thier propfaggotry. only thing that would be left is prop pushing, but at least you dont die and lose your gun.
	
	if (attacker!=nil && attacker:IsPlayer()==false) then
		local class = attacker:GetClass()
		local donotwant = false
		if class== "entityflame" || inflictor:IsVehicle() || attacker:IsVehicle() || class==v || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && (!dmginfo:IsFallDamage() || ply:GetTable().Knockbacked)) then
			donotwant = true
		end
		for k, v in ipairs(physgunables) do
			if (class==v && v!="bigbomb") || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && !dmginfo:IsFallDamage()) then
				donotwant = true
			end
		end 
		if donotwant then
			//dmginfo:ScaleDamage(0)
			scaler = 0
		end
	end
	
	if (inflictor!=nil && inflictor:IsPlayer()==false) then
		local class = inflictor:GetClass()
		local donotwant = false
		if class== "entityflame" || inflictor:IsVehicle() || attacker:IsVehicle() || class==v || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && (!dmginfo:IsFallDamage() || ply:GetTable().Knockbacked)) then
			donotwant = true
		end
		for k, v in ipairs(physgunables) do
			if (class==v && v!="bigbomb") || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && !dmginfo:IsFallDamage()) then
				donotwant = true
			end
		end 
		if donotwant then
			//dmginfo:ScaleDamage(0)
			scaler = 0
		end
	end

	if (ply:IsPlayer() || ply:IsNPC()) && attacker:IsPlayer() && !inflictor:IsPlayer() && !ignoredrug && attacker.Knockbacked && math.Rand(0,1)>.3 then
		local origin = inflictor:GetPos()
		local pos = ply:GetPos()+Vector(0,0,50)
		local yomomma = (pos-origin)
		yomomma:Normalize()
		local force = (dmginfo:GetDamage()*5)
		if force<100 then force = 100 end
		if force>700 then force = 700 end
		local knockdirection = yomomma*force+Vector(0,0,20)
		ply:SetVelocity(knockdirection)
		StunPlayer(ply, math.ceil(dmginfo:GetDamage()*0.1))
	end
	
	local tdamage = damage*scaler
	if !ply:IsPlayer() then return end
	if (scaler>0 && tdamage>=(ply:Health()+ply:Armor()) && ply:GetTable().Shielded) then
		ply:GetTable().Shieldon = true
		local IDSteam = string.gsub(ply:SteamID(), ":", "")
		timer.Create(IDSteam .. "shield", 0.25, 1, UnShield, ply)
		Notify(ply, 1, 3, "Snipe Shield Activated")
		ply:SetNWBool("shielded", false)
		ply:GetTable().Shielded = false
		// this is here so that fags can stop making bullshit claims about godmode.
		if (attacker:IsPlayer() && attacker!=ply) then
			Notify(attacker, 1, 3, "Target survived using Snipe Shield!")
		end
		dmginfo:SetDamage((ply:Health()+ply:Armor())-1)
		dmginfo:ScaleDamage(1)
	elseif (ply:GetTable().Shieldon) then
		// for that 4th of a second, godmode them just so that this works against shotguns.
		//dmginfo:SetDamage(0)
		scaler = 0
		dmginfo:ScaleDamage(0)
	else
		dmginfo:ScaleDamage(scaler)
	end
	// let leech heal the attacker, but only if they hit a player or npc, and its not poison or returned damage
	if (ply:IsPlayer() || ply:IsNPC()) && attacker:IsPlayer() && !inflictor:IsPlayer() && !ignoredrug && attacker.Leeched && attacker:Health()<attacker:GetMaxHealth() then
		attacker:SetHealth(attacker:Health()+(tdamage*.35))
		if attacker:Health()>attacker:GetMaxHealth() then
			attacker:SetHealth(attacker:GetMaxHealth())
		end
	end
end


function BuyNWeapons( ply, args )
	args = Purify(args)
	args = string.Explode(" ", args)
   	if( args[1] == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	local mult=1	
	local tr = util.TraceLine( trace );
	
	if( args == "flashbang" || args == "stungrenade" || args == "stun" || args == "flash" ) then
		// it may say flashbang, but these are stun nades now.
		if( not ply:CanAfford( CfgVars["flashbangcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["flashbangcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of stun grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "cse_eq_flashbang");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "smoke" || args == "smokegrenade" || args == "gasgrenade" || args == "bastardgas" || args=="teargas" || args=="mustardgas" || args =="gas") then
		if( not ply:CanAfford( CfgVars["gasgrenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["gasgrenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of gas grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_smokegrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_gasgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "grenade"  || args == "frag" || args == "fraggrenade" ) then
		if( not ply:CanAfford( CfgVars["grenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["grenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of grenades!" );
		for i=-3, 3, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
			weapon:SetNWString("weaponclass", "cse_eq_hegrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "molotov"  || args == "firebomb") then
		if( not ply:CanAfford( CfgVars["molotovcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["molotovcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought molotovs!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
			weapon:SetNWString("weaponclass", "weapon_molotov");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	else
		Notify( ply, 4, 3, "That's not an available weapon." );
	end
	
	return "";
end
AddChatCommand( "/buynade", BuyNWeapons );