var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(image_alpha < 1)
	image_alpha += 0.016;

if(!instance_exists(global.player))
	return;

if(doDestroy && !audio_is_playing(sndid))
	instance_destroy();

if(doDestroy)
	return;
	
if(image_index >= 8 && distance_to_object(global.player) < 500)
{
	var factor = 1.0 - (distance_to_object(global.player) / 500.0);
	scr_camera_shake(25, factor, 0.2);
}

if(image_index >= 8 && place_meeting(x, y, global.player))
{
	global.player.isSlow = true;
	global.player.alarm[4] = 60 * 3;
	scr_player_hurt(20, -global.player.image_xscale * 4);
}

timer++;
if(timer >= 60 * .5)
{
	scr_audio_play_3d(emitter, snd_snowball_roll, false, 0);
	timer = 0;
}