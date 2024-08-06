if(!instance_exists(global.player))
	return;
	
if(!(variable_instance_exists(global.player.id, "inWater")))
	global.player.inWater = false;

if(place_meeting(x, y, obj_player_sensorBL) || place_meeting(x, y, obj_player_sensorBR))
{
	if(electro)
		scr_player_hurt(20, -global.player.image_xscale * 4);
	
	if(!global.player.inWater)
	{
		global.player.inWater = true;
		
		audio_play_sound(snd_watersplash, 0, false);
		net_sound_emit(snd_watersplash);
		net_quick_effect(global.player.x, bbox_top, spr_watersplash, false, 1, 0, 0, 1);
	}
	
	scr_player_slow(.5);
}
else if(global.player.inWater)
{
	global.player.inWater = false;
	
	audio_play_sound(snd_watersplash, 0, false);
	net_sound_emit(snd_watersplash);
	net_quick_effect(global.player.x, bbox_top, spr_watersplash, false, 1, 0, 0, 1);
}