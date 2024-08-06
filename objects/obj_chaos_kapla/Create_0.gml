if(room == room_act9)
	image_blend = c_black;

spd = choose(4, 4.5, 5, 5.5, 6, 6.5);

target = noone;
	
if(global.character != CHARACTER_EXE)
{
	if(!instance_exists(obj_player_puppet))
		return;
	
	var _tg = noone;
	with(obj_player_puppet)
	{
		if(character != CHARACTER_EXE)
			continue;
			
		_tg = self;
	}
	
	target = _tg;
}