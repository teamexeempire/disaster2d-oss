if(!instance_exists(obj_camera))
	return;

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!state)
{
	if(x < sX)
	{
		x++;
	
		if(!instance_exists(global.player))
			return;
		
		for(var i = y+2; i < y + sprite_height-2; i++)
		{
			if(point_in_rectangle(x+sprite_width+1, i, global.player.x-8, global.player.y-18, global.player.x+8, global.player.y+18))
			{
				if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
				{
					var nearest = instance_nearest(global.player.x, global.player.y, obj_deathtp_point);
					
					global.player.x = nearest.x;
					global.player.y = nearest.y;
				}
				else
					scr_player_instakill();
			}
		}
	}
}
else
{
	if(x > sX - sprite_width)
		x--;
}