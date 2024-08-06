if(start)
	return;
	
start = true;
instance_create_depth(0, 0, 0, obj_blackfadeout);
audio_play_sound(mus_logo, 0, false);
alarm[0] = 60 * 2;