/*
	EVENTS
	function dump for things like zombie, meteor storm, and anything else that might be added
	
*/



/********************************************
|
|	Zombies
|
********************************************/

local timeLeft = 10
local timeLeft2 = 10
local zombieOn = false
local maxZombie = 10

function controlZombie()

timeLeft2 = timeLeft2 - 1
	
	if(timeLeft2 < 1) then
		if(zombieOn == true) then
			timeLeft2 = math.random( 200,400)
			zombieOn = false
			timer.Stop("start2")
			zombieEnd()
		else
			timeLeft2 = math.random( 150,300)
			zombieOn = true
			timer.Start("start2")
			loadZombies()
			zombieStart()
		end
	end

end

function zombieStart()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "Warning Zombies Are Approaching!" ) 
			v:PrintMessage( HUD_PRINTTALK, "Warning Zombies Are Approaching!" ) 
		end
	end  
end

function zombieEnd()
	for k, v in pairs(player.GetAll()) do  
		if(v:Alive()) then
			v:PrintMessage( HUD_PRINTCENTER, "Zombies Are Leaving" ) 
			v:PrintMessage( HUD_PRINTTALK, "Zombies Are Leaving" ) 
		end
	end  
end

function playerDist(npcPos)
	local playDis
	local currPlayer
	for k, v in pairs(player.GetAll()) do
		local tempPlayDis = v:GetPos():Distance( npcPos:GetPos() )
		if(playDis == nil) then
			playDis = tempPlayDis
			currPlayer = v
		end
		if(tempPlayDis < playDis) then
			playDis = tempPlayDis
			currPlayer = v
		end
	end
	return currPlayer
end

function moveZombie()
	local activePlayers = false
	for k, v in pairs(player.GetAll()) do
		activePlayers = true
	end
	if(activePlayers == true) then
		local tb1 = table.Add(ents.FindByClass("npc_antlion"),ents.FindByClass("npc_fastzombie"))
		local tb2 = table.Add(ents.FindByClass("npc_zombie"),ents.FindByClass("npc_headcrab_fast"))
		local tb3 = table.Add(tb1,tb2)
		local tb4 = table.Add(tb3,ents.FindByClass("npc_headcrab"))
		local tb5 = table.Add(tb4,ents.FindByClass("npc_poisonzombie"))
		local tb6 = table.Add(tb5,ents.FindByClass("npc_headcrab_black"))
		for a, b in pairs( tb6 ) do   
			local newpos = b:GetPos() + ((playerDist(b):GetPos()-b:GetPos()):Normalize()*500)
			if (playerDist(b):GetPos():Distance( b:GetPos() ) > 500) then
				b:AddEntityRelationship(playerDist(b), 1, 99)
				b:SetLastPosition(newpos)
				b:SetSchedule(71)
			end
		end
	end
end
timer.Create( "move", .5, 0, moveZombie)
timer.Stop("move")

