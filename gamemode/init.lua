-------------
-- LightRP
-- Rick Darkaliono aka DarkCybo1
-- Jan 22, 2007
-- Done Jan 26, 2007

-- This script isn't a representation of my skillz
-------------

-------------
-- DarkRP v1.07
-- By: Rickster
-- Done June 15, 2007
-------------
-------------
-- WCARPDM v1.2 (WCACombat)
-- By: HLTV Proxy
-- Done Never ??th , 2008
-------------
-- Most (maybe all?) credit goes to rick darkaliono, and rickster, all i really did was update/add a few things.
-------------

DeriveGamemode( "sandbox" );

AddCSLuaFile( "cl_deaths.lua" );
AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "cl_msg.lua" )
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_vgui.lua" );
AddCSLuaFile( "entity.lua" );
AddCSLuaFile( "cl_scoreboard.lua" );
AddCSLuaFile( "scoreboard/admin_buttons.lua" );
AddCSLuaFile( "scoreboard/player_frame.lua" );
AddCSLuaFile( "scoreboard/player_infocard.lua" );
AddCSLuaFile( "scoreboard/player_row.lua" );
AddCSLuaFile( "scoreboard/scoreboard.lua" );
AddCSLuaFile( "scoreboard/vote_button.lua" );
AddCSLuaFile( "cl_helpvgui.lua" );
AddCSLuaFile( "cl_menu.lua" );

//include( "help.lua" );
include( "player.lua" );
include( "money.lua" );
include( "shared.lua" );
include( "chat.lua" );
include( "rplol.lua" );
include( "events.lua" );
include( "util.lua" );
include( "drugs.lua" );
include( "votes.lua" );
include( "admins.lua" );
include( "admincc.lua" );
include( "entity.lua" );
include( "bannedprops.lua" );
include( "commands.lua" );
include( "hints.lua" );
include( "vars.lua" );
include( "rating.lua" );
include("swep_fix.lua");
CSFiles = { }

LRP = { }


function includeCS( dir )

	AddCSLuaFile( dir );
	table.insert( CSFiles, dir );

end

local files = file.Find( "../gamemodes/DarkRP/gamemode/modules/*.lua" );
for k, v in pairs( files ) do

	include( "modules/" .. v );

end



// all of these are obsol33t. well, except for cmdprefix.
SetGlobalInt( "nametag", 1 ); --Should names show?
SetGlobalInt( "jobtag", 1 ); --Should jobs show?
SetGlobalInt("globalshow", 0) ; --Should we see player info from across the map?
SetGlobalString( "cmdprefix", "/" ); --Prefix before any chat commands

----------------------------------------
----------------------------------------




if( not file.IsDir( "DarkRP/" ) ) then

	file.CreateDir( "DarkRP" );

end

if( not file.Exists( "DarkRP/WHAT_YOU_CAN_DO_IN_THIS_FOLDER.txt" ) ) then

	local str = [[
	In this folder, you can create a file named servercfg.txt. 
	
	You can put in RP admin console commands in this file, and they'll be executed whenever the server starts.  
	Meaning you don't have to edit the script to change the default cvars!
	
	Example content of what can be in servercfg.txt:
	
	rp_chatprefix ! --Only if you need to use ! to use the chat commands.
	rp_propertytax 1
	rp_citpropertytax 1
	rp_toolgun 0
	rp_letters 0
	]]
	
	file.Write( "DarkRP/WHAT_YOU_CAN_DO_IN_THIS_FOLDER.txt" , str );

end

if( file.Exists( "DarkRP/servercfg.txt" ) ) then

	local cmds = string.Explode( "\n", file.Read( "DarkRP/servercfg.txt" ) );
	
	for k, v in pairs( cmds ) do
	
		game.ConsoleCommand( v .. "\n" );
	
	end

end

//GenerateChatCommandHelp();

function GM:Initialize()
	self.BaseClass:Initialize();
	createJailPos()
	setJailPos()
	DBConnect()
	getJackpot()
end

for k, v in pairs( player.GetAll() ) do

	v:NewData();
	v:SetNetworkedBool("helpMenu",false)
	getMoney(ply);
end

function ShowSpare1( ply )

	ply:ConCommand( "gm_showspare1\n" );

end
concommand.Add( "gm_spare1", ShowSpare1 );
 
 function serverHelp( player ) 
 
	if(player:GetNetworkedBool("helpMenu") == false) then
	player:SetNetworkedBool("helpMenu",true)
else
	player:SetNetworkedBool("helpMenu",false)
end
 
 end    
 concommand.Add( "serverHelp", serverHelp ) 

 function GM:ShowTeam( ply )
 
	umsg.Start( "ToggleBuy", ply ); umsg.End();
 
 end

function ShowSpare2( ply )

	ply:ConCommand( "gm_showspare2\n" );

end
concommand.Add( "gm_spare2", ShowSpare2 );

function GM:ShowHelp( ply )

	umsg.Start( "ToggleHelp", ply ); umsg.End();

end

GM.Name = "WCA RPDM";
GM.Author = "Original: Rickster | Modified: HLTV Proxy";

