
local HelpPanel = { }

local LastChatPrefix = "";

function HelpPanel:Init()

	self.StartHelpX = -ScrW();
	self.HelpX = self.StartHelpX;
	
	self.title = vgui.Create( "Label", self );
	self.title:SetText( "WCA RPDM v1.1" );
	
	self.modinfo = vgui.Create( "Label", self );
	self.modinfo:SetText( "Modified version of DarkRP v2.1a" );
	
	self.scrolltext = vgui.Create( "Label", self );
	self.scrolltext:SetText( "Use mousewheel to scroll" );
	
	self.HelpInfo = vgui.Create( "Panel", self );
	
	self.vguiHelpCategories = { }
	self.vguiHelpLabels = { }
	--[[
	self.HelpInfo.chattitle = vgui.Create( "Label", self.HelpInfo );
	self.HelpInfo.chattitle:SetText( "Chat Commands" );
	
	self.HelpInfo.admintitle = vgui.Create( "Label", self.HelpInfo );
	self.HelpInfo.admintitle:SetText( "Admin Console Commands" );

	self.HelpInfo.admincmd1 = vgui.Create( "Label", self.HelpInfo );
	self.HelpInfo.admincmd1:SetText( "rp_citizen, rp_cp, or rp_ow <Name/Partial Name> - Set a player's team\nrp_paydaytime <Seconds> - The delay before each pay day\nrp_maxcps <Number> - Maximum number of CPs\nrp_setmoney <Name/Partial Name> <Money amount> - Set a player's money\nrp_adminsweps <1 or 0> Set if SWEPs should be admins only\nrp_propspawning <1 or 0> - Set if prop spawning is enabled\nrp_toolgun <1 or 0> - Set if all players get a toolgun\nrp_strictsuicide <1 or 0> - Set if the player should spawn where they suicide (whether they are arrested or not)\nrp_propertytax <1 or 0> - Property tax\nrp_citpropertytax <1 or 0> - Should property tax be only for citizens\nrp_allowedprops <1 or 0> - Set if players can only spawn \"allowed\" props\nrp_bannedprops <1 or 0> - Should certain props be banned (will override rp_allowedprops)\nrp_globaltags <1 or 0> - Should player's name and job be visible from across the map\nrp_ooc <1 or 0> - Enable or disable OOC chat\n" );
	
	self.HelpInfo.admincmd2 = vgui.Create( "Label", self.HelpInfo );
	self.HelpInfo.admincmd2:SetText( "rp_alltalk <1 or 0> - Enable or disable all talk\nrp_showcrosshairs <1 or 0> - Enable or disable crosshairs\nrp_showjob <1 or 0> - Show player jobs\nrp_showname <1 or 0> - Show player names\nrp_arrest <Name/Partial Name> - Arrest a player\nrp_unarrest <Name/Partial Name> - Unarrest a player\nrp_kick <Name> <Optional Reason>\nrp_kickban <Name> <Minute length>\nrp_rcon <RCON command>" );
	
	self.HelpInfo.chatcmd = vgui.Create( "Label", self.HelpInfo );
	]]--
	self.Scroll = 0;
	
end

