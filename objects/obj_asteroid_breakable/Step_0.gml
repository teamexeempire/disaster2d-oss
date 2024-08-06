image_angle += hspeed / 2.0;

if(obj_minisnoc.dead)
	return;
	
if(place_meeting(x, y, obj_minisnoc) && !obj_minisnoc.dead)
{
	if(obj_minisnoc.alarm[1] > 0)
	{
		for(var i = 0; i < irandom_range(4, 6); i++)
		{
			var inst = instance_create_layer(x + random_range(-4, 4), y + random_range(-4, 4), "Minigame", obj_asteroid_part);
			inst.hspeed = obj_minisnoc.xspd * 1.2 + random_range(-2, 2);
			inst.vspeed = random_range(-4, -2)
		}	
		audio_play_sound(snd_minidestroy, 0, false);
		instance_destroy();
		obj_minisnoc.row++;
	}
	else
		obj_minigame.dead();
}

if(x <= -60)
	instance_destroy();