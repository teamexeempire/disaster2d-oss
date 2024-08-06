if(global.character != CHARACTER_EXE)
{
	if(instance_exists(obj_deserttown_i))
	{
		var _coll = position_meeting(x, y, obj_deserttown_trigger);
		if(_coll != obj_deserttown_i.coll)
			return;
	}

	if(nicknameWidth == 0)
		nicknameWidth = scr_text_spr(0, 0, pname);
	
	scr_text_spr(floor(x-obj_camera.x) - nicknameWidth / 2, floor(y-obj_camera.y) - 43, pname, room == room_act9 ? c_dkgray : c_red, 1);
}
else
{
	draw_sprite(spr_exeller_clonearrow, pindex, floor(x-obj_camera.x), floor(y-obj_camera.y - 35 - sin(current_time / 200)));
}