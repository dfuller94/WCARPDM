
if( BuyGUI ) then

	for k, v in pairs( BuyGUI ) do
	
		v:Remove();
		BuyGUI[k] = nil;
	
	end

end
BuyGUI = {}
SubBuyGUI = {}
local currentpage = 1

local RPDM = {}

// just a little temporary fix.
CreateClientConVar("sv_benchmark_force_start", 0, false, false)

function RPDM.MenuGet()
	spawnmenu.AddToolMenuOption("WCARPDM", "WCARPDM", "clPropAccess","Prop Protect","","",RPDM.AccessPanel)
	spawnmenu.AddToolMenuOption("WCARPDM", "WCARPDM", "clAllies","Allies","","",RPDM.AllyPanel)
	spawnmenu.AddToolMenuOption("WCARPDM", "WCARPDM", "clSettings","Settings","","",RPDM.OptionPanel)
end
hook.Add("PopulateToolMenu", "RPDM_PopulateToolMenu", RPDM.MenuGet)

function RPDM.SpawnMenuOpen()
	if RPDM.OptionControlPanel then RPDM.OptionPanel(RPDM.OptionControlPanel) end
	if RPDM.AllyControlPanel then RPDM.AllyPanel(RPDM.AllyControlPanel) end
	if RPDM.AccessControlPanel then RPDM.AccessPanel(RPDM.AccessControlPanel) end
end
hook.Add("SpawnMenuOpen", "RPDM_SpawnMenuOpen", RPDM.SpawnMenuOpen)


// msg

RPDM.OptionControlPanel = nil

CreateClientConVar("rpdm_showmessages", 1, true, false)
CreateClientConVar("rpdm_shownotify", 0, true, false)
CreateClientConVar("rpdm_messages_warningnotify", 1, true, false)
CreateClientConVar("rpdm_messages_dontshowincome", 0, true, false)
CreateClientConVar("rpdm_showsparks",1,true,false)
CreateClientConVar("rpdm_clcolor_r",255,true,true)
CreateClientConVar("rpdm_clcolor_g",255,true,true)
CreateClientConVar("rpdm_clcolor_b",255,true,true)

function RPDM.OptionPanel(Panel)
	Panel:ClearControls()
	if RPDM.OptionControlPanel==nil then RPDM.OptionControlPanel=Panel end
	
	Panel:AddControl("Header", {Text="Messenger Options"})
	Panel:AddControl("CheckBox", {Label="Show Messenger", Command="rpdm_showmessages"})
	Panel:AddControl("CheckBox", {Label="Show Messages as notifications", Command="rpdm_shownotify"})
	Panel:AddControl("CheckBox", {Label="Show Warnings as notifications", Command="rpdm_messages_warningnotify"})
	Panel:AddControl("CheckBox", {Label="Don't show Income Messages", Command="rpdm_messages_dontshowincome"})
	Panel:AddControl("Header", {Text="Effect Options"})
	Panel:AddControl("CheckBox", {Label="Show spark effects", Command="rpdm_showsparks"})
	if LocalPlayer():GetInfo("rpdm_clcolor_r")==nil then
		CreateClientConVar("rpdm_clcolor_r",255,true,true)
	end
	if LocalPlayer():GetInfo("rpdm_clcolor_g")==nil then
		CreateClientConVar("rpdm_clcolor_g",255,true,true)
	end
	if LocalPlayer():GetInfo("rpdm_clcolor_b")==nil then
		CreateClientConVar("rpdm_clcolor_b",255,true,true)
	end
	Panel:AddControl( "Color",  { Label	= "Effect Colors",
									Red			= "rpdm_clcolor_r",
									Green		= "rpdm_clcolor_g",
									Blue		= "rpdm_clcolor_b",
									ShowAlpha	= 0,
									ShowHSV		= 1,
									ShowRGB 	= 1,
									Multiplier	= 255 } )	
									
	
end

// allies


RPDM.AllyPanel = nil

