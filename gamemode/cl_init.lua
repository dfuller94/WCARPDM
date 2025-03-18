
DeriveGamemode( "sandbox" );

drugeffect_doubletapmod = 0.675

GUIToggled = false;
HelpToggled = false;

HelpLabels = { }
HelpCategories = { }

AdminTellAlpha = -1;
AdminTellStartTime = 0;
AdminTellMsg = "";

MoneyAlpha = -1
MoneyY = 0
MoneyAmount = 0

MyMoney = "If you can see this, you should reconnect."

MobAgenda = " "

afkbigness = 255
afkdir = true
local Extracrap = { }

if( HelpVGUI ) then
	HelpVGUI:Remove();
end

HelpVGUI = nil;

StunStickFlashAlpha = -1;

local viewpl = nil
local viewpltime = 0

local viewstructure = nil
local viewstructuretime = 0

surface.CreateFont( "ChatFont", 72, 700, true, false, "AFKFont" );
// make it so that the small message font isnt too small to read for people with high res
local tsize = 12
if ScrW()>1000 then
	tsize=16
end
surface.CreateFont( "Default", tsize, 500, true, false, "MessageFont")


function GM:Initialize()

	self.BaseClass:Initialize();

end

function LoadModules( msg )

	local num = msg:ReadShort();
	
	for n = 1, num do
	
		include( "DarkRP/gamemode/modules/" .. msg:ReadString() );
	
	end

end
usermessage.Hook( "LoadModules", LoadModules );

include( "cl_deaths.lua" );
include( "shared.lua" );
include( "cl_vgui.lua" );
include( "cl_helpvgui.lua" );
include( "entity.lua" );
include( "cl_scoreboard.lua" );
include( "cl_msg.lua" );
include( "cl_menu.lua" );
include("swep_fix.lua");

surface.CreateFont( "akbar", 20, 500, true, false, "AckBarWriting" );
surface.CreateFont( "HalfLife2", 96, 500, true, false, "HL2Symbols" );

function GetTextHeight( font, str )

	surface.SetFont( font );
	local w, h = surface.GetTextSize( str );
	
	return h;
	
end

local function DrawBox(startx, starty, sizex, sizey, color1,color2 )
	draw.RoundedBox( 0, startx, starty, sizex, sizey, color2 )
	draw.RoundedBox( 0, startx+1, starty+1, sizex-2, sizey-2, color1 )
end

