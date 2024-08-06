var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(isHigh)
	sprite_index = spr_vv_lavacolumn2;
	
if(timer++ >= 60 * 0.3)
{
	if(state == 2 || state == 3)
		scr_audio_play_3d(emitter, snd_lavaappear, false, 0);
		
	timer = 0;
}

if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player))
	scr_player_hurt(20, sign(global.player.x - x) * 4, -2, snd_lavahit);