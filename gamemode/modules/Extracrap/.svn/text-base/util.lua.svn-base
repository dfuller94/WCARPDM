
local nograv = {
"shot_beanbag",
"shot_tankshell",
"shot_rocket",
"shot_tranq",
"auto_turret_gun",
"shot_glround",
"svehicle_part_nophysics",
"svehicle_part",
"shot_glround",
"worldslayer",
"shot_energy"
}

// not local so that it can be used in all the rest of the game.
physgunables = {
"gmod_cameraprop",
"gmod_rtcameraprop",
"gmod_balloon",
"gmod_button",
"gmod_lamp",
"gmod_light",
"gmod_anchor",
"func_physbox",
"prop_physics",
"prop_physics_multiplayer",
"spawned_weapon",
"microwave",
"drug_lab",
"gunlab",
"dispenser",
"phys_magnet",
"m_crate",
"prop_ragdoll",
"gmod_thruster",
"gmod_wheel",
"item_drug",
"item_steroid",
"item_painkiller",
"item_magicbullet",
"item_antidote",
"item_amp",
"item_helmet",
"item_random",
"item_buyhealth",
"item_superdrug",
"item_booze",
"item_scanner",
"item_toolkit",
"item_regen",
"item_reflect",
"item_focus",
"item_snipeshield",
"item_armor",
"item_food",
"item_leech",
"item_shockwave",
"item_doubletap",
"item_uberdrug",
"item_knockback",
"item_doublejump",
"item_armorpiercer",
"item_superdrugoffense",
"item_superdrugdefense",
"item_superdrugweapmod",
"pillbox",
"drugfactory",
"powerplant",
"weedplant",
"meth_lab",
"prop_effect",
"money_printer",
"still",
"gunvault",
"radartower",
"gunfactory",
"bigbomb",
"keypad",
"sign"
}

function Disableunfreeze(weapon,player)
     return false;
end
hook.Add("OnPhysgunReload", "DisableMingebags", Disableunfreeze);

// override the gamemodes crap, to add sentry gun and rockets to the "do not physgun this" list, as well as add lagdolls and other shit to what can be touched.

function GM:GravGunPickupAllowed( ply, ent )
	if (ValidEntity(ent)) then
		local class = ent:GetClass()
		for k,v in ipairs(nograv) do
			if (class==v) then
				return false
			end
		end
		return true
	end
end 
function GM:PhysgunPickup( ply, ent )
	local class = ent:GetClass()
	if( ent:IsPlayer() or ent:IsDoor() or class=="shot_rocket" or class=="shot_beanbag" or class=="auto_turret_gun" or class=="bigbomb" or class=="shot_tranq" or class=="svehicle_part" or class=="svehicle_part_nophysics") then return false; end
	
	if( Admins[ply:SteamID()] ) then return true; end
	
	for k, v in ipairs(physgunables) do
		if( class==v) then
			return true;
		end
	end
	return false;

end


// A CHEAP IMITATION OF ULX GAG SINCE WE CANT RUN 3.2 BECAUSE THE NEW ULX ISNT COMPATIBLE WITH DARKRP
// we NEED this command. too many kids shit up our servers with thier voices.
// runs some copypasta on the client from ulx mod
// ulyssesmod.net
// now this actual function is from the rp files, but the clientside is from ulx.

//
// LOLOLOL DISREGARD THAT PROP PROTECT WAS FUCKING SHIT UP, and it was the best prop protect script we ever had too :(
//

function ccSTFU( ply, cmd, args )

	if( ply:EntIndex() ~= 0 and not Admins[ply:SteamID()] ) then 
		ply:PrintMessage( 2, "You're not an admin" );
		return;
	end

	local target = FindPlayer( args[1] );
	if (Admins[target:SteamID()]) then
		ply:PrintMessage( 2, "You cannot use this on an admin." ) ;
		return;
	end
	if( target && args[2] != nil ) then
		bln = util.tobool(args[2])
		if (bln==true) then
			Notify( target, 1, 3, "Your microphone has been disabled!" );
		else
			Notify( target, 1, 3, "Your microphone has been enabled!" );
		end
		umsg.Start( "shuddap", target );
			umsg.Bool( bln );
		umsg.End();
	else
		if( ply:EntIndex() == 0 ) then
			Msg( "Could not find player: " .. args[1] );
		else
			ply:PrintMessage( 2, "Could not find player: " .. args[1] );
		end
	end

