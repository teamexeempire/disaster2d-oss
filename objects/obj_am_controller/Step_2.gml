if(!instance_exists(global.player))
	return;

if(collision)
{
	if(timer > 0)
		timer--;
	else
	{		
		if(global.player.rings <= 0)
			scr_player_hurt(20, -global.player.image_xscale * 4);
		else
		{
			audio_play_sound(snd_ringabsorb, 0, false);
			net_sound_emit(snd_ringabsorb);
			global.player.rings--;
		}
				
		timer = 60 * .6;
	}
}
else
	timer = 60 * .1;