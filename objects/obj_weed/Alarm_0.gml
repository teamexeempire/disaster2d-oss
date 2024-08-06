if(global.character == CHARACTER_EXE)
	return;
	
if(!instance_exists(global.player))
	return;
	
if(global.player.hp <= 0)
	return;
	
if(global.player.revivalTimes >= 2)
	return;
	
audio_play_sound(snd_wdarms, false, 0);
obj_weed.weed = true;