end
concommand.Add( "rp_shutup", ccSTFU );

// votemute


function Votemute( ply, args ) 
	Notify( ply, 1, 3, "Use PLAYER LIST to mute people." );
end


AddChatCommand( "/votemute", Votemute );

function FinishVotemute( choice, v)

    VoteCopOn = false;

    if( choice == 1 ) then
    
        umsg.Start( "shuddap", v );
		umsg.Bool( 1 );
	umsg.End();
        
        NotifyAll( 3, 4, v:Nick() .. " has had their microphone muted!" );
            
    else
    
        NotifyAll( 3, 4, v:Nick() .. " has not been muted!" );
    
    end
end

// gun vault concommand

function ccWithdrawGun( ply, cmd, args )
	// in case of jackasses trying to exploit the game, or any other wierd shit that could happen.
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	gnum = tonumber(args[2])
	if (!ents.GetByIndex(args[1]):IsValid() || gnum>10 || gnum<1) then 
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="gunvault" || ply:GetPos():Distance(vault:GetPos())>200) then return end
	if (vault:IsLocked() && ply!=vault:GetNWEntity("owner") && !ply:IsAllied(vault:GetNWEntity("owner"))) then return end
	if (vault:CanDropGun(gnum)) then
		vault:DropGun(gnum, ply, 25, false)
	else
		Notify(ply,4,3, "This gun does not exist!")
		umsg.Start( "killgunvaultgui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "withdrawgun", ccWithdrawGun );


// pill box concommand

function ccWithdrawItem( ply, cmd, args )
	// in case of jackasses trying to exploit the game, or any other wierd shit that could happen.
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	gnum = tonumber(args[2])
	if (!ents.GetByIndex(args[1]):IsValid() || gnum>20 || gnum<1) then 
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="pillbox" || ply:GetPos():Distance(vault:GetPos())>200) then return end
	if (vault:IsLocked() && ply!=vault:GetNWEntity("owner") && !ply:IsAllied(vault:GetNWEntity("owner"))) then return end
	if (vault:CanDropGun(gnum)) then
		vault:DropGun(gnum, ply, 35, false)
	else
		Notify(ply,4,3, "This item does not exist!")
		umsg.Start( "killpillboxgui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "withdrawitem", ccWithdrawItem );

// gun factory concommand

function ccSetWeapon( ply, cmd, args )
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	guntype = tostring(args[2])
	if !ValidEntity(ents.GetByIndex(args[1])) || (guntype!="laserbeam" && guntype!="laserrifle" && guntype!="grenadegun" && guntype!="plasma" && guntype!="worldslayer" && guntype!="resetbutton") then
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="gunfactory" || ply:GetPos():Distance(vault:GetPos())>300) then return end
	if (vault:CanProduce(guntype, ply)) then
		vault:StartProduction(ply,guntype)
	else
		if guntype=="resetbutton" then
			Notify(ply,4,3, "Only Gun Factory owner can cancel weapon production.")
		else
			Notify(ply,4,3, "Cant make weapon.")
		end
		umsg.Start( "killgunfactorygui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "setgunfactoryweapon", ccSetWeapon );

function WeldControl(ent,ply)
	if (ValidEntity(ply)) then
		if ValidEntity(ent) then
			ent:SetNWInt("welddamage", 255)
		end
		ply:GetTable().shitweldcount=ply:GetTable().shitweldcount-1
		if (ply:GetTable().shitweldcount<=0) then
			ply:GetTable().shitweldcount=0
			ply:SetNWBool("shitwelding", false)
		end
	end
end

// refinery concommand

function ccSetRefineryMode( ply, cmd, args )
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	mode = tostring(args[2])
	if !ValidEntity(ents.GetByIndex(args[1])) || (mode!="money" && mode!="offense" && mode!="defense" && mode!="weapmod" && mode!="eject" && mode!="uber") then
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="drugfactory" || ply:GetPos():Distance(vault:GetPos())>300) then return end
	
	local ref = vault:CanRefine(mode,ply)
	if (ref==true) then
		vault:SetMode(mode)
	else
		Notify(ply,4,3,ref)
	end
	umsg.Start( "killdrugfactorygui", ply );
		umsg.Short( args[1] )
	umsg.End()
end
concommand.Add( "setrefinerymode", ccSetRefineryMode );
