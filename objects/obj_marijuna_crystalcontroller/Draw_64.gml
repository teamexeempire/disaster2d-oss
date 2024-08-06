if(!instance_exists(obj_netclient))
	return;
	
if(!instance_exists(global.player))
	return;
	
if(alarm[0] > 0)
{
	var _offset = 20;
	switch(global.character)
	{
		case CHARACTER_SALLY:
		case CHARACTER_KNUX:
		case CHARACTER_AMY:
		{
			_offset = 25;
			break;
		}
		
		case CHARACTER_EGGMAN:
		{
			_offset = 36;
			break;
		}
	}
	
	draw_sprite(spr_marijuna_boohoo, 0, ceil(global.player.x - obj_camera.x), ceil(global.player.y - obj_camera.y) - _offset);
}