global.timeSeconds = 0;
global.timeMinutes = 0;
global.ringFrame = 0;
state = 0;
showSurvivors = false;
survivorTimer = 0;
timeFrame = 0;
clockAngle = 0;
bloodFade = 0;
hideFade = 0;

titleCard = 0;
cardX = 480;
cardY = -270;
depth = -1000;
instance_create_depth(0, 0, 0, obj_playerui);

drawPing = function(char, exeCharacter, ping, revival, name, index)
{	
	if(char == CHARACTER_EXE)
	{
		char += CHARACTER_SALLY;
		char += exeCharacter;
	}
	else char--;
	
	draw_sprite(spr_tab_entry, char, 480/2, 44 + index * 30);
	
	if(char <= CHARACTER_SALLY)
	{
		if(revival >= 2)
			draw_sprite(spr_playerhealth_demon, char, 480/2-113 + 1, 43 + index * 30 + 28);
		else if(revival >= 1)
			draw_sprite(spr_playerhealth_hit, char, 480/2-113 + 1, 43 + index * 30 + 28);
	}
	
	var clr = #0fff39;
	if(ping <= 0)
	{
		ping = string_copy("...", 0, (current_time / 500) % 4);
		clr = #ff0001;
	}
	else
	{
		if(ping >= 80 && ping < 160)
			clr = #ffc400;
		else if(ping >= 160)
			clr = #ff0001;
			
		ping = $"{ping}ms";
	}
	
	scr_text_spr(127+59, 44+11 + index * 30, name, c_white);
	scr_text_spr(127+183, 44+11 + index * 30, $"{ping}", clr);
}