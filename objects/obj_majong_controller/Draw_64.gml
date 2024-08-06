if(fade > 0)
{
	draw_sprite_ext(spr_white, 0, 0, 0, 1, 1, 0, c_white, fade);
	fade -= 0.32;
}

if(!instance_exists(obj_player_puppet))
	return;
	
with(obj_player_puppet)
{
	var xPos = 0;
	
	if(x >= 0 && x <= 480)
		xPos = room_width - 480 + x;	
	else if(x >= room_width - 480 && x <= room_width)
		xPos = x - (room_width-480);
	else
		continue;
	
	if(instance_exists(obj_deserttown_i) && global.cameraMode != 2 && global.cameraMode != 4)
	{
		var _coll = place_meeting(x, y, obj_deserttown_trigger);
		if(_coll != obj_deserttown_i.coll)
			return;
	}
	
	if(!isHiding)
	{
		var _colour = room == room_act9 ? c_dkgray : c_white;
		
		if(hp > 0 && character != CHARACTER_EXE)
		{
			var frame = 5;
			
			if(hp >= 100)
				frame = 5;
			else if(hp >= 75)
				frame = 4;
			else if(hp >= 50)
				frame = 3;
			else if(hp >= 25)
				frame = 2;
			else if(hp > 0)
				frame = 1
			else
				frame = 0;
					
			draw_sprite_ext(hasRedRing ? spr_hp_rr : spr_hp, isDemonized ? 0 : frame, floor(xPos-obj_camera.x), floor(y-obj_camera.y) - 50, 1, 1, 0, _colour, 1);
		}
		var ww = string_length(nickname) * 8;
		
		if(character == CHARACTER_EXE || isDemonized)
			scr_text_spr(floor(xPos-obj_camera.x) - ww/2, floor(y-obj_camera.y) - 40, nickname, room == room_act9 ? c_dkgray : c_red, 1);
		else
			scr_text_spr(floor(xPos-obj_camera.x) - ww/2, floor(y-obj_camera.y) - 40, nickname, room == room_act9 ? c_dkgray : (hasRedRing ? #9943ad : c_green), 1);
			
		if(!isDemonized && hp > 0)
			scr_number_spr(floor(xPos-obj_camera.x) - 2, floor(y-obj_camera.y) - 50 - 12, string(rings), _colour);
	}
}