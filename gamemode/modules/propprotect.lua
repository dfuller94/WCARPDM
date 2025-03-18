// PropProtect
/* In the same way that Chaussette hooked cleanup/undo functions, I'll do the same.
   It was and still is the single best way to get prop owners for not only props,
   but for things such as thrusters, and things from custom toolguns, or sents.
   I only really take credit for rebuilding this to work with ULX 3.21 on gamemodes,
   certain RP mods, and to work with the update. All other credit goes to Chaussette.
   Since this is just a quick build, it won't come with luxuries such as auto disconnect
   cleanup, or a buddy list, unless theres more time or something. 
   EDIT:Adding auto cleanup and list.
   Also, for compatibility with things, we'll keep the var of "PropProtection" with UniqueID */

includeCS( "propprotect/cl_init.lua" );
 
PPVars = {}

PPVars["adminoverride"] = false // admins can do everything
PPVars["allowprotection"] = true // is prop protect even turned on
PPVars["allowtoolshared"] = false // allow toolgun on map ents
PPVars["allowphysshared"] = true // allow physgun on map ents
PPVars["autoclearprops"] = true // clear the props of disconnected people
PPVars["propcleartime"] = 120 // How long before clearing disconnected players props

function SetCfgAdmin(ply,args)
	if !(ply:IsAdmin() || ply:IsSuperAdmin()) then
		ply:PrintMessage(2, "You are not an admin.")
	else
		PPVars["adminoverride"] = !PPVars["adminoverride"]
	end
end

function SetCfgTools(ply,args)
	if !(ply:IsAdmin() || ply:IsSuperAdmin()) then
		ply:PrintMessage(2, "You are not an admin.")
	else
		PPVars["allowtoolshared"] = !PPVars["allowtoolshared"]
	end
end

function SetCfgPhys(ply,args)
	if !(ply:IsAdmin() || ply:IsSuperAdmin()) then
		ply:PrintMessage(2, "You are not an admin.")
	else
		PPVars["allowphysshared"] = !PPVars["allowphysshared"]
	end
end

function SetCfgClear(ply,args)
	if !(ply:IsAdmin() || ply:IsSuperAdmin()) then
		ply:PrintMessage(2, "You are not an admin.")
	else
		PPVars["autoclearprops"] = !PPVars["autoclearprops"]
	end
end

concommand.Add( "propprotect_admin", SetCfgAdmin )
concommand.Add( "propprotect_tools", SetCfgTools )
concommand.Add( "propprotect_physgun", SetCfgPhys )
concommand.Add( "propprotect_clear", SetCfgClear )

local function GetEntOwner(ent)
	if !ValidEntity(ent) then return false end
	local owner = ent
	if ent:GetVar("PropProtection")==nil then return false end
	if ValidEntity(player.GetByUniqueID(ent:GetVar("PropProtection"))) then
		owner = player.GetByUniqueID(ent:GetVar("PropProtection"))
	end
	if owner!=ent then
		return owner
	else
		return false
	end
end

function AdminOverride(ply)
	if ( (ply:IsAdmin() || ply:IsSuperAdmin()) && PPVars["adminoverride"]) then
		return true
	else
		return false
	end
end

function NotifyPlayer( ply, msg )
	if (!timer.IsTimer(ply:SteamID() .. msg)) then
		timer.Create(ply:SteamID() .. msg, 5, 1, timer.Remove, ply:SteamID() .. msg)
		ply:PrintMessage( 2, msg );
		ply:SendLua( "GAMEMODE:AddNotify(\"" .. msg .. "\", " .. 1 .. ", " .. 3 .. ")" );
	end
end

local function SetOwner(ent, ply)
	// take no chances, check it here too.
	if (ValidEntity(ent) && ValidEntity(ply) && ply:IsPlayer()) then
		ent:SetVar("PropProtection", ply:UniqueID() )
		return true
	else
		return false
	end
end

local originalCleanup = cleanup.Add
function cleanup.Add(ply,type,ent)
	if (ValidEntity(ply) && ply:IsPlayer() && ValidEntity(ent)) then
		SetOwner(ent, ply)
	end
	originalCleanup(ply,type,ent)
