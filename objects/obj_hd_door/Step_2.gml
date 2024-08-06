if(!instance_exists(obj_camera))
	return;

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!state)
{
	if(y < sY)
	{
		y++;
	
		if(!instance_exists(global.player))
			return;
		
		for(var i = x; i < x + sprite_width; i++)
		{
			if(point_in_rectangle(i, y+sprite_height+1, obj_player_sensorTL.x, obj_player_sensorTL.y, obj_player_sensorBR.x, obj_player_sensorBR.y))
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
	if(y > sY - sprite_height)
		y--;
}