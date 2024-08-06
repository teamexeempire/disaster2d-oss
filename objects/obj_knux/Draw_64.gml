var offset = 25;
if(hp > 0)
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
	
	var _colour = room == room_act9 ? c_dkgray : c_white;
	draw_sprite_ext(redRingTimer > 0 ? spr_hp_rr : spr_hp, revivalTimes == 2 ? 0 : frame, ceil(x-obj_camera.x), ceil(y-obj_camera.y) - offset, 1, 1, 0, _colour, 1);
	
	if(isSlow)
		draw_sprite(spr_frozen, 0, ceil(x-obj_camera.x), ceil(y-obj_camera.y) - offset);
	
	if(obj_netclient.exeId != obj_netclient.nid && revivalTimes < 2)
		scr_number_spr(ceil(x-obj_camera.x) - 2, ceil(y-obj_camera.y) - offset - 12, string(global.player.rings), _colour);
}