end

local Undostuff

local originalUndoCreate = undo.Create
function undo.Create(stuff)
	Undostuff = {}
	Undostuff.ents = {}
	originalUndoCreate(stuff)
end

local originalUndoAdd = undo.AddEntity
function undo.AddEntity(ent)
	if (Undostuff && ValidEntity(ent)) then
		table.insert(Undostuff.ents, ent)
	end
	originalUndoAdd(ent)
end

local originalUndoPlayer = undo.SetPlayer
function undo.SetPlayer(ply)
	if(Undostuff && ValidEntity(ply) && ply:IsPlayer()) then
		Undostuff.Player = ply
	end
	originalUndoPlayer(ply)
end

local originalUndoFinish = undo.Finish
function undo.Finish(text)
	if (Undostuff && Undostuff.Player:IsPlayer() && Undostuff.ents ) then
		for k, v in pairs(Undostuff.ents) do
			SetOwner(ent, ply)
		end
	end
	originalUndoFinish(text)
end

// Time to start hooking shit. Let's start with physgun reload, since that was the one thing that slipped by.

local function PhysgunReloadPP(gun, ply)
	local trace = ply:GetEyeTrace()
	if (!ValidEntity(trace.Entity)) then
		return false
	end
	local ent = trace.Entity
	local owner = GetEntOwner(ent)
	if (ply==owner || (owner==false && PPVars["allowphysshared"]) || AdminOverride(ply)) then
		// return true
	else
		if (owner==false) then
			NotifyPlayer(ply, "This prop belongs to the world!" )
		else
			NotifyPlayer(ply, "This prop belongs to " .. owner:Nick() )
		end
		return false
	end
end
hook.Add("PhysgunReload", "PropProtectReload", PhysgunReloadPP)

local function PhysgunPickupPP(ply, ent)
	if !ValidEntity(ent) then return false end
	local owner = GetEntOwner(ent)
	if (ply==owner || CanPropTouch(owner,ply) || (owner==false && PPVars["allowphysshared"]) || AdminOverride(ply)) then
		// return true
	else
		if (owner==false) then
			NotifyPlayer(ply, "This prop belongs to the world!" )
		else
			NotifyPlayer(ply, "This prop belongs to " .. owner:Nick() )
		end
		return false
	end
end
hook.Add("PhysgunPickup", "PropProtectPhys", PhysgunPickupPP)

local function GravGunPickupAllowedPP(ply, ent)
	if !ValidEntity(ent) then return false end
	local owner = GetEntOwner(ent)
	if ((ply==owner || CanPropTouch(owner,ply) || (owner==false && PPVars["allowphysshared"]) && !ent:IsPlayer()) || AdminOverride(ply)) then
		// return true
	else
		if (owner==false) then
			NotifyPlayer(ply, "This prop belongs to the world!" )
		else
			NotifyPlayer(ply, "This prop belongs to " .. owner:Nick() )
		end
		return false
	end
end
// yes, that says gravy.
hook.Add("GravGunPickupAllowed", "PropProtectGravy", GravGunPickupAllowedPP)

local function GravGunPuntPP(ply, ent)
	if !ValidEntity(ent) then return false end
	local owner = GetEntOwner(ent)
	if ((ply==owner || CanPropTouch(owner,ply)  || (owner==false && PPVars["allowphysshared"]) && !ent:IsPlayer()) || AdminOverride(ply)) then
		// return true
	else
		return false
	end
end
hook.Add("GravGunPunt", "PropProtectPunt", GravGunPuntPP)

