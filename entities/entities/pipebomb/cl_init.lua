
include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT.Initialize()
	killicon.AddFont("pipebomb","CSKillIcons","J",Color(100,100,100,255))
end
	
/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end


