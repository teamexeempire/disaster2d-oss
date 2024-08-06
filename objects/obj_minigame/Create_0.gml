show = false;
layer = layer_get_id("UI");
ingame = false;
firstGray = true;

boss = false;
last = 0;
cscore = 0;
hiscore = 0;
off = 0;
elapsed = 0;
interval = (random_range(1, 3) * (60 - elapsed));

try
{
	if(file_exists($"{game_save_id}/hiscore"))
	{
		var buff = buffer_load($"{game_save_id}/hiscore");
		hiscore = buffer_read(buff, buffer_u32);
		buffer_delete(buff);
	}
}
catch(error) {}
 
activate = function()
{
	boss = false;
	
	with(obj_minisnoc_eggy2)
		instance_destroy();
		
	with(obj_minisnoc_eggy)
		instance_destroy();
	
	cscore = 0;
	last = 0;
	alarm[2] = 60 * 2;
	layer = layer_get_id("Minigame2");
	firstGray = true;
	off = 0;
	elapsed = 0;
	interval = (random_range(1, 3) * (60 - elapsed));

	scr_play_music(mus_minigame);
	obj_minisnoc.x = 20;
	obj_minisnoc.y = 68;
	obj_minisnoc.alarm[0] = 10;
	
	layer_set_visible("Minigame", true);
	layer_set_visible("Minigame2", true);
	ingame = true;
}

dead = function()
{
	audio_play_sound(snd_minidie, 0, false);
	scr_stop_music();
	
	if(cscore > hiscore)
	{
		hiscore = cscore;
		
		var buff = buffer_create(4, buffer_fixed, 1);
		buffer_write(buff, buffer_u32, hiscore);
		buffer_save(buff, "hiscore");
		buffer_delete(buff);
	}
	
	firstGray = false;
	obj_minisnoc.vspeed = -4;
	obj_minisnoc.dead = true;
	alarm[0] = 60 * 2;
}