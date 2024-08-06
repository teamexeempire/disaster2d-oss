if(instance_exists(obj_deserttown_i))
{
	var _coll = position_meeting(x, y, obj_deserttown_trigger);
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
				
		draw_sprite_ext(hasRedRing ? spr_hp_rr : spr_hp, isDemonized ? 0 : frame, floor(x-obj_camera.x), floor(y-obj_camera.y) - 45, 1, 1, 0, _colour, 1);
	}
	
	if(nicknameWidth == 0)
		nicknameWidth = scr_text_spr(0, 0, nickname);
	
	if(global.showHud)
	{
		if(character == CHARACTER_EXE || isDemonized)
			scr_text_spr(floor(x-obj_camera.x) - nicknameWidth / 2, floor(y-obj_camera.y) - 43, nickname, room == room_act9 ? c_dkgray : c_red, 1);
		else
			scr_text_spr(floor(x-obj_camera.x) - nicknameWidth / 2, floor(y-obj_camera.y) - 43, nickname, room == room_act9 ? c_dkgray : (hasRedRing ? #9943ad : c_green), 1);
	}
	
	if(!isDemonized && hp > 0)
		scr_number_spr(floor(x-obj_camera.x) - 2, floor(y-obj_camera.y) - 45 - 12, string(rings), _colour);
}