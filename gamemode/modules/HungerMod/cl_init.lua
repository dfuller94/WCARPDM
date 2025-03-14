
local HM = { }

FoodAteAlpha = -1;
FoodAteY = 0;

surface.CreateFont( "ChatFont", 22, 500, true, false, "HungerPlus" );

function HM.HUDPaint()

	if( GetGlobalInt( "hungermod" ) == 0 ) then return; end

	local x = 7;
	local y = ScrH() - 9;
	
	draw.RoundedBox( 4, x - 1, y - 1, 195, 9, Color( 0, 0, 0, 255 ) );
	
	if( LocalPlayer():GetNWInt( "Energy" ) > 0 ) then
		draw.RoundedBox( 4, x, y, 193 * ( math.Clamp( LocalPlayer():GetNWInt( "Energy" ), 0, 100 ) / 100 ), 7, Color( 30, 30, 120, 255 ) );
		draw.DrawText( math.ceil( LocalPlayer():GetNWInt( "Energy" ) ) .. "%", "DefaultSmall", x + 100, y - 2, Color( 255, 255, 255, 255 ), 1 );
	else
		draw.DrawText( "Starving!", "ChatFont", x + 96, y - 4, Color( 200, 0, 0, 255 ), 1 );
	end
	
	if( FoodAteAlpha > -1 ) then
	
		local mul = 1;
		
		if( FoodAteY <= ScrH() - 30 ) then
		
			mul = -.5;
		
		end
		
		draw.DrawText( "++", "HungerPlus", 208, FoodAteY + 1, Color( 0, 0, 0, FoodAteAlpha ), 0 );
		draw.DrawText( "++", "HungerPlus", 207, FoodAteY, Color( 20, 100, 20, FoodAteAlpha ), 0 );
	
		FoodAteAlpha = math.Clamp( FoodAteAlpha + 1000 * FrameTime() * mul, -1, 255 );
		FoodAteY = FoodAteY - 150 * FrameTime();
	
	end

end
hook.Add( "HUDPaint", "HM.HUDPaint", HM.HUDPaint );

function AteFoodIcon( msg )

	FoodAteAlpha = 1;
	FoodAteY = ScrH() - 8;
	
end
usermessage.Hook( "AteFoodIcon", AteFoodIcon );