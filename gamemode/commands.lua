function ccSWEPSpawn(ply, cmd, args)
    if CfgVars["adminsweps"] == 1 then
        if not ply:IsAdmin() and not ply:IsSuperAdmin() then
            Notify(ply, 4, 2, "Admin-Only!")
            return
        end
    end

    if not args[1] then
        Notify(ply, 1, 2, "Invalid SWEP name.")
        return
    end

    PrintMessage(HUD_PRINTCONSOLE, ply:GetName() .. " spawned weapon " .. args[1] .. "\n")

    ply:Give(args[1])
end
concommand.Add("gm_giveswep", ccSWEPSpawn)
concommand.Add("gm_spawnswep", ccSWEPSpawn)

function ccSENTSpawn(ply, cmd, args)
    if CfgVars["adminsents"] == 1 then
        if not ply:IsAdmin() and not ply:IsSuperAdmin() then
            Notify(ply, 4, 2, "Admin-Only!")
            return
        end
    end

    if not args[1] then
        Notify(ply, 1, 2, "Invalid SENT name.")
        return
    end

    local sentName = args[1]
    local ent = ents.Create(sentName)

    if not IsValid(ent) then
        Notify(ply, 1, 2, "Failed to spawn SENT: " .. sentName)
        return
    end

    ent:SetPos(ply:GetEyeTrace().HitPos + Vector(0, 0, 10))
    ent:SetAngles(Angle(0, 0, 0))
    ent:Spawn()
    ent:Activate()

    if IsValid(ply) then
        ent:SetCreator(ply)
    end

    Notify(ply, 2, 2, "Spawned SENT: " .. sentName)
end
concommand.Add("gm_spawnsent", ccSENTSpawn)

function Magnet(pl, pos, angle, model, material, key, maxobjects, strength, nopull, allowrot, alwayson, toggle, Vel, aVel, frozen)
    if not gamemode.Call("PlayerSpawnMagnet", pl, model) then return end

    local magnet = ents.Create("phys_magnet")
    if not IsValid(magnet) then return end

    magnet:SetPos(pos)
    magnet:SetAngles(angle)
    magnet:SetModel(model)
    magnet:SetMaterial(material)

    local spawnflags = 4
    if nopull > 0 then spawnflags = spawnflags - 4 end -- No pull required
    if allowrot > 0 then spawnflags = spawnflags + 8 end

    magnet:SetKeyValue("maxobjects", maxobjects)
    magnet:SetKeyValue("forcelimit", strength)
    magnet:SetKeyValue("spawnflags", spawnflags)
    magnet:SetKeyValue("overridescript", "surfaceprop,metal")
    magnet:SetKeyValue("massScale", 0)

    magnet:Activate()
    magnet:Spawn()

    if magnet:GetPhysicsObject():IsValid() then
        local phys = magnet:GetPhysicsObject()
        if Vel then phys:SetVelocity(Vel) end
        if aVel then phys:AddAngleVelocity(aVel) end
        phys:EnableMotion(not frozen)
    end

    if alwayson > 0 then
        magnet:Input("TurnOn", nil, nil, nil)
    else
        magnet:Input("TurnOff", nil, nil, nil)
    end

    magnet:SetTable({
        model = model,
        material = material,
        key = key,
        maxobjects = maxobjects,
        strength = strength,
        nopull = nopull,
        allowrot = allowrot,
        alwayson = alwayson,
        toggle = toggle
    })

    numpad.OnDown(pl, key, "MagnetOn", magnet)
    numpad.OnUp(pl, key, "MagnetOff", magnet)

    gamemode.Call("PlayerSpawnedMagnet", pl, model, magnet)
    return magnet
end

duplicator.RegisterEntityClass("phys_magnet", Magnet, "pos", "angle", "model", "material", "key", "maxobjects", "strength", "nopull", "allowrot", "alwayson", "toggle", "Vel", "aVel", "frozen")