function loadZombies()
	zombieSpawns = {}
	if( file.Exists( "DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) ) then
		local spawns = string.Explode( "\n", file.Read( "DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) );
		for k, v in pairs( spawns ) do
			if not (v == "") then
				zombieSpawns[k] = v
			end
		end
	else
	file.Write("DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt","")
	end
end

function loadTable(ply)
	ply:SetNWInt("numPoints", table.getn(zombieSpawns))
	for k, v in pairs( zombieSpawns ) do
		local Sep = (string.Explode(" " ,v))
		ply:SetNWVector( "zPoints" .. k, Vector(tonumber(Sep[1]),tonumber(Sep[2]),tonumber(Sep[3])) )
	end
end

function saveZombies()
	file.Delete("DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt")  
	file.Write("DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt","")
	for k, v in pairs( zombieSpawns ) do
		file.Write("DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt", file.Read( "DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) .. v .. "\n")  
	end
end

function removeZombie(ply, index)
	if( Admins[ply:SteamID()] ) then
		if(zombieSpawns[tonumber(index)] == nil) then
			Notify( ply, 4, 3, "Zombie Spawn " .. tostring(index) .. " does not exist." );
		else
			loadZombies()
			Notify( ply, 0, 3, "Zombie spawn removed." );
			table.remove(zombieSpawns,index)
			saveZombies()
			if (ply:GetNWBool("zombieToggle") == true) then
				loadTable(ply)
			end
		end
	else
		Notify( ply, 4, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/removezombie", removeZombie );

function addZombie(ply)
	if( Admins[ply:SteamID()] ) then
		loadZombies()
		table.insert(zombieSpawns, tostring(ply:GetPos()))
		saveZombies()
	if (ply:GetNWBool("zombieToggle") == true) then
		loadTable(ply)
	end
		Notify( ply, 0, 3, "Zombie spawn added." );
	else
		Notify( ply, 4, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/addzombie", addZombie );

function toggleZombie(ply)
	if( Admins[ply:SteamID()] ) then
	
		if( ply:GetNWBool("zombieToggle") == false) then
			loadZombies()
			ply:SetNWBool("zombieToggle", true)
			loadTable(ply)
			Notify( ply, 0, 3, "Show Zombies Enabled" );
		else
			ply:SetNWBool("zombieToggle", false)
			Notify( ply, 0, 3, "Show Zombies Disabled" );
		end
	else
		Notify( ply, 4, 3, "Must be an admin." );
	end
	return ""
end
AddChatCommand( "/showzombie", toggleZombie );

function randomSpawn()

	if( file.Exists( "DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) ) then
		local spawns = string.Explode( "\n", file.Read( "DarkRP/" .. game.GetMap() .. "_zombie_spawns.txt" ) );
		local spawnIndex = math.random( 1,table.getn(spawns) - 1)
		local Sep = (string.Explode(" " ,spawns[spawnIndex]))
		return Vector(tonumber(Sep[1]),tonumber(Sep[2]),tonumber(Sep[3]))
	else
		return Vector(0,0,0)
	end
end

function spawnZombie()
	timer.Start("move")
	if(getAliveZombie() < maxZombie) then
		if(table.getn(zombieSpawns) > 0) then
			local zombieType = math.random( 1, 5)
			// make poison zombies rare.
			if (zombieType==5 && math.random(1,3)>1) then
				zombieType = math.random(1,4)
			end
			if(zombieType == 1) then
				local zombie1 = ents.Create("npc_zombie")
				zombie1:GetTable().zomb = true
				zombie1:SetPos(randomSpawn()) 
				zombie1:Spawn()
				zombie1:Activate()
			elseif(zombieType == 2) then
				local zombie2 = ents.Create("npc_fastzombie")
				zombie2:GetTable().zomb = true
				zombie2:SetPos(randomSpawn()) 
				zombie2:Spawn()
				zombie2:Activate()
			elseif(zombieType == 3) then
				local zombie3 = ents.Create("npc_headcrab_fast")
				zombie3:GetTable().zomb = true
				zombie3:SetPos(randomSpawn()) 
				zombie3:Spawn()
				zombie3:Activate()
			elseif(zombieType == 4) then
				local zombie4 = ents.Create("npc_headcrab")
				zombie4:GetTable().zomb = true
				zombie4:SetPos(randomSpawn()) 
				zombie4:Spawn()
				zombie4:Activate()
			elseif(zombieType == 5) then
				local zombie5 = ents.Create("npc_poisonzombie")
				zombie5:GetTable().zomb = true
				zombie5:SetPos(randomSpawn()) 
				zombie5:Spawn()
				zombie5:Activate()
			end
		end
	end	
end

function getAliveZombie()

	local zombieCount = 0

	for k, v in pairs(ents.FindByClass("npc_zombie")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_fastzombie")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_antlion")) do   
		zombieCount = zombieCount + 1
	end
	
	for k, v in pairs(ents.FindByClass("npc_headcrab_fast")) do   
		zombieCount = zombieCount + 1
	end

	for k, v in pairs(ents.FindByClass("npc_headcrab")) do   
		zombieCount = zombieCount + 1
	end
	for k, v in pairs(ents.FindByClass("npc_headcrab_black")) do   
		zombieCount = zombieCount + 1
	end
	for k, v in pairs(ents.FindByClass("npc_poisonzombie")) do   
		zombieCount = zombieCount + 1
	end
	return zombieCount
end

function zombieMax( ply, args )
	args = Purify(args)
	if( Admins[ply:SteamID()] ) then
		maxZombie = tonumber(args)
		Notify( ply, 0, 3, "Max Zombies set" );
		
	end
	return "";
end
AddChatCommand( "/zombiemax", zombieMax );

function helpZombie( ply )
	if(ply:GetNWBool("helpZombie") == true) then
		ply:SetNWBool("helpZombie",false)
	else
		ply:SetNWBool("helpZombie",true)
	end
	return "";
end
AddChatCommand( "/zombiehelp", helpZombie );

function startZombie( ply )

	if( Admins[ply:SteamID()] ) then
		timer.Start("zombieControl")
		Notify( ply, 1, 3, "Zombies Enabled" );
		
	end
	return "";
end
AddChatCommand( "/enablezombie", startZombie );

function stopZombie( ply )

	if( Admins[ply:SteamID()] ) then
		timer.Stop("zombieControl")
		zombieOn = false
		timer.Stop("start2")
		zombieEnd()
		Notify( ply, 0, 3, "Zombies Disabled" );
		return "";
	end
end
AddChatCommand( "/disablezombie", stopZombie );

timer.Create( "start2", 1, 0, spawnZombie)
timer.Create( "zombieControl", 1, 0, controlZombie)
timer.Stop("start2")
timer.Stop("zombieControl")


function GM:OnNPCKilled( ent, attacker, inflictor )
	if inflictor:GetClass()=="env_physexplosion" && ValidEntity(inflictor:GetTable().attacker) then
		attacker = inflictor:GetTable().attacker
	end
	if (attacker:IsPlayer() && ent:GetTable().zomb) then
		attacker:AddMoney( CfgVars["zombiescore"] );	
		Notify( attacker, 2, 3, "$" .. CfgVars["zombiescore"] .. " For killing a zombie!" );
	end
	// copy pasta from base gamemode.
	/*
	if ( inflictor && inflictor != NULL && attacker == inflictor && (inflictor:IsPlayer() || inflictor:IsNPC()) ) then
	
		inflictor = inflictor:GetActiveWeapon()
		if ( attacker == NULL ) then inflictor = attacker end
	
	end
	*/
	local InflictorClass = "World"
	local AttackerClass = "World"
	
	if ( inflictor && inflictor != NULL ) then InflictorClass = inflictor:GetClass() end
	if ( attacker  && attacker != NULL ) then AttackerClass = attacker:GetClass() end

	if ( attacker && attacker != NULL && attacker:IsPlayer() ) then
	
		umsg.Start( "PlrKilledNPC" )
		
			umsg.String( ent:GetClass() )
			umsg.Entity( inflictor )
			umsg.Entity( attacker )
			umsg.String( inflictor:GetClass() )
		
		umsg.End()
		
	return end
	
	umsg.Start( "NPCKillNPC" )
	
		umsg.String( ent:GetClass() )
		umsg.Entity( inflictor )
		umsg.String( AttackerClass )
		umsg.String( inflictor:GetClass() )
	
	umsg.End()

end






/********************************************
|
|	Meteors
|
********************************************/




local stormOn = false

function stormStart()
	for k, v in pairs(player.GetAll()) do  
		v:PrintMessage( HUD_PRINTCENTER, "Warning Meteor Storm Approaching!" ) 
		v:PrintMessage( HUD_PRINTTALK, "Warning Meteor Storm Approaching!" ) 
	end  
end

function stormEnd()
	for k, v in pairs(player.GetAll()) do  
		v:PrintMessage( HUD_PRINTCENTER, "Meteor Storm Passing!" ) 
		v:PrintMessage( HUD_PRINTTALK, "Meteor Storm Passing!" ) 
	end  
end

function controlStorm()
	timeLeft = timeLeft - 1
	if(timeLeft < 1) then
		if(stormOn == true) then
			timeLeft = math.random( 120,180)
			stormOn = false
			timer.Stop("start")
			stormEnd()
		else
			timeLeft = math.random( 60,90)
			stormOn = true
			timer.Start("start")
			stormStart()
		end
	end

end

function startShower()

	timer.Adjust("start", math.random( .5,1.5), 0, startShower) 
	local ply = player.GetAll()[math.random(1,#player.GetAll())]
	if ValidEntity(ply) then
		attackEnt(ply)
	end

end

function attackEnt(ent)

	meteor = ents.Create("meteor")
	meteor:Spawn()
	meteor:SetTarget(ent)
end


function startStorm( ply )

	if( Admins[ply:SteamID()] ) then
		timer.Start("stormControl")
		Notify( ply, 0, 3, "Meteor Storm Enabled" );
	end
	return "";
end
AddChatCommand( "/enablestorm", startStorm );

function stopStorm( ply )

	if( Admins[ply:SteamID()] ) then
		timer.Stop("stormControl")
		stormOn = false
		timer.Stop("start")
		stormEnd()
		Notify( ply, 0, 3, "Meteor Storm Disabled" );
		return "";
	end
end
AddChatCommand( "/disablestorm", stopStorm );

timer.Create( "start", 1, 0, startShower)
timer.Create( "stormControl", 1, 0, controlStorm)

timer.Stop("start")
timer.Stop("stormControl")