function DrawPlayerInfo( ply, scn )

	if( not ply:Alive() ) then return; end

	local pos = ply:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
	draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
	draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
	draw.DrawText( ply:GetNWString( "job" ), "TargetID", pos.x + 1, pos.y + 21, Color( 0, 0, 0, 255 ), 1 );
	draw.DrawText( ply:GetNWString( "job" ), "TargetID", pos.x, pos.y + 20, Color( 255, 255, 255, 200 ), 1 );
	local mudkips = 0
	if (ply:GetNWInt("hitlist")>0 && (LocalPlayer():Team()==4 || LocalPlayer():Team()==5 || LocalPlayer():Team()==11)) then
		draw.DrawText( "Hit Target!", "TargetID", pos.x, pos.y+40, Color( 255, 255, 255, 200 ), 1 );
		draw.DrawText( "Hit Target!", "TargetID", pos.x + 1, pos.y+41, Color( 100, 100, 100, 255 ), 1 );
		mudkips = 20
	end
	if scn then
		local weapn = ply:GetActiveWeapon()
		local wepclass = "Nothing"
		local wepammo = 0
		if ValidEntity(weapn) then
			wepclass = weapn:GetClass()
			wepammo = weapn:Clip1()
		end
		draw.DrawText( "H: " .. tostring(ply:Health()) .. " A: " .. tostring(ply:Armor()) .. "\n" .. wepclass .. " " .. wepammo, "TargetID", pos.x + 1, pos.y + 41+mudkips, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( "H: " .. tostring(ply:Health()) .. " A: " .. tostring(ply:Armor()) .. "\n" .. wepclass .. " " .. wepammo, "TargetID", pos.x, pos.y+40+mudkips, Color(120,120,120,255), 1 );
	end
end

local Scans = {}

function ScannerSweep(msg)
	local ply = msg:ReadEntity()
	local pos = msg:ReadVector()
	local num = msg:ReadShort()
	Scans[num] = {}
	Scans[num].Time = CurTime()+10
	Scans[num].Pos = pos
	Scans[num].Ply = ply
	//timer.Create(tostring(num).."Oldscan", 10, 1, clearscan, num)
end
usermessage.Hook("RadarScan", ScannerSweep)

function clearscan(index)
	//Msg(player.GetByID(index):GetName().."\n")
	Scans[index] = nil
end

function DrawScans()
	for k, v in pairs(Scans) do
		if v!=nil then
			local ply = v.Ply
			if ValidEntity(ply) then
				local pos = v.Pos + Vector(0,0,100)
				
				pos = pos:ToScreen();
				draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
				draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
				draw.DrawText( "SCAN", "TargetID", pos.x + 1, pos.y-16 + 1, Color( 0, 0, 0, 255 ), 1 );
				draw.DrawText( "SCAN", "TargetID", pos.x, pos.y-16, Color(255,0,0,255 ), 1 );
			end
			if v.Time<CurTime() then
				clearscan(k)
			end
		end
	end
end


function DrawBombInfo( ent )
	if LocalPlayer():GetPos():Distance(ent:GetPos())<2048 && ent:GetNWBool("armed") then
		local pos = ent:GetPos()+ent:GetAngles():Up()*30;
		
		pos.z = pos.z + 14;
		pos = pos:ToScreen();
		local time = math.ceil(ent:GetNWFloat("goofytiem")-CurTime())
		if time<=2 then
			time = "YOU JUST LOST\nTHE GAME"
		end
		draw.DrawText( "BOMB\n" .. tostring(time), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( "BOMB\n" .. tostring(time), "TargetID", pos.x, pos.y, Color(255,0,0,255), 1 );
	end
end

function DrawStructureInfo( ent, alpha )
	local pos = ent:GetPos();
	
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
	DrawBox(pos.x-100, pos.y-50, 200, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
	local power = ent.Power
	local upgradestring = ""
	local upgrade = ent:GetNWInt("upgrade")
	if upgrade==1 then
		upgradestring= "I"
	elseif upgrade==2 then
		upgradestring = "II"
	elseif upgrade==3 then
		upgradestring = "III"
	elseif upgrade==4 then
		upgradestring = "IV"
	elseif upgrade==5 then
		upgradestring = "V"
	elseif upgrade==6 then
		upgradestring = "VI"
	elseif upgrade==7 then
		upgradestring = "VII"
	elseif upgrade==8 then
		upgradestring = "VIII"
	elseif upgrade==9 then
		upgradestring = "IX"
	elseif upgrade==10 then
		upgradestring = "X"
	end
	draw.DrawText(ent.PrintName, "TargetID", pos.x-9,pos.y-49, Color(0,0,0,alpha*2.55),1)
	draw.DrawText(ent.PrintName, "TargetID", pos.x-10,pos.y-50, Color(100,150,200,alpha*2.55),1)
	draw.RoundedBox(0,pos.x-100,pos.y-28, 200, 1, Color(50,50,50,alpha*1.5))
	draw.RoundedBox(0,pos.x-100,pos.y+27, 200, 1, Color(50,50,50,alpha*1.5))
	if upgrade>0 then
		draw.DrawText(upgradestring, "Default", pos.x+91,pos.y-45, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(upgradestring, "Default", pos.x+90,pos.y-46, Color(200,200,0,alpha*2.55),1)
	end
	local pwr = false
	for i=1,power,1 do
		draw.DrawText( "Z", "HL2Symbols", pos.x-89+(i*30), pos.y-74, Color(0,0,0,alpha*1.55), 1 );
		if ent:GetNWInt("power")>=i then
			draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(0,255,0,alpha*1.55), 1 );
		else
			pwr = true
			draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(90,90,90,alpha*1.55), 1 );
		end
	end
	if pwr then
		draw.DrawText("Low power.", "TargetID", pos.x-9,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText("Low power.", "TargetID", pos.x-10,pos.y, Color(150,0,0,alpha*2.55),1)
	end
	if ent:GetTable().TimeToFinish!=nil && ent:GetClass()=="gunfactory" && ent:GetTable().TimeToFinish>CurTime() then
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+79,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+80,pos.y, Color(150,150,150,alpha*2.55),1)
	end
	if ent:GetClass()=="powerplant" then
		for i=1,5,1 do
			draw.DrawText( "Z", "HL2Symbols", pos.x-89+(i*30), pos.y-74, Color(0,0,0,alpha*1.55), 1 );
			if ValidEntity(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				render.SetMaterial(Material('cable/redlaser'))
				render.DrawBeam( ent:GetPos(), ent:GetNWEntity("socket"..tostring(i)), 2, 0, 0, Color(255,255,255,255) )
				draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end
	local owner = ent:GetNWEntity("owner")
	// lol redundant
	if ValidEntity(owner) then owner = owner:GetName() else owner = "World" end
	draw.DrawText(owner, "TargetID", pos.x+1,pos.y+26, Color(0,0,0,alpha*2.55),1)
	draw.DrawText(owner, "TargetID", pos.x,pos.y+25, Color(100,100,100,alpha*2.55),1)
end

function DrawWarrantInfo( ply )

	if( not ply:Alive() ) then return; end

	local pos = ply:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
	// lol @ people actually looking through this.
	local mudkips = 0	
	draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
	draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
	if (ply:GetNWBool("warrant")==true) then
		mudkips = 20
		draw.DrawText( "Warrant!", "TargetID", pos.x, pos.y - 20, Color( 255, 255, 255, 200 ), 1 );
		draw.DrawText( "Warrant!", "TargetID", pos.x + 1, pos.y - 21, Color( 255, 0, 0, 255 ), 1 );
	end

end

function DrawZombieInfo( ply )

		for x=1, LocalPlayer():GetNWInt("numPoints"), 1 do
			local zPoint = LocalPlayer():GetNWVector( "zPoints" .. x)
			zPoint = zPoint:ToScreen();
			draw.DrawText( "Zombie Spawn (" .. x .. ")", "TargetID", zPoint.x, zPoint.y - 20, Color( 255, 255, 255, 200 ), 1 );
			draw.DrawText( "Zombie Spawn (" .. x .. ")", "TargetID", zPoint.x + 1, zPoint.y - 21, Color( 255, 0, 0, 255 ), 1 );
		end
end

function DrawBombs()
	for k, v in pairs(ents.FindByClass("bigbomb")) do
		if v:GetNWBool("armed") then
		end
	end
end

function GM:HUDPaint()
	DrawDrugs()

	self.BaseClass:HUDPaint();
	self:PaintMessages()
	
	local hx = 9;
	local hy = ScrH() - 25;
	local hw = 190;
	local hh = 10;

	draw.RoundedBox( 0, hx - 4, hy - 4, hw + 8, hh + 8, Color( 0, 0, 0, 200 ) );
	
	if( LocalPlayer():Health() > 0 ) then
		
		draw.RoundedBox( 0, hx, hy, math.Clamp( hw * ( LocalPlayer():Health() / 100 ), 0, 190 ), hh, Color( 140, 0, 0, 180 ) );
	end
	
	draw.DrawText( LocalPlayer():Health(), "TargetID", hx + hw / 2, hy - 6, Color( 255, 255, 255, 200 ), 1 );
	
	draw.DrawText( "Job: " .. LocalPlayer():GetNWString( "job" ) .. "\n$" .. tostring(MyMoney), "TargetID", hx+200 + 2, hy - 24, Color( 0, 0, 0, 200 ), 0 );
	draw.DrawText( "Job: " .. LocalPlayer():GetNWString( "job" ) .. "\n$" .. tostring(MyMoney), "TargetID", hx+200, hy - 25, Color( 255, 255, 255, 200 ), 0 );
	
	// Current Armor has to be a networked var, because player:Armor() doesn't do shit clientside.
	// ok so this was fixed. well too late. fuckit.
	// lets do nonsensical shit such as player:SetHealth(player:Health()+(100-player:Health()))
	if( LocalPlayer():Armor() > 0 ) then
		draw.RoundedBox( 0, hx-4, hy - 14, 198, 10, Color( 0, 0, 0, 200 ) );
		draw.RoundedBox( 0, hx, hy-10, 190 * ( math.Clamp( LocalPlayer():Armor(), 0, 100 ) / 100 ), 10, Color( 0, 0, 150, 255 ) );
		draw.DrawText( math.ceil( LocalPlayer():Armor() ), "DefaultSmall", hx + 100, hy - 12, Color( 255, 255, 255, 255 ), 1 );
	end
	
	local function DrawDisplay()
		for k, v in pairs( player.GetAll() ) do
			if(v:GetNWBool("zombieToggle") == true) then
				DrawZombieInfo(v)
			end
			/*
			if(v:GetNWBool("warrant") == true || (v:GetNWInt("hitlist") > 0 && (LocalPlayer():Team()==4 || LocalPlayer():Team()==5 || LocalPlayer():Team()==11))) then
				DrawWarrantInfo( v )
			end
			*/
			end
			
		local tr = LocalPlayer():GetEyeTrace();
		for k, v in pairs( ents.FindByClass("bigbomb") ) do
			
			DrawBombInfo( v );
			
		end
		DrawScans()
		
		if !ValidEntity(tr.Entity) && ValidEntity(viewpl) && viewpltime>CurTime() && LocalPlayer():GetNWBool("scannered") then
			DrawPlayerInfo(viewpl,LocalPlayer():GetNWBool("scannered"))
		end
		if( tr.Entity!=nil and tr.Entity:IsValid() and tr.Entity:GetPos():Distance( LocalPlayer():GetPos() ) <= 768 ) then
		
			if( tr.Entity:IsPlayer() ) then
				viewpl = tr.Entity
				viewpltime = CurTime()+.5
				local scanner = LocalPlayer():GetNWBool("scannered")
				if(tr.Entity:GetPos():Distance(LocalPlayer():GetPos())<512 || scanner) then
					DrawPlayerInfo( tr.Entity,scanner );
				end
					
			elseif (tr.Entity:GetTable().Structure) then
				viewpltime = 0
				/*
				if tr.Entity:GetTable().HealthRadius!=nil then
					DrawStructureHealth(tr.Entity)
				end*/
				if viewstructure==tr.Entity then
					viewstructuretime = viewstructuretime+30*FrameTime()
				else
					viewstructure = tr.Entity
					viewstructuretime = 0
				end
				if viewstructuretime>=30 then
					local scanner = LocalPlayer():GetNWBool("scannered")
					if(tr.Entity:GetPos():Distance(LocalPlayer():GetPos())<256) then
						DrawStructureInfo( tr.Entity, math.Clamp((viewstructuretime-30)*5, 0, 100) );
					end
				end
			else
				if ValidEntity(viewpl) && viewpltime>CurTime() && LocalPlayer():GetNWBool("scannered") then
					DrawPlayerInfo(viewpl,LocalPlayer():GetNWBool("scannered"))
				end
				viewstructure = nil
				viewstructuretime = 0
			end
			if( tr.Entity:IsOwnable() ) then
			
				local ent = ents.GetByIndex( tr.Entity:EntIndex() );
			
				pos = LocalPlayer():GetEyeTrace().HitPos:ToScreen();
				
				local ownerstr = "";
				
				if( ent:GetNWInt( "Owner" ) > 0 ) then
					if( player.GetByID( ent:GetNWInt( "Owner" ) ):IsValid() ) then
						ownerstr = player.GetByID( ent:GetNWInt( "Owner" ) ):Nick() .. "\n";
					end
				end
				
				local num = ent:GetNWInt( "OwnerNum" );
				
				for n = 1, num do
				
					if( ( ent:GetNWInt( "Owners" .. n ) or -1 ) > -1 ) then
						if( player.GetByID( ent:GetNWInt( "Owners" .. n ) ):IsValid() ) then
							ownerstr = ownerstr .. player.GetByID( ent:GetNWInt( "Owners" .. n ) ):Nick() .. "\n";
						end
					end
				
				end
				
				num = ent:GetNWInt( "AllowedNum" );
				
				for n = 1, num do
				
					if( ent:GetNWInt( "Allowed" .. n ) == LocalPlayer():EntIndex() ) then
					
						ownerstr = ownerstr .. "You are allowed to co-own this door (Press F4 to own)";
					
					elseif( ent:GetNWInt( "Allowed" .. n ) > -1 ) then
					
						if( player.GetByID( ent:GetNWInt( "Allowed" .. n ) ):IsValid() ) then
							ownerstr = ownerstr .. player.GetByID( ent:GetNWInt( "Allowed" .. n ) ):Nick() .. " is allowed to co-own this door\n";
						end
					end
				
				end

				if( ent:IsOwned() ) then
					draw.DrawText( ent:GetNWString( "title" ) .. "\nOwned by:\n" .. ownerstr, "TargetID", pos.x + 1, pos.y + 1, Color( 0,  0, 0, 200 ), 1 );
					draw.DrawText( ent:GetNWString( "title" ) .. "\nOwned by:\n" .. ownerstr, "TargetID", pos.x, pos.y, Color( 255, 255, 255, 200 ), 1 );
				else
					draw.DrawText( "Unowned (Press F4 to own)", "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
					draw.DrawText( "Unowned (Press F4 to own)", "TargetID", pos.x, pos.y, Color( 128, 30, 30, 255 ), 1 );
				end
			
			end
	
		else
			viewstructure = nil
			viewstructuretime = 0
		end
		if( PanelNum > 0 ) then
		
			draw.RoundedBox( 2, 0, 0, 100, 20, Color( 0, 0, 0, 128 ) );
			draw.DrawText( "Hit F3 to vote", "ChatFont", 2, 2, Color( 255, 255, 255, 200 ), 0 );
		
		end
		
	end
	
	if( MoneyAlpha >= 0 ) then
		mul=-0.1
		if MoneyAmount<0 then
			draw.DrawText( tostring(MoneyAmount), "TargetID", 11, MoneyY + 1, Color( 0, 0, 0, MoneyAlpha ), 0 );
			draw.DrawText( tostring(MoneyAmount), "TargetID", 10, MoneyY, Color( 150, 20, 20, MoneyAlpha ), 0 );
		else
			draw.DrawText( "+" .. tostring(MoneyAmount), "TargetID", 11, MoneyY + 1, Color( 0, 0, 0, MoneyAlpha ), 0 );
			draw.DrawText( "+" .. tostring(MoneyAmount), "TargetID", 10, MoneyY, Color( 20, 150, 20, MoneyAlpha ), 0 );
		end
		MoneyAlpha = math.Clamp( MoneyAlpha - (255 * FrameTime()), -1, 255 );
		MoneyY = MoneyY - (50*FrameTime())
	
	end
	
	if( LocalPlayer():GetNWBool("AFK") ) then
		draw.DrawText( "You are AFK!", "AFKFont", ScrW()*0.5+3, ScrH()*0.5+3-40, Color( 0, 0, 0, afkbigness ), 1 );
		draw.DrawText( "You are AFK!", "AFKFont", ScrW()*0.5, ScrH()*0.5-40, Color( 255, 0, 0, afkbigness ), 1 );
		draw.DrawText( "AS LONG AS YOU DON'T MOVE OR SAY ANYTHING\nYOU WILL LOSE MONEY INSTEAD OF GAIN IT!", "ChatFont", ScrW()*0.5+1, ScrH()*0.5+1+60, Color( 0, 0, 0, 155 ), 1 );
		draw.DrawText( "AS LONG AS YOU DON'T MOVE OR SAY ANYTHING\nYOU WILL LOSE MONEY INSTEAD OF GAIN IT!", "ChatFont", ScrW()*0.5, ScrH()*0.5+60, Color( 250, 20, 20, 255 ), 1 );
		local mul = -1
		if !afkdir then
			mul = 1
		end
		
		afkbigness = math.Clamp( afkbigness + (255*FrameTime()*mul), 0, 255 );
		if (afkbigness==255 && !afkdir) || (afkbigness==0 && afkdir) then
			afkdir = !afkdir
		end
	end
	
	if( LetterAlpha > -1 ) then
	
		if( LetterY > ScrH() * .25 ) then
		
			LetterY = math.Clamp( LetterY - 300 * FrameTime(), ScrH() * .25, ScrH() / 2 );
		
		end
		
		if( LetterAlpha < 255 ) then
		
			LetterAlpha = math.Clamp( LetterAlpha + 400 * FrameTime(), 0, 255 );
		
		end
		
		local font = "";
		
		if( LetterType == 1 ) then
			font = "AckBarWriting";
		else
			font = "Default";
		end
		
		draw.RoundedBox( 2, ScrW() * .2, LetterY, ScrW() * .8 - ( ScrW() * .2 ), ScrH(), Color( 255, 255, 255, math.Clamp( LetterAlpha, 0, 200 ) ) );
		draw.DrawText( LetterMsg, font, ScrW() * .25 + 20, LetterY + 80, Color( 0, 0, 0, LetterAlpha ), 0 );
	
	end
	
	DrawDisplay();
	
	if( AdminTellAlpha > -1 ) then
	
		local dir = 1;
		
		if( CurTime() - AdminTellStartTime > 10 ) then
			dir = -1;
			
			if( AdminTellAlpha <= 0 ) then
				AdminTellAlpha = -1;
			end
			
		end
		
		if( AdminTellAlpha > -1 ) then
		
			AdminTellAlpha = math.Clamp( AdminTellAlpha + FrameTime() * dir * 300, 0, 190 );
		
			draw.RoundedBox( 4, 10, 10, ScrW() - 20, 100, Color( 0, 0, 0, AdminTellAlpha ) );
			draw.DrawText( "The Admin Tells You:", "GModToolName", ScrW() / 2 + 10, 10, Color( 255, 255, 255, AdminTellAlpha ), 1 );
			draw.DrawText( AdminTellMsg, "ChatFont", ScrW() / 2 + 10, 65, Color( 200, 30, 30, AdminTellAlpha ), 1 );
		
		end
	
	end
	
	
	if(LocalPlayer():GetNetworkedBool("helpAdmin") == true) then

		draw.RoundedBox(10, 10, 10, 560, 230, Color(0, 0, 0, 255))  
		draw.RoundedBox(10, 12, 12, 556, 226, Color(51, 58, 51, 200))  
		draw.RoundedBox(10, 12, 12, 556, 20, Color(0, 0, 70, 200))  
		draw.DrawText("Admin Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 
		
		draw.DrawText("/zombiehelp Shows you how to setup zombie mode\n/enablestorm enables meteor storms\n/disablestorm Disables meteor storms\n\nYou can change the price of weapons, jailtimer, max gangsters, ect.\nTo do this press F1 then scroll down and you will see all of the console commands\nIf you edit the init.lua file you can save the vars.\n/jailpos sets the jailposition! (rp_adminjailpos  to set permission)\n/adminhelp toggles this menu.", "ScoreboardText", 30, 35, Color(255,255,255,255),0)

	end
	
	if(LocalPlayer():GetNetworkedBool("helpZombie") == true) then
		
		draw.RoundedBox(10, 10, 10, 860, 230, Color(0, 0, 0, 255))  
		draw.RoundedBox(10, 12, 12, 856, 226, Color(51, 58, 51, 200))  
		draw.RoundedBox(10, 12, 12, 856, 20, Color(0, 0, 70, 200))  
		draw.DrawText("Zombie Help", "ScoreboardText", 30, 12, Color(255,0,0,255),0) 
		
		draw.DrawText("/addzombie (creates a zombie spawn)\n/removezombie index (removes a zombie spawn, index is the number inside ()\n/showzombie (shows where the zombie spawns are)\n/enablezombie (enables zombiemode)\n/disablezombie (disables zombiemode)\n/zombiehelp (toggles this menu)\n\nAll the zombie commands are admin only, the spawns are saved on different maps so you\ncan have a different set of zombie spawns depending on which map you are on.\nThe zombie spawns file is located in garrysmod/data/DarkRP if it ever becomes corrupt just delete it.", "ScoreboardText", 30, 35, Color(255,255,255,255),0)
		
	end
	
	if(LocalPlayer():Team() == 4 or LocalPlayer():Team() == 5 or LocalPlayer():Team() == 11) then
		local offset = 0
		if LocalPlayer():GetInfoNum("rpdm_showmessages")==1 then
			if ScrW()>1000 then
				draw.RoundedBox( 10, 10, 180, 570, 50, Color( 30, 30, 30, 100 ) )
				offset = 170
			else
				draw.RoundedBox( 10, 10, 140, 450, 50, Color( 30, 30, 30, 100 ) )
				offset = 130
			end
		else
			if ScrW()>1000 then
				draw.RoundedBox( 10, 10, 10, 570, 50, Color( 30, 30, 30, 100 ) )
			else
				draw.RoundedBox( 10, 10, 10, 450, 50, Color( 30, 30, 30, 100 ) )
			end
			offset = 10
		end
		draw.DrawText("Mob Agenda", "MessageFont", 17, 11+offset, Color(0,0,0,255),0) 
		draw.DrawText("Mob Agenda", "MessageFont", 16, 10+offset, Color(50,50,50,255),0) 

		draw.DrawText(MobAgenda, "MessageFont", 21, 26+offset, Color(0,0,0,255),0)
		draw.DrawText(MobAgenda, "MessageFont", 20, 25+offset, Color(155,155,155,255),0)

	end
end

function GM:HUDDrawTargetID()
	
end

function GM:HUDShouldDraw( name )

	if( name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" ) then return false; end
	if( HelpToggled and name == "CHudChat" ) then return false; end
	
	return true;

end

surface.CreateFont( "ChatFont", 22, 400, true, false, "ArmorFont" );
surface.CreateFont( "csd", 32, 400, true, false, "DrugFont" );
surface.CreateFont( "Counter-Strike", 32, 400, true, false, "CSDFont");
surface.CreateFont( "HalfLife2", 50, 400, true, false, "DrugFont2" );

function DrawDrugs()
	local effects = 0
	local x = 7;
	local y = ScrH() - 36;
	
	// put a little circle at the health bar or some shit to show having snipe shield
	// better yet, a cs armor logo.
	if (LocalPlayer():GetNWBool("shielded")==true) then
		draw.DrawText( "p", "DrugFont", x+129, y-49, Color(  0,  0,  0,200), 0)
		draw.DrawText( "p", "DrugFont", x+128, y-50, Color(255,255,255,255),0)
	end
	if (LocalPlayer():GetNWBool("helmeted")==true) then
		draw.DrawText( "E", "DrugFont", x+149, y-49, Color(  0,  0,  0,200), 0)
		draw.DrawText( "E", "DrugFont", x+148, y-50, Color(255,255,255,255),0)
	end
	if (LocalPlayer():GetNWBool("scannered")==true) then
		draw.DrawText( "H", "DrugFont", x+132, y-29, Color(  0,  0,  0,200), 0)
		draw.DrawText( "H", "DrugFont", x+131, y-30, Color(255,255,255,255),0)
	end
	if (LocalPlayer():GetNWBool("tooled")==true) then
		draw.DrawText( "f", "CSDFont", x+149, y-34, Color(  0,  0,  0,200), 0)
		draw.DrawText( "f", "CSDFont", x+148, y-35, Color(255,255,255,255),0)
	end
	if (LocalPlayer():GetNWBool("nightvisioned")==true) then
		draw.DrawText( "s", "CSDFont",x+169, y-59, Color(0,0,0,200),0)
		draw.DrawText( "s", "CSDFont",x+168, y-60, Color(255,255,255,255),0)
	end
	if (LocalPlayer():GetNWBool("poisoned")==true) then
		draw.DrawText("C", "DrugFont", x+93, y-39, Color( 0,0,  0,200), 0)
		draw.DrawText("C", "DrugFont", x+92, y-40, Color(50,250,0,255),0)
	end
	
	local effectslots = {}
	effectslots[0] = 0
	effectslots[1] = 0
	effectslots[2] = 0
	
	for k,v in pairs(drugtable) do
		if LocalPlayer():GetNWBool(drugtable[k].string)==true then
			local offset = 0
			local soffset = 0
			local soffset2 = 0
			if k=="leech" then soffset=-1 soffset2=5 end
			if k=="focus" then soffset=-5 end
			if drugtable[k].font == "DrugFont2" then offset = -25 end
			
			draw.DrawText(drugtable[k].symbol, drugtable[k].font, x+soffset+(effectslots[drugtable[k].type]*20)-1, y-60+soffset2+(drugtable[k].type*20)+offset-1, Color(0,0,0,200), 0)
			draw.DrawText(drugtable[k].symbol, drugtable[k].font, x+soffset+(effectslots[drugtable[k].type]*20), y-60+soffset2+(drugtable[k].type*20)+offset, drugtable[k].color,0)
			effectslots[drugtable[k].type] = effectslots[drugtable[k].type]+1
		end
	end
	DrugTrails()
	
end

function DrawDrugTrail(color, ent, effect)
	local type = effect or "drug_trail"
	if type==none then return end
	local r = color.r
	local g = color.g
	local b = color.b
	if type=="drug_bolt" then
		local gun = ent:GetActiveWeapon()
		if ValidEntity(gun) then
			local attachpos = gun:GetAttachment(1)
			if attachpos!=nil then
				local effectdata = EffectData()
					effectdata:SetOrigin( attachpos.Pos )
					effectdata:SetStart( Vector( r, g, b ) )
					effectdata:SetEntity( ent )
					effectdata:SetNormal(ent:GetAimVector())
				util.Effect( effect, effectdata )
			end
		end
	else
		local effectdata = EffectData()
			effectdata:SetOrigin( ent:GetPos() )
			effectdata:SetStart( Vector( r, g, b ) )
			effectdata:SetRadius(64)
			effectdata:SetEntity( ent )
		util.Effect( effect, effectdata )
	end
end

local drawstuff = false
function DrugTrails()
	if drawstuff then
		for i, q in pairs(player.GetAll()) do
			if q!=LocalPlayer() then
				for k,v in pairs(drugtable) do
					if q:GetNWBool(drugtable[k].string)==true && math.random(1,5)>4 then
						local type="drug_trail"
						if drugtable[k].type == 1 then type="drug_glow" end
						if drugtable[k].type == 2 then type="drug_bolt" end
						DrawDrugTrail(drugtable[k].color,q,type)
					end
				end
			end
		end
	end
	drawstuff = !drawstuff
end

function EndStunStickFlash()

	StunStickFlashAlpha = -1;

end

function StunStickFlash()

	if( StunStickFlashAlpha == -1  ) then
		StunStickFlashAlpha = 0;
	end
	
	timer.Create( LocalPlayer():EntIndex() .. "StunStickFlashTimer", .3, 1, EndStunStickFlash );

end
usermessage.Hook( "StunStickFlash", StunStickFlash );

function AdminTell( msg )

	AdminTellStartTime = CurTime();
	AdminTellAlpha = 0;
	AdminTellMsg = msg:ReadString();

end
usermessage.Hook( "AdminTell", AdminTell );

LetterY = 0;
LetterAlpha = -1;
LetterMsg = "";
LetterType = 0;
LetterStartTime = 0;
LetterPos = Vector( 0, 0, 0 );

function ShowLetter( msg )

	LetterType = msg:ReadShort();
	LetterPos = msg:ReadVector();
	LetterMsg = msg:ReadString();
	LetterY = ScrH() / 2;
	LetterAlpha = 0;
	LetterStartTime = CurTime();

end
usermessage.Hook( "ShowLetter", ShowLetter );

function GM:Think()

	if( LetterAlpha > -1 and LocalPlayer():GetPos():Distance( LetterPos ) > 125 ) then
	
		LetterAlpha = -1;
	
	end

end

function KillLetter( msg )

	LetterAlpha = -1;

end
usermessage.Hook( "KillLetter", KillLetter );

function UpdateHelp()

	function tDelayHelp()

		if( HelpVGUI ) then

			HelpVGUI:Remove();
			
			if( HelpToggled ) then
				HelpVGUI = vgui.Create( "HelpVGUI" );
			end
			
		end
	
	end
	
	timer.Simple( .5, tDelayHelp );
	
end
usermessage.Hook( "UpdateHelp", UpdateHelp );

function ToggleClicker()

	GUIToggled = !GUIToggled;

	gui.EnableScreenClicker( GUIToggled );

	for k, v in pairs( VoteVGUI ) do
	
		v:SetMouseInputEnabled( GUIToggled );
	
	end

end
usermessage.Hook( "ToggleClicker", ToggleClicker );

function AddHelpLabel( msg )

	local id = msg:ReadShort();
	local category = msg:ReadShort();
	local text = msg:ReadString();
	local constant = msg:ReadShort();
	
	local function tAddHelpLabel( id, category, text, constant )

		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
		table.insert( HelpLabels, { id = id, category = category, text = text, constant = constant } );
		
	end
	
	timer.Simple( .01, tAddHelpLabel, id, category, text, constant );

end
usermessage.Hook( "AddHelpLabel", AddHelpLabel );

function ChangeHelpLabel( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();

	local function tChangeHelpLabel( id, text )
	
		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
	end
	
	timer.Simple( .01, tChangeHelpLabel, id, text );

end
usermessage.Hook( "ChangeHelpLabel", ChangeHelpLabel );

function AddHelpCategory( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();
	
	local function tAddHelpCategory( id, text )
	
		table.insert( HelpCategories, { id = id, text = text } );

	end
		
	timer.Simple( .01, tAddHelpCategory, id, text );
		
end
usermessage.Hook( "AddHelpCategory", AddHelpCategory );


function MoneyChange( msg )
	
	MoneyAmount = msg:ReadShort()
	MyMoney = msg:ReadLong()
	MoneyAlpha = 255;
	MoneyY = ScrH() - 75;
	
end
usermessage.Hook( "MoneyChange", MoneyChange );


/*==========================================================
==							  ==
==							  ==
==========================================================*/

// the damn children with microphones never shut the fuck up.
// copy pastad this from ULX admin mod, ulyssesmod.net

function Extracrap.shutUp( bool )
	if bool then
		local function stfuForce( ply, bind )
		      if string.find( bind, "+voicerecord" ) then
		         return true
                      end
		end
		hook.Add( "PlayerBindPress", "ECstfuForce", stfuForce )
		local function stfuCheck()
                         LocalPlayer():ConCommand( "-voicerecord" )
                end
		timer.Create( "STFULocalPlayer", .1, 0, stfuCheck )
                LocalPlayer():ConCommand( "-voicerecord" )
	else
		hook.Remove( "PlayerBindPress", "ECstfuForce" )
		timer.Destroy ( "STFULocalPlayer")
	end
end

local function clSTFU( umsg )
	local bool = umsg:ReadBool()
	Extracrap.shutUp( bool )
end
usermessage.Hook( "shuddap", clSTFU )

// menu for use with the gun vault. base of this was vote.


if( GVGUI ) then

	for k, v in pairs( GVGUI ) do
	
		v:Remove();
		GVGUI[k] = nil;
	
	end

end

GVGUI = { }
PanelNumg = 0;

function MsgGunVault( msg )
	local gunlist = string.Explode(",", msg:ReadString() )
	local vault = msg:ReadShort()
	local upgradelist = string.Explode(",", msg:ReadString() )
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "Frame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
	panel:SetName( "Panel" );
	panel:LoadControlsFromString( [[
	
		"GVPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "Panel"
				"fieldName" "Vote"
				"wide" "160"
				"tall" "200"
				"sizable" "0"
				"enabled" "1"
				"title" "Select gun."
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local upgradelabel = {}
	if gunlist[1]!="" then
		for i=1, table.Count(gunlist), 1 do
			_G["PickFunc" .. i] = function( msg )
				LocalPlayer():ConCommand( "withdrawgun " .. vault .. " " .. i .. "\n" );
			end
			
			ybutton[i] = vgui.Create( "Button" );
			ybutton[i]:SetParent( panel );
			ybutton[i]:SetPos( 15, 20+(i*15) );
			ybutton[i]:SetSize( 130, 14 );
			ybutton[i]:SetCommand( "!" );
			local gunname = gunlist[i]
			ybutton[i]:SetText( gunname );
			ybutton[i]:SetActionFunction( _G["PickFunc" .. i] );
			ybutton[i]:SetVisible( true );
		
			table.insert( GVGUI, ybutton[i] );

			if (util.tobool(upgradelist[i])) then
				upgradelabel[i] = vgui.Create("Label")
				upgradelabel[i]:SetParent(panel)
				upgradelabel[i]:SetPos(146, 18+(i*15))
				upgradelabel[i]:SetSize(12,12)
				upgradelabel[i]:SetText("+")
				upgradelabel[i]:SetVisible(true)
			
				table.insert(GVGUI, upgradelabel[i])
			end
		
		end
	else
		// just tell them its empty, in the event of stupid people.
		local label = vgui.Create( "Label" );
		label:SetParent( panel );
		label:SetPos( 15, 45 );
		label:SetSize( 130, 40 );
		label:SetText( "This Gun Vault is empty. \nDrop guns into it before \ntrying to take guns out." );
		label:SetVisible( true );
		table.insert( GVGUI, label )
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "gunvaultgui", MsgGunVault );


function MsgPillBox( msg )
	local gunlist = string.Explode(",", msg:ReadString() )
	local vault = msg:ReadShort()
	// local upgradelist = string.Explode(",", msg:ReadString() )
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "Frame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
	panel:SetName( "Panel" );
	panel:LoadControlsFromString( [[
	
		"GVPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "Panel"
				"fieldName" "Vote"
				"wide" "320"
				"tall" "200"
				"sizable" "0"
				"enabled" "1"
				"title" "Select item."
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 360, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local upgradelabel = {}
	if gunlist[1]!="" then
		for i=1, table.Count(gunlist), 1 do
			_G["PickFunc" .. i] = function( msg )
				LocalPlayer():ConCommand( "withdrawitem " .. vault .. " " .. i .. "\n" );
			end
			
			ybutton[i] = vgui.Create( "Button" );
			ybutton[i]:SetParent( panel );
			if (i>10) then
				ybutton[i]:SetPos( 15+135, 20+((i-10)*15) )
			else
				ybutton[i]:SetPos( 15, 20+(i*15) );
			end
			ybutton[i]:SetSize( 130, 14 );
			ybutton[i]:SetCommand( "!" );
			local gunname = gunlist[i]
			ybutton[i]:SetText( gunname );
			ybutton[i]:SetActionFunction( _G["PickFunc" .. i] );
			ybutton[i]:SetVisible( true );
		
			table.insert( GVGUI, ybutton[i] );
		
		end
	else
		// just tell them its empty, in the event of stupid people.
		local label = vgui.Create( "Label" );
		label:SetParent( panel );
		label:SetPos( 15, 45 );
		label:SetSize( 130, 40 );
		label:SetText( "This Pill Box is empty. \nDrop items into it before \ntrying to take items out." );
		label:SetVisible( true );
		table.insert( GVGUI, label )
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "pillboxgui", MsgPillBox );

function MsgGunFactory( msg )
	local upgrade = msg:ReadShort()
	local vault = msg:ReadShort()
	local inputenabled = false;
	local cancelmode = msg:ReadBool()
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "Frame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
	panel:SetName( "Panel" );
	local ttl = "Select weapon."
	if cancelmode then
		ttl = "Cancel weapon"
	end
	panel:LoadControlsFromString( [[
	
		"GVPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "Panel"
				"fieldName" "Vote"
				"wide" "160"
				"tall" "115"
				"sizable" "0"
				"enabled" "1"
				"title" "]]..ttl..[["
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	_G["PickFunc1"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " laserbeam\n" );
	end
	_G["PickFunc2"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " laserrifle\n" );
	end
	_G["PickFunc3"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " grenadegun\n" );
	end
	_G["PickFunc4"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " worldslayer\n" );
	end
	_G["PickFunc5"] = function (msg)
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " resetbutton\n" );
	end
	_G["PickFunc6"] = function (msg)
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " plasma\n" );
	end
	if !cancelmode then
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Laser" );
	ybutton[1]:SetActionFunction( _G["PickFunc1"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	
	ybutton[2] = vgui.Create( "Button" );
	ybutton[2]:SetParent( panel );
	ybutton[2]:SetPos( 15, 50 );
	ybutton[2]:SetSize( 130, 14 );
	ybutton[2]:SetCommand( "!" );
	ybutton[2]:SetText( "Laser Rifle" );
	ybutton[2]:SetActionFunction( _G["PickFunc2"] );
	ybutton[2]:SetVisible( true );
	table.insert( GVGUI, ybutton[2] );
	
	if upgrade>=1 then
		ybutton[3] = vgui.Create( "Button" );
		ybutton[3]:SetParent( panel );
		ybutton[3]:SetPos( 15, 65 );
		ybutton[3]:SetSize( 130, 14 );
		ybutton[3]:SetCommand( "!" );
		ybutton[3]:SetText( "Grenade Launcher" );
		ybutton[3]:SetActionFunction( _G["PickFunc3"] );
		ybutton[3]:SetVisible( true );
		table.insert( GVGUI, ybutton[3] );
		
		ybutton[4] = vgui.Create( "Button" );
		ybutton[4]:SetParent( panel );
		ybutton[4]:SetPos( 15, 80 );
		ybutton[4]:SetSize( 130, 14 );
		ybutton[4]:SetCommand( "!" );
		ybutton[4]:SetText( "Plasma Gun" );
		ybutton[4]:SetActionFunction( _G["PickFunc6"] );
		ybutton[4]:SetVisible( true );
		table.insert( GVGUI, ybutton[4] );
	end
	
	if upgrade>=2 then
		ybutton[5] = vgui.Create( "Button" );
		ybutton[5]:SetParent( panel );
		ybutton[5]:SetPos( 15, 95 );
		ybutton[5]:SetSize( 130, 14 );
		ybutton[5]:SetCommand( "!" );
		ybutton[5]:SetText( "Worldslayer" );
		ybutton[5]:SetActionFunction( _G["PickFunc4"] );
		ybutton[5]:SetVisible( true );
		table.insert( GVGUI, ybutton[5] );
	end
	else
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Cancel" );
	ybutton[1]:SetActionFunction( _G["PickFunc5"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "gunfactorygui", MsgGunFactory );


function MsgGunFactoryGet( msg )
	local time = msg:ReadFloat()
	local ent = msg:ReadEntity()
	if ValidEntity(ent) then
		ent:GetTable().TimeToFinish = time
	end
end
usermessage.Hook( "gunfactoryget", MsgGunFactoryGet );


function KillGunVaultGUI( msg )

	local vault = msg:ReadShort();

	if( GVGUI[vault] ) then
	
		for k, v in pairs( GVGUI ) do
		
			if( v:GetParent() == GVGUI[vault] ) then
			
				v:Remove();
				GVGUI[k] = nil;
			
			end
		
		end

		GVGUI[vault]:Remove();
		
		GVGUI[vault] = nil;
		
		PanelNumg = PanelNumg - 1;
		
	end

end
usermessage.Hook( "killgunvaultgui", KillGunVaultGUI );

function KillPillBoxGUI( msg )

	local vault = msg:ReadShort();

	if( GVGUI[vault] ) then
	
		for k, v in pairs( GVGUI ) do
		
			if( v:GetParent() == GVGUI[vault] ) then
			
				v:Remove();
				GVGUI[k] = nil;
			
			end
		
		end

		GVGUI[vault]:Remove();
		
		GVGUI[vault] = nil;
		
		PanelNumg = PanelNumg - 1;
		
	end

end
usermessage.Hook( "killpillboxgui", KillPillBoxGUI );

function KillGunFactoryGUI( msg )

	local vault = msg:ReadShort();

	if( GVGUI[vault] ) then
	
		for k, v in pairs( GVGUI ) do
		
			if( v:GetParent() == GVGUI[vault] ) then
			
				v:Remove();
				GVGUI[k] = nil;
			
			end
		
		end

		GVGUI[vault]:Remove();
		
		GVGUI[vault] = nil;
		
		PanelNumg = PanelNumg - 1;
		
	end

end
usermessage.Hook( "killgunfactorygui", KillGunFactoryGUI );

function MUpdateAgenda(msg)
	MobAgenda = msg:ReadString()
end
usermessage.Hook( "UpdateMobAgenda", MUpdateAgenda );


function msgShockWaveEffect(msg)
	local start = msg:ReadVector()
	local norm = msg:ReadAngle()
	local radius = msg:ReadShort()
	local efdt = EffectData()
		efdt:SetStart(start)
		efdt:SetOrigin(start)
		efdt:SetScale(1)
		efdt:SetRadius(radius)
		efdt:SetNormal(norm)
	util.Effect("cball_bounce",efdt)
end
usermessage.Hook("shockwaveeffect", msgShockWaveEffect)

function MsgDrugFactory( msg )
	local upgrade = msg:ReadShort()
	local vault = msg:ReadShort()
	local booze = msg:ReadShort()
	local drugs = msg:ReadShort()
	local rands = msg:ReadShort()
	local sdefense = msg:ReadShort()
	local soffense = msg:ReadShort()
	local sweapmod = msg:ReadShort()
	local mode = msg:ReadShort()
	
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "Frame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
	panel:SetName( "Panel" );
	panel:LoadControlsFromString( [[
	
		"GVPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "Panel"
				"fieldName" "Vote"
				"wide" "160"
				"tall" "210"
				"sizable" "0"
				"enabled" "1"
				"title" "Drug Refinery"
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local ylabel = {}
	
	local maxbooze = 5
	local maxdrug = 10
	if upgrade==1 then
		maxdrug=7
		maxbooze=4
	elseif upgrade==2 then
		maxdrug=5
		maxbooze=3
	end
	
	ylabel[1] = vgui.Create( "Label" );
	ylabel[1]:SetParent( panel );
	ylabel[1]:SetPos( 15, 35 );
	ylabel[1]:SetSize( 130, 14 );
	ylabel[1]:SetText( "Booze: "..tostring(booze).."/"..tostring(maxbooze) );
	ylabel[1]:SetVisible(true)
	table.insert( GVGUI, ylabel[1] );
	
	ylabel[2] = vgui.Create( "Label" );
	ylabel[2]:SetParent( panel );
	ylabel[2]:SetPos( 15, 50 );
	ylabel[2]:SetSize( 130, 14 );
	ylabel[2]:SetText( "Drugs: "..tostring(drugs).."/"..tostring(maxdrug) );
	ylabel[2]:SetVisible( true );
	table.insert( GVGUI, ylabel[2] );
	
	ylabel[3] = vgui.Create( "Label" );
	ylabel[3]:SetParent( panel );
	ylabel[3]:SetPos( 15, 65 );
	ylabel[3]:SetSize( 130, 14 );
	ylabel[3]:SetText( "RandomDrugs: "..tostring(rands).."/10" );
	ylabel[3]:SetVisible( true );
	table.insert( GVGUI, ylabel[3] );
	
	ylabel[4] = vgui.Create( "Label" );
	ylabel[4]:SetParent( panel );
	ylabel[4]:SetPos( 15, 80 );
	ylabel[4]:SetSize( 130, 14 );
	ylabel[4]:SetText( "Superdrugs: "..tostring(soffense).."/3, "..tostring(sdefense).."/3, "..tostring(sweapmod).."/3" );
	ylabel[4]:SetVisible( true );
	table.insert( GVGUI, ylabel[4] );
	
	local rmode = "Money"
	if mode==1 then rmode="S. Offense"
	elseif mode==2 then rmode="S. Defense"
	elseif mode==3 then rmode="S. Weapon Mod"
	end
	
	ylabel[5] = vgui.Create( "Label" );
	ylabel[5]:SetParent( panel );
	ylabel[5]:SetPos( 15, 95 );
	ylabel[5]:SetSize( 130, 14 );
	ylabel[5]:SetText( "Refining to "..rmode );
	ylabel[5]:SetVisible( true );
	table.insert( GVGUI, ylabel[5] );
	
	_G["PickFunc1"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " money\n" );
	end
	_G["PickFunc2"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " offense\n" );
	end
	_G["PickFunc3"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " defense\n" );
	end
	_G["PickFunc4"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " weapmod\n" );
	end
	_G["PickFunc5"] = function (msg)
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " eject\n" );
	end
	_G["PickFunc6"] = function(msg)
		LocalPlayer():ConCommand("setrefinerymode "..vault.." uber\n")
	end
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 110 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Eject SuperDrugs" );
	ybutton[1]:SetActionFunction( _G["PickFunc5"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	
	ybutton[5] = vgui.Create( "Button" );
	ybutton[5]:SetParent( panel );
	ybutton[5]:SetPos( 15, 125 );
	ybutton[5]:SetSize( 130, 14 );
	ybutton[5]:SetCommand( "!" );
	ybutton[5]:SetText( "Refine to Money" );
	ybutton[5]:SetActionFunction( _G["PickFunc1"] );
	ybutton[5]:SetVisible( true );
	table.insert( GVGUI, ybutton[5] );
	local ymod=0
	if upgrade>=1 then
		ybutton[2] = vgui.Create( "Button" );
		ybutton[2]:SetParent( panel );
		ybutton[2]:SetPos( 15, 140 );
		ybutton[2]:SetSize( 130, 14 );
		ybutton[2]:SetCommand( "!" );
		ybutton[2]:SetText( "Refine to Offense" );
		ybutton[2]:SetActionFunction( _G["PickFunc2"] );
		ybutton[2]:SetVisible( true );
		table.insert( GVGUI, ybutton[2] );

		ybutton[3] = vgui.Create( "Button" );
		ybutton[3]:SetParent( panel );
		ybutton[3]:SetPos( 15, 155 );
		ybutton[3]:SetSize( 130, 14 );
		ybutton[3]:SetCommand( "!" );
		ybutton[3]:SetText( "Refine to Defense" );
		ybutton[3]:SetActionFunction( _G["PickFunc3"] );
		ybutton[3]:SetVisible( true );
		table.insert( GVGUI, ybutton[3] );
		
		ybutton[4] = vgui.Create( "Button" );
		ybutton[4]:SetParent( panel );
		ybutton[4]:SetPos( 15, 170 );
		ybutton[4]:SetSize( 130, 14 );
		ybutton[4]:SetCommand( "!" );
		ybutton[4]:SetText( "Refine to Weapon Mod" );
		ybutton[4]:SetActionFunction( _G["PickFunc4"] );
		ybutton[4]:SetVisible( true );
		table.insert( GVGUI, ybutton[4] );
		ymod = 45
	end
	if upgrade>=2 && soffense>=3 && sdefense>=3 && sweapmod>=3 then
		ybutton[6] = vgui.Create( "Button" );
		ybutton[6]:SetParent( panel );
		ybutton[6]:SetPos( 15, 140+ymod );
		ybutton[6]:SetSize( 130, 14 );
		ybutton[6]:SetCommand( "!" );
		ybutton[6]:SetText( "Create UberDrug" );
		ybutton[6]:SetActionFunction( _G["PickFunc6"] );
		ybutton[6]:SetVisible( true );
		table.insert( GVGUI, ybutton[6] );
	end
	table.insert( GVGUI, ybutton[1] );
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "drugfactorygui", MsgDrugFactory );

function KillDrugFactoryGUI( msg )

	local vault = msg:ReadShort();

	if( GVGUI[vault] ) then
	
		for k, v in pairs( GVGUI ) do
		
			if( v:GetParent() == GVGUI[vault] ) then
			
				v:Remove();
				GVGUI[k] = nil;
			
			end
		
		end

		GVGUI[vault]:Remove();
		
		GVGUI[vault] = nil;
		
		PanelNumg = PanelNumg - 1;
		
	end

end
usermessage.Hook( "killdrugfactorygui", KillDrugFactoryGUI );

// exact typo every time.
function Curtime()
	return CurTime()
end

language.Add("CombineCannon_ammo", "Flamethrower Fuel")
language.Add("SniperRound_ammo", "Sniper Rounds")
language.Add("SMG_ammo", "Rifle Rounds")
language.Add("Pistol_ammo", "Pistol Ammo")
language.Add("SLAM_ammo", "Grenades")
language.Add("XBowBolt_ammo", "Dart Gun Bolts")
language.Add("env_fire", "Fire")
language.Add("env_physexplosion", "The Game")
language.Add("entityflame", "Flames")
language.Add("env_explosion", "Explosion")
language.Add("SBoxLimit_magnets", "You have hit the Magnet limit!")