function RPDM.AllyPanel(Panel)
	Panel:ClearControls()
	if RPDM.AllyControlPanel==nil then RPDM.AllyControlPanel=Panel end
	
	Panel:AddControl("Header", {Text="Allies"})
	for k, v in pairs(player.GetAll()) do
		if LocalPlayer():GetInfo("rpdm_ally_pl"..v:EntIndex())==nil then
			CreateClientConVar("rpdm_ally_pl"..v:EntIndex(), 0, false, true)
		end
		Panel:AddControl("CheckBox", {Label=v:GetName(), Command="rpdm_ally_pl"..v:EntIndex()})
	end
	
end

// prop protect

function RPDM.AccessPanel(Panel)
	Panel:ClearControls()
	if RPDM.AccessControlPanel==nil then RPDM.AccessControlPanel=Panel end
	
	Panel:AddControl("Header", {Text="Prop Protect"})
	if LocalPlayer():IsAdmin() || LocalPlayer():IsSuperAdmin() then
		Panel:AddControl("Button", {Label="Clear disconnected player props", Command="propprotect_clearoldprops"})
	end
	for k, v in pairs(player.GetAll()) do
		if v!=LocalPlayer() then
			if LocalPlayer():GetInfo("propprotect_access_pl"..v:EntIndex())==nil then
				CreateClientConVar("propprotect_access_pl"..v:EntIndex(), 0, false, true)
			end
			Panel:AddControl("CheckBox", {Label=v:GetName(), Command="propprotect_access_pl"..v:EntIndex()})
		end
	end
	
end

// original buy menu made by j.own

local buytable = {}
buytable["Pistols"] = {}
buytable["Pistols"].Names = {"P228","Deagle","Glock","FiveSeven","USP","Elites","Mac-10","TMP"}
buytable["Pistols"].Cost = {200,210,220,230,240,350,420,530}
buytable["Pistols"].Data = {"p228","deagle","glock","fiveseven","usp","elites","mac10","tmp"}
buytable["Pistols"].Cmd = "buypistol"
buytable["Shipments"] = {}
buytable["Shipments"].Names = {"Mac-10","TMP","UMP45","M4A1","Shotgun","MP5","Galil","AUG","RPG","AK-47","Flamethrower","Sniper","Auto-Shotgun","M240 Para","Auto-Sniper","Grenade","Stun Grenade","Gas Grenade","Molotov"}
buytable["Shipments"].Cost = {1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2400,2800,3500,300,250,400,400}
buytable["Shipments"].Data = {"mac10","tmp","ump","m4","shotgun","mp5","galil","aug","rpg","ak47","flamethrower","sniper","autoshotgun","para","autosnipe","grenade","stun","gas","molotov"}
buytable["Shipments"].Cmd = "buyshipment"
buytable["Ammo"] = {}
buytable["Ammo"].Names = {"Pistol","Rifle","Shotgun","Sniper","Rocket","Dart","Fuel"}
buytable["Ammo"].Cost = {25,40,60,60,50,50,60}
buytable["Ammo"].Data = {"pistol","rifle","shotgun","sniper","rocket","dart","fuel"}
buytable["Ammo"].Cmd = "buyammo"
buytable["Defense Drugs"] = {}
buytable["Defense Drugs"].Names = {"Regeneration","Pain Killers","Antidote","Reflect","Adrenaline"}
buytable["Defense Drugs"].Cost = {700,500,400,600,400}
buytable["Defense Drugs"].Data = {"regen","painkillers","antidote","reflect","adrenaline"}
buytable["Defense Drugs"].Cmd = "buydrug"
buytable["Offense Drugs"] = {}
buytable["Offense Drugs"].Names = {"Steroids","Double Jump","Leech","Amplifier","Armor Piercer"}
buytable["Offense Drugs"].Cost = {600,400,400,600,400}
buytable["Offense Drugs"].Data = {"steroids","doublejump","leech","amp","armorpiercer"}
buytable["Offense Drugs"].Cmd = "buydrug"
buytable["Weapon Mod Drugs"] = {}
buytable["Weapon Mod Drugs"].Names = {"Magic Bullet","Shock Wave","Knockback","Double Tap","Focus"}
buytable["Weapon Mod Drugs"].Cost = {300,600,400,750,300}
buytable["Weapon Mod Drugs"].Data = {"magicbullet","shockwave","knockback","doubletap","focus"}
buytable["Weapon Mod Drugs"].Cmd = "buydrug"
buytable["Equipment"] = {}
buytable["Equipment"].Names = {"Medkit","Snipe Shield","Helmet","Scanner","Tool Kit","Armor"}
buytable["Equipment"].Cost = {50,100,100,200,150,400}
buytable["Equipment"].Data = {"health","shield","helmet","scanner","toolkit","armor"}
buytable["Equipment"].Cmd = "buydrug"
buytable["Structures"] = {}
buytable["Structures"].Names = {"Sentry Gun", "Spawn Point","Dispenser","Microwave","Radar Tower","Drug Refinery","Gun Lab","Gun Factory","Plant","Still","Drug Lab","Meth Lab","Printer","Generator"}
buytable["Structures"].Cost = {300,150,400,400,500,500,600,1000,50,250,600,600,1250,400}
buytable["Structures"].Data = {"sentry","spawn","dispenser","microwave","radar","refinery","gunlab","factory","plant","still","druglab","methlab","printer","generator"}
buytable["Structures"].Cmd = "buystruct"
buytable["Other Stuff"] = {}
buytable["Other Stuff"].Names = {"Knife","Pipe Bomb","Lockpick","Dart Gun","Blowtorch","THE BIG BOMB","Airboat","Jeep","Gun Vault","Pill Box"}
buytable["Other Stuff"].Cost = {150,150,150,300,750,5000,400,500,400,400}
buytable["Other Stuff"].Data = {"knife","pipebomb","lockpick","dartgun","welder","bigbomb","airboat","jeep","gunvault","pillbox"}
buytable["Other Stuff"].Cmd = "buyspecial"
buytable["Classes"] = {}
buytable["Classes"].Names = {"Citizen","Cop","OverWatch*","Spec Ops*","Mayor*","Gangster","Hitman*","Mob Boss","Gun Dealer","Pharmacist","Cook"}
buytable["Classes"].Cost = {0,0,0,0,0,0,0,0,0,0,0}
buytable["Classes"].Data = {"/citizen","/cp","/voteow","/votespecops","/votemayor","/gangster","/votehitman","/mobboss", "/gundealer","/medic","/cook"}
buytable["Classes"].Cmd = "say"
buytable["Fix Guns"] = {}

