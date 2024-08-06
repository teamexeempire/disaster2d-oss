if(!instance_exists(global.player))
	return;
	
if(place_meeting(x, y, global.player))
{
	with(global.player)
	{
		var nearest = instance_nearest(x, y, obj_majong_trigger_point);
		x = nearest.x;
		y = nearest.y;
		
		xspd = 0;
		gspd = 0;
		yspd = 0;
	}
	
	with(obj_majong_controller)
	{
		fade = 1;
		audio_play_sound(snd_npteleport, 0, false);
	}
}