local function CanToolPP(ply, trace, tool)
	// catch faggots trying to use nail/slider to exploit
	local subtrace = {}
	local owner2 = ply
	local owner = ply
	if (ValidEntity(trace.Entity)) then
		owner = GetEntOwner(trace.Entity)
	end
	if (tool=="nail") then
		subtrace.start = trace.HitPos
		subtrace.endpos = subtrace.start + (ply:GetAimVector() * 16)
		if ValidEntity(trace.Entity) then
			subtrace.filter = { ply, trace.Entity }
		else
			subtrace.filter = ply
		end
		subtrace = util.TraceLine(subtrace)
		if ValidEntity(subtrace.Entity) then
			owner2 = GetEntOwner(subtrace.Entity)
		end
	elseif (tool=="slider" || tool=="hydraulic" || tool=="muscle" || tool=="winch") then
		subtrace.start = trace.HitPos
		subtrace.endpos = subtrace.start + (trace.HitNormal * 16385)
		if ValidEntity(trace.Entity) then
			subtrace.filter = { ply, trace.Entity }
		else
			subtrace.filter = ply
		end
		subtrace = util.TraceLine(subtrace)
		if ValidEntity(subtrace.Entity) then
			owner2 = GetEntOwner(subtrace.Entity)
		end
	end
	// to let people weld their things to floor for example.
	if (!ValidEntity(trace.Entity) && !ValidEntity(subtrace.Entity)) then return true end
	local canhitit1 = false
	local canhitit2 = false
	if (!ValidEntity(trace.Entity) || ply==owner) then
		canhitit1 = true
	end
	if (!ValidEntity(subtrace.Entity) || ply==owner2) then
		canhitit2 = true
	end
	local canhitit = false
	if (canhitit1 && canhitit2) then canhitit = true end
	if ((canhitit || CanPropTouch(owner,ply) || (owner==false && owner2==false && PPVars["allowtoolshared"]) && !ent:IsPlayer()) || AdminOverride(ply)) then
		// return true
	else
		if (owner==false) then
			NotifyPlayer(ply, "This prop belongs to the world!" )
		elseif (owner!=ply) then
			NotifyPlayer(ply, "This prop belongs to " .. owner:Nick() )
		end
		if (owner2==false) then
			NotifyPlayer(ply, "This prop belongs to the world!" )
		elseif (owner2!=ply) then
			NotifyPlayer(ply, "This prop belongs to " .. owner2:Nick() )
		end
		return false
	end
end

hook.Add("CanTool", "PropProtectTool", CanToolPP)

function CanPropTouch(owner,ply)
	if owner==false then return false end
	if tonumber(ply:GetInfo("propprotect_access_pl"..owner:EntIndex()))==1 && tonumber(owner:GetInfo("propprotect_access_pl"..ply:EntIndex()))==1 then
		return true
	else
		return false
	end
end

local function PlyConnectPP(ply)
	if timer.IsTimer("PPClear_"..tostring(ply:UniqueID())) then
		ply:PrintMessage(HUD_PRINTTALK, "Welcome back. Your props are still here.")
		timer.Destroy("PPClear_"..tostring(ply:UniqueID()))
	end
end
hook.Add("PlayerInitialSpawn", "PropProtectPlyConnect", PlyConnectPP)

local function PlyDisconnectPP(ply)
	if PPVars["autoclearprops"] then
		timer.Create("PPClear_"..tostring(ply:UniqueID()), PPVars["propcleartime"], 1, PPClearProps, ply:UniqueID(), ply:GetName())
	end
	for k, v in pairs(player.GetAll()) do
		if ValidEntity(v) then
			v:ConCommand("propprotect_access_pl"..ply:EntIndex().." 0\n")
		end
	end
end
hook.Add("PlayerDisconnected", "PropProtectPlyDisconnect", PlyDisconnectPP)

function PPClearProps(ownerid, name)
	if ownerid=="FUCKINGEVERYONE" then
		name = "All disconnected player"
		for k, v in pairs(ents.GetAll()) do
			if v:GetVar("PropProtection")!=nil && !ValidEntity(player.GetByUniqueID(v:GetVar("PropProtection"))) then
				v:Remove()
			end
		end
	else
		for k, v in pairs(ents.GetAll()) do
			if v:GetVar("PropProtection")==ownerid then
				v:Remove()
			end
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK, name.."'s props have been removed")
	end
end

function ClearAllDisconnectedProps(ply)
	if ply:IsAdmin() || ply:IsSuperAdmin() then
		PPClearProps("FUCKINGEVERYONE", "your mother.")
	end
end
concommand.Add( "propprotect_clearoldprops", ClearAllDisconnectedProps ) 