function HelpPanel:FillHelpInfo( force )
	
	local maxpertable = 11;
	local helptable = 1;
	
	local yoffset = 0;
	
	if( force ) then
		for k, v in pairs( self.vguiHelpCategories ) do
			v:Remove();
			self.vguiHelpCategories[k] = nil;
		end
		for k, v in pairs( self.vguiHelpLabels ) do
			v:Remove();
			self.vguiHelpLabels[k] = nil;
		end
	end
	
	for k, v in pairs( HelpCategories ) do

		if( not self.vguiHelpCategories[v.id] or force ) then
		
			local helptext = "";
			local Labels = { }

			self.vguiHelpCategories[v.id] = vgui.Create( "Label", self.HelpInfo );
			self.vguiHelpCategories[v.id]:SetText( v.text );
			self.vguiHelpCategories[v.id].OrigY = yoffset;
			self.vguiHelpCategories[v.id]:SetPos( 5, yoffset );
			self.vguiHelpCategories[v.id]:SetFont( "GModToolSubtitle" );
			self.vguiHelpCategories[v.id]:SetFGColor( Color( 255, 255, 255, 200 ) );
			
			for n, m in pairs( HelpLabels ) do
			
				if( m.category == v.id ) then

					table.insert( Labels, m.text );
					
				end
			
			end
			
			local index = 1;
			local HelpText = { }
			
			for i = 1, math.ceil( #Labels / maxpertable ) do
			
				for n = index, maxpertable * i do
				
					if( n > #Labels ) then break; end
					if( not HelpText[i] ) then HelpText[i] = ""; end
					
					HelpText[i] = HelpText[i] .. Labels[n] .. "\n";
					
				end
			
				index = index + maxpertable;
			
			end
			
			local labelh = GetTextHeight( "ChatFont", "A" );
			
			for i = 1, #HelpText do
			
				self.vguiHelpLabels[i + v.id * 100] = vgui.Create( "Label", self.HelpInfo );
				self.vguiHelpLabels[i + v.id * 100]:SetText( HelpText[i] );
				self.vguiHelpLabels[i + v.id * 100].OrigY = yoffset + 25 + ( i - 1 ) * ( maxpertable * labelh );
				self.vguiHelpLabels[i + v.id * 100]:SetPos( 5, yoffset + 25 + ( i - 1 ) * ( maxpertable * labelh ) );
				self.vguiHelpLabels[i + v.id * 100]:SetFont( "ChatFont" );
				self.vguiHelpLabels[i + v.id * 100]:SetFGColor( Color( 255, 255, 255, 200 ) );

			end
			
			local cath = GetTextHeight( "GModToolSubtitle", "A" );

			yoffset = yoffset + ( cath + 15 ) + #Labels * labelh;

		end
	
	end

end

function HelpPanel:PerformLayout()

	self:FillHelpInfo();
	
	self:SetSize( -self.StartHelpX, ScrH() - 70 );

	for k, v in pairs( self.vguiHelpCategories ) do

		v:SetPos( 5, v.OrigY - self.Scroll );
		v:SizeToContents();
	
	end
	
	for k, v in pairs( self.vguiHelpLabels ) do
	
		v:SetPos( 5, v.OrigY - self.Scroll );
		v:SizeToContents();
	
	end
	
	self.HelpInfo:SetPos( 5, 70 );
	self.HelpInfo:SetSize( self:GetWide() - 5, self:GetTall() - 5 );
	
	self.title:SetPos( 5, 5 );
	self.title:SizeToContents();
	
	self.modinfo:SetPos( 5, 50 );
	self.modinfo:SizeToContents();
	
	self.scrolltext:SetPos( 250, 25 );
	self.scrolltext:SizeToContents();
	--[[
	self.HelpInfo.chattitle:SetPos( 5, 10 - self.Scroll );
	self.HelpInfo.chattitle:SizeToContents();
	
	self.HelpInfo.chatcmd:SetPos( 5, 40 - self.Scroll );
	self.HelpInfo.chatcmd:SizeToContents();
	
	self.HelpInfo.admintitle:SetPos( 5, self.HelpInfo.chatcmd:GetTall() + 50 - self.Scroll );
	self.HelpInfo.admintitle:SizeToContents();
	
	self.HelpInfo.admincmd1:SetPos( 5, self.HelpInfo.chatcmd:GetTall() + 80 - self.Scroll );
	self.HelpInfo.admincmd1:SizeToContents();
	
	self.HelpInfo.admincmd2:SetPos( 5, self.HelpInfo.chatcmd:GetTall() + self.HelpInfo.admincmd1:GetTall() + 67 - self.Scroll );
	self.HelpInfo.admincmd2:SizeToContents();
	]]--
end

function HelpPanel:ApplySchemeSettings()

	self.title:SetFont( "GModToolName" );
	self.title:SetFGColor( Color( 255, 255, 255, 255 ) );
	
	self.modinfo:SetFont( "TargetID" );
	self.modinfo:SetFGColor( Color( 255, 255, 255, 255 ) );
	
	self.scrolltext:SetFont( "GModToolSubtitle" );
	self.scrolltext:SetFGColor( Color( 150, 50, 50, 255 ) );
	
	--[[
	self.HelpInfo.chattitle:SetFont( "GModToolSubtitle" );
	self.HelpInfo.chattitle:SetFGColor( Color( 255, 255, 255, 200 ) );
	
	self.HelpInfo.admintitle:SetFont( "GModToolSubtitle" );
	self.HelpInfo.admintitle:SetFGColor( Color( 255, 255, 255, 200 ) );
	
	self.HelpInfo.chatcmd:SetFont( "ChatFont" );
	self.HelpInfo.chatcmd:SetFGColor( Color( 255, 255, 255, 200 ) );
	
	self.HelpInfo.admincmd1:SetFont( "ChatFont" );
	self.HelpInfo.admincmd1:SetFGColor( Color( 255, 255, 255, 200 ) );
	
	self.HelpInfo.admincmd2:SetFont( "ChatFont" );
	self.HelpInfo.admincmd2:SetFGColor( Color( 255, 255, 255, 200 ) );]]--

end

function HelpPanel:OnMouseWheeled( delta )

	self.Scroll = math.Clamp( self.Scroll + delta * FrameTime() * 1000, 0, math.Clamp( ( #HelpCategories * 25 + #HelpLabels * 14 ) - 400, 0, 99999 ) );

	self:InvalidateLayout();

end

function HelpPanel:Paint()

	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 150 ) );
	
end

function HelpPanel:Think()

	if( self.HelpX < 0 ) then
		self.HelpX = self.HelpX + 600 * FrameTime();
	end
		
	if( self.HelpX > 0 ) then
		self.HelpX = 0;
	end

	self:SetPos( self.HelpX, 20 );
	--[[
	--Dirty little hack D:
	if( LastChatPrefix ~= GetGlobalString( "cmdprefix" ) ) then
	
		LastChatPrefix = GetGlobalString( "cmdprefix" );
	
		local chatcmdtext = "/job <Job name> - Set your job\n/give <Money amount> - Give a player you're looking at money\n/moneydrop <Money amount> - Drop a money bag\n/sleep - To fall asleep (wait 10 seconds then type again to UNSLEEP)\n/votecop - Vote to be a cop\n/r - Radio speak with other Combine\n/cr - Send a message to the Combine/Request for Combine\n/title <Name> - Give your door a title\n/w - Whisper\n/y - Yell\n@a, @@, or @ooc - Talk in OOC\n/cp - Become a CP if you're on the admin's CP list\n/mayor - Become Mayor if you're on the admin's Mayor list\n/citizen - Become a Citizen\n/medic - Become a Medic";
		chatcmdtext = string.gsub( chatcmdtext, "/", GetGlobalString( "cmdprefix" ) );
		chatcmdtext = string.gsub( chatcmdtext, "@", "/" );
		self.HelpInfo.chatcmd:SetText( chatcmdtext );
	
	end
]]--
end

vgui.Register( "HelpVGUI", HelpPanel, "Panel" );