function MakeAddToolMenuTabs()
    spawnmenu.AddToolTab("WCARPDM", "WCARPDM")
end

hook.Add("AddToolMenuTabs", "MakeAddToolMenuTabs", MakeAddToolMenuTabs)

function MsgBuyMenu( msg )
	_GCloseAll = function(msg)
		if( BuyGUI ) then
			
			for k, v in pairs( BuyGUI ) do
				
				v:Remove();
				BuyGUI[k] = nil;
				
			end
			
		end
	end
	_GCloseAll()
	local panel = vgui.Create( "Frame" );
	panel:SetPos( 50 , 50 );
	panel:SetName( "Panel" );
	local pwidth = ScrW()-100
	local plength = ScrH()-100
	panel:LoadControlsFromString( [[
	
		"MainPanel"
		{
		
			"Panel"
			{
			
				"ControlName" "DPanel"
				"fieldName" "Help"
				"wide" ]] .. pwidth .. [[
				"tall" ]] .. plength .. [[
				"sizable" "0"
				"enabled" "1"
				"title" "WCARPDM Buy Menu"
			
			}
		
		}
	
	]] );
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( ScrW()-104, 2 );
	divider:SetVisible( true );
	
	local i=0
	local g=0
	for k,v in pairs(buytable) do
		if k=="Fix Guns" then
			buttonNP = vgui.Create( "Button" );
				buttonNP:SetParent( panel );
				buttonNP:SetPos( 25, (50+(i*30))-(g*30) )
				buttonNP:SetSize( 150, 28 );
				buttonNP:SetCommand( "!" );
				buttonNP:SetText( k );
				buttonNP:SetActionFunction( function() fixWeapons() end);
				buttonNP:SetVisible( true );	
			table.insert( BuyGUI, buttonNP );
			i=i+1
		elseif k!="Defense Drugs" && k!="Offense Drugs" && k!="Weapon Mod Drugs" then
			buttonNP = vgui.Create( "Button" );
				buttonNP:SetParent( panel );
				buttonNP:SetPos( 25, (50+(i*30))-(g*30) )
				buttonNP:SetSize( 150, 28 );
				buttonNP:SetCommand( "!" );
				buttonNP:SetText( k );
				buttonNP:SetActionFunction( function() BuyMenuSubMenu(panel,k) end);
				buttonNP:SetVisible( true );	
			table.insert( BuyGUI, buttonNP );
			i=i+1
		elseif k=="Defense Drugs" then
			buttonNP = vgui.Create( "Button" );
				buttonNP:SetParent( panel );
				buttonNP:SetPos( 25, (50+(i*30))-(g*30) )
				buttonNP:SetSize( 150, 28 );
				buttonNP:SetCommand( "!" );
				buttonNP:SetText( "Drugs" );
				buttonNP:SetActionFunction( function() BuyMenuSubMenu(panel,k,true) end);
				buttonNP:SetVisible( true );	
			table.insert( BuyGUI, buttonNP );
			i=i+1
		else
			g=g+1
			i=i+1
		end
	end
	PanelNumg = PanelNumg + 1;
	BuyGUI[PanelNumg] = panel;
