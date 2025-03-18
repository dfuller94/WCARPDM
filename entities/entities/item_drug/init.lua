AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/glassjug01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end

    self:SetVar("damage", 10)
    self.Time = CurTime()

    -- Timer to remove the drug after 180 seconds
    timer.Create("DrugRemove_" .. self:EntIndex(), 180, 1, function()
        if IsValid(self) then self:Remove() end
    end)
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end

    if DrugPlayer then -- Ensure DrugPlayer function exists
        DrugPlayer(caller)
    else
        print("[ERROR] DrugPlayer function is missing! Make sure it's defined.")
    end

    -- Heal the player
    caller:SetHealth(math.min(caller:Health() + math.random(5, 15), caller:GetMaxHealth() * 1.1))

    -- Remove the entity after being used
    self:Remove()
end

function ENT:Think()
    -- No special logic needed in Think
end

function ENT:IsDrug()
    return true
end

function ENT:OnRemove()
    timer.Remove("DrugRemove_" .. self:EntIndex())
end
