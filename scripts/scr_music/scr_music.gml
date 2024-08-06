global.music = -1;
global.musicGain = 1;

function scr_play_music(bid)
{
	if(global.music != -1)
		scr_stop_music();
	
	global.music = audio_play_sound(bid, 0, true);
	audio_sound_gain(global.music, 1, 0);
}

function scr_stop_music()
{
	audio_stop_sound(global.music);
	global.music = -1;
}