end
usermessage.Hook( "ToggleBuy", MsgBuyMenu );

function BuyMenuSubMenu(panel, type, drugmode)
	if( SubBuyGUI ) then

		for k, v in pairs( SubBuyGUI ) do
	
			v:Remove();
			SubBuyGUI[k] = nil;
	
		end

	end
	local medics = team.NumPlayers(7)
	local dealers = team.NumPlayers(6)
	local team = LocalPlayer():Team()
	if !drugmode && type!="Classes" then
		local i=0
		for k,v in pairs(buytable[type].Names) do
			local cost = buytable[type].Cost[i+1]
			if v=="Medkit" && medics>0 then cost=250 end
			if type=="Shipments" && dealers>0 && team!=6 && v!="Grenade" && v!="Stun Grenade" then cost=cost*2 end
			if v=="Grenade" && team!=6 && team!=5 && team!=3 && team!=2 && team!=9 && team!=10 && dealers>0 then cost = cost*2 end
			if v=="Stun Grenade" && team!=6 && team!=3 && team!=2 && team!=9 && team!=10 && dealers>0 then cost = cost*2 end
			buttonS = vgui.Create( "Button" );
				buttonS:SetParent( panel );
				buttonS:SetPos( 200+(155*math.floor((i)/8)), 50+(i*30)-math.floor((i)/8)*240 )
				buttonS:SetSize( 150, 28 );
				buttonS:SetCommand( "!");
				local data = buytable[type].Data[i+1]
				buttonS:SetActionFunction( function( msg ) LocalPlayer():ConCommand( buytable[type].Cmd.." "..data.."\n" ); end  )
				buttonS:SetText( v .. " $" .. tostring(cost) );
				buttonS:SetVisible( true );
			table.insert( BuyGUI, buttonS );
			table.insert(SubBuyGUI,buttonS);
			i=i+1
		end
	elseif type=="Classes" then
		local i=0
		buttonS = vgui.Create( "Label" );
			buttonS:SetParent( panel );
			buttonS:SetPos( 200, 25 )
			buttonS:SetSize( 150, 28 );
			buttonS:SetText( "*=Vote required" );
			buttonS:SetVisible( true );
		table.insert( BuyGUI, buttonS );
		table.insert(SubBuyGUI,buttonS);
		for k,v in pairs(buytable[type].Names) do
			_G["PickFuncB"..i] = function( msg )
				LocalPlayer():ConCommand( buytable[type].Cmd.." "..buytable[type].Data[i+1].."\n" );
			end
			buttonS = vgui.Create( "Button" );
				buttonS:SetParent( panel );
				buttonS:SetPos( 200, 50+(i*30) )
				buttonS:SetSize( 150, 28 );
				buttonS:SetCommand( "!" );
				buttonS:SetText( v );
				local data = buytable[type].Data[i+1]
				buttonS:SetActionFunction( function( msg ) LocalPlayer():ConCommand( buytable[type].Cmd.." "..data.."\n" ); end )
				buttonS:SetVisible( true );
			table.insert( BuyGUI, buttonS );
			table.insert(SubBuyGUI,buttonS);
			i=i+1
		end
	else
		local i=0
		local t=0
		buttonS = vgui.Create( "Label" );
			buttonS:SetParent( panel );
			buttonS:SetPos( 200+(155*t), 25+(i*30) )
			buttonS:SetSize( 150, 28 );
			buttonS:SetText( "Defense Drugs" );
			buttonS:SetVisible( true );
		table.insert( BuyGUI, buttonS );
		table.insert(SubBuyGUI,buttonS);
		for k,v in pairs(buytable["Defense Drugs"].Names) do
			buttonS = vgui.Create( "Button" );
				buttonS:SetParent( panel );
				buttonS:SetPos( 200+(155*t), 50+(i*30) )
				buttonS:SetSize( 150, 28 );
				buttonS:SetCommand( "!" );
				local data = buytable["Defense Drugs"].Data[i+1]
				buttonS:SetActionFunction( function( msg ) LocalPlayer():ConCommand( buytable["Defense Drugs"].Cmd.." "..data.."\n" ); end  )
				buttonS:SetText( v .. " $" .. tostring(buytable["Defense Drugs"].Cost[i+1]) );
				buttonS:SetVisible( true );
			table.insert( BuyGUI, buttonS );
			table.insert(SubBuyGUI,buttonS);
			i=i+1
		end
		t=t+1
		i=0
		buttonS = vgui.Create( "Label" );
			buttonS:SetParent( panel );
			buttonS:SetPos( 200+(155*t), 25+(i*30) )
			buttonS:SetSize( 150, 28 );
			buttonS:SetText( "Offense Drugs" );
			buttonS:SetVisible( true );
		table.insert( BuyGUI, buttonS );
		table.insert(SubBuyGUI,buttonS);
		for k,v in pairs(buytable["Offense Drugs"].Names) do
			buttonS = vgui.Create( "Button" );
				buttonS:SetParent( panel );
				buttonS:SetPos( 200+(155*t), 50+(i*30) )
				buttonS:SetSize( 150, 28 );
				buttonS:SetCommand( "!" );
				local data = buytable["Offense Drugs"].Data[i+1]
				buttonS:SetActionFunction( function( msg ) LocalPlayer():ConCommand( buytable["Offense Drugs"].Cmd.." "..data.."\n" ); end  )
				buttonS:SetText( v .. " $" .. tostring(buytable["Offense Drugs"].Cost[i+1]) );
				buttonS:SetVisible( true );
			table.insert( BuyGUI, buttonS );
			table.insert(SubBuyGUI,buttonS);
			i=i+1
		end
		t=t+1
		i=0
		buttonS = vgui.Create( "Label" );
			buttonS:SetParent( panel );
			buttonS:SetPos( 200+(155*t), 25+(i*30) )
			buttonS:SetSize( 150, 28 );
			buttonS:SetText( "Weapon Mod Drugs" );
			buttonS:SetVisible( true );
		table.insert( BuyGUI, buttonS );
		table.insert(SubBuyGUI,buttonS);
		for k,v in pairs(buytable["Weapon Mod Drugs"].Names) do
			buttonS = vgui.Create( "Button" );
				buttonS:SetParent( panel );
				buttonS:SetPos( 200+(155*t), 50+(i*30) )
				buttonS:SetSize( 150, 28 );
				buttonS:SetCommand( "!" );
				local data = buytable["Weapon Mod Drugs"].Data[i+1]
				buttonS:SetActionFunction( function( msg ) LocalPlayer():ConCommand( buytable["Weapon Mod Drugs"].Cmd.." "..data.."\n" ); end  )
				buttonS:SetText( v .. " $" .. tostring(buytable["Weapon Mod Drugs"].Cost[i+1]) );
				buttonS:SetVisible( true );
			table.insert( BuyGUI, buttonS );
			table.insert(SubBuyGUI,buttonS);
			i=i+1
		end
	end
end

function fixWeapons()
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		LocalPlayer():ConCommand("use "..v:GetClass())
	end
end