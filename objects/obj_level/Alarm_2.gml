with(obj_netclient)
{
	audio_stop_all();
	global.ringId = 0;
	global.player = noone;
	global.character = -1;
	global.exeCharacter = -1;
	global.playerControls = true;
	ds_map_destroy(players);
	players = ds_map_create();
	exeId = -1;
	
	avCharacters = 
	[ 
		false, //0 (exe) (cannot)
		true,  //1 (t)
		true,
		true,
		true,
		true,
		true
	];
	
	state = STATE_LOBBY;
	room_goto(room_lobby);
}