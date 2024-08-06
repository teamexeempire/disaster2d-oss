var gain = 1.0 - (min(distance_to_point(obj_camera.x + 240, obj_camera.y + 135), 700) / 700.0);
audio_emitter_position(emitter, x+sprite_width/2, y+sprite_height/2, 0);
audio_emitter_gain(emitter, gain);

if(overlaps)
{
	if(timer >= 60)
	{
		if(global.player.rings > 0)
		{
			audio_play_sound(snd_ringabsorb, 0, false);
			net_sound_emit(snd_ringabsorb);
			global.player.rings--;
		}
		else
			scr_player_hurt(20, -global.player.image_xscale * 4);
			
		timer = 0;
	}
	
	if(timer >= 0)
	{
		if(global.player.redRingTimer <= 0)
		{
			audio_play_sound(mus_mindfuck, 0, true);
			instance_create_depth(0, 0, -700, obj_redring_screen);
			global.player.redRingTimer = 60 * 3;
		}
	}
	
	timer++;
}
else timer = -60;

overlaps = false;