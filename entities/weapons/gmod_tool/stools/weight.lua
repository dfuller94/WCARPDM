/*
Weight STool 1.21
	by Spoco
*/

TOOL.Category		= "Construction"
TOOL.Name			= "#Weight"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar["set"] = "1"

if CLIENT then
	language.Add( "Tool_weight_name", "Weight Tool" )
	language.Add( "Tool_weight_desc", "Sets objects weight" )
	language.Add( "Tool_weight_0", "Primary: Set   Secondary: Copy   Reload: Reset" )
	language.Add( "Tool_weight_set", "Weight:" )
	language.Add( "Tool_weight_set_desc", "Set the weight" )
	language.Add( "Tool_weight_zeromass", "Mass must be above 0!" )
end

if SERVER and not Weights then Weights = {} end

local function SetMass( Player, Entity, Data )
	if not SERVER then return end

	if Data.Mass then
		local physobj = Entity:GetPhysicsObject()
		if physobj:IsValid() then physobj:SetMass(Data.Mass) end
	end
	
	duplicator.StoreEntityModifier( Entity, "mass", Data )
end

duplicator.RegisterEntityModifier( "mass", SetMass )

local function IsReallyValid(trace)
	if not trace.Entity:IsValid() then return false end
	if trace.Entity:IsPlayer() then return false end
	if SERVER and not trace.Entity:GetPhysicsObject():IsValid() then return false end
	return true
end

function TOOL:LeftClick( trace )
	if CLIENT and IsReallyValid(trace) then return true end
	if not IsReallyValid(trace) then return false end
	
	if not Weights[trace.Entity:GetModel()] then 
		Weights[trace.Entity:GetModel()] = trace.Entity:GetPhysicsObject():GetMass() 
	end
	local mass = tonumber(self:GetClientInfo("set"))
	
	if mass > 0 then
		SetMass( self:GetOwner(), trace.Entity, { Mass = mass } )
	else 
		umsg.Start("WeightSTool_1", self:GetOwner()) 
		umsg.End()
	end
	
	return true;
end

function TOOL:RightClick( trace )
	if CLIENT and IsReallyValid(trace) then return true end
	if not IsReallyValid(trace) then return end
	
	local mass = trace.Entity:GetPhysicsObject():GetMass()
	self:GetOwner():ConCommand("weight_set "..mass);
	return true;
end

function TOOL:Reload( trace )
	if CLIENT then return false end;
	if not IsReallyValid(trace) then return false end
	local pl = self:GetOwner()
	local weight = Weights[trace.Entity:GetModel()]
	if not weight then return end
	
	SetMass( self:GetOwner(), trace.Entity, { Mass = weight } )
	
	self.Weapon:EmitSound( Sound( "Airboat.FireGunRevDown" )	)
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetNormal( trace.HitNormal )
		effectdata:SetEntity( trace.Entity )
		effectdata:SetAttachment( trace.PhysicsBone )
	util.Effect( "selection_indicator", effectdata )	
	
	local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetStart( pl:GetShootPos() )
		effectdata:SetAttachment( 1 )
		effectdata:SetEntity( self.Weapon )
	util.Effect( "ToolTracer", effectdata )
	
	return false
end

function TOOL:Think()
	if CLIENT then return end;
	local pl = self:GetOwner()
	local wep = pl:GetActiveWeapon()
	if not wep:IsValid() or wep:GetClass() != "gmod_tool" or pl:GetInfo("gmod_toolmode") != "weight" then return end
	local trace = pl:GetEyeTrace()
	if not IsReallyValid(trace) then return end
	pl:SetNetworkedFloat("WeightMass", trace.Entity:GetPhysicsObject():GetMass())
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( "Header", { Text = "#Tool_weight_name", Description	= "#Tool_weight_desc" }  )

	local params = { Label = "#Presets", MenuButton = 1, Folder = "weight", Options = {}, CVars = {} }
	
	params.Options.default = { weight_set = 3 }
	table.insert( params.CVars, "weight_set" )
	
	cp:AddControl("ComboBox", params )
	cp:AddControl("Slider", { Label = "#Tool_weight_set", Type = "Numeric", Min = "1", Max = "50000", Command = "weight_set" } )
end

if CLIENT then
	
	local TipColor = Color( 250, 250, 200, 255 )

	surface.CreateFont( "coolvetica", 24, 500, true, false, "GModWorldtip" )

	local function DrawWeightTip()
		local pl = LocalPlayer()
		local wep = pl:GetActiveWeapon()
		if not wep:IsValid() or wep:GetClass() != "gmod_tool" or pl:GetInfo("gmod_toolmode") != "weight" then return end
		local trace = pl:GetEyeTrace()
		if not IsReallyValid(trace) then return end
		
		local mass = LocalPlayer():GetNetworkedFloat("WeightMass") or 0
		local text = "Weight: "..mass
	
		local pos = (trace.Entity:LocalToWorld(trace.Entity:OBBCenter())):ToScreen()
		
		local black = Color( 0, 0, 0, 255 )
		local tipcol = Color( TipColor.r, TipColor.g, TipColor.b, 255 )
		
		local x = 0
		local y = 0
		local padding = 10
		local offset = 50
		
		surface.SetFont( "GModWorldtip" )
		local w, h = surface.GetTextSize( text )
		
		x = pos.x - w 
		y = pos.y - h 
		
		x = x - offset
		y = y - offset

		draw.RoundedBox( 8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, black )
		
		
		local verts = {}
		verts[1] = { x=x+w/1.5-2, y=y+h+2 }
		verts[2] = { x=x+w+2, y=y+h/2-1 }
		verts[3] = { x=pos.x-offset/2+2, y=pos.y-offset/2+2 }
		
		draw.NoTexture()
		surface.SetDrawColor( 0, 0, 0, tipcol.a )
		surface.DrawPoly( verts )
		
		
		draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, tipcol )
		
		local verts = {}
		verts[1] = { x=x+w/1.5, y=y+h }
		verts[2] = { x=x+w, y=y+h/2 }
		verts[3] = { x=pos.x-offset/2, y=pos.y-offset/2 }
		
		draw.NoTexture()
		surface.SetDrawColor( tipcol.r, tipcol.g, tipcol.b, tipcol.a )
		surface.DrawPoly( verts )
		
		
		draw.DrawText( text, "GModWorldtip", x + w/2, y, black, TEXT_ALIGN_CENTER )
	end
	
	hook.Add("HUDPaint", "WeightWorldTip", DrawWeightTip)
	
	function ZMass()
		LocalPlayer():ConCommand("weight_set 1")
		GAMEMODE:AddNotify("#Tool_weight_zeromass", NOTIFY_ERROR, 6);
		surface.PlaySound( "buttons/button10.wav" )
	end
	usermessage.Hook("WeightSTool_1", ZMass)
end






