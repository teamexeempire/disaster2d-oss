coll = false;

if(!instance_exists(obj_camera))
	return;

if(instance_exists(global.player) && (global.player.hp > 0 || global.player.revivalTimes >= 2) && !obj_netclient.gameEnds)
{
	if(position_meeting(global.player.x, global.player.y, obj_deserttown_trigger))
	{
		obj_deserttown_i.coll = true;
	}
}
else
{
	with(obj_camera)
	{
		if(position_meeting(x + 240, y + 135, obj_deserttown_trigger))
		{
			obj_deserttown_i.coll = true;
		}
	}
}

if(coll)
{	
	if(value < 1)
		value += 0.1;
		
	var _value = value;
	with(obj_tile)
	{
		if(depth == -300)
			image_alpha = _value;
	}
	
	with(obj_tile)
	{
		if(depth == -400)
			image_alpha = 1.0 - _value;
	}
	
	layer_background_alpha(_c, 1.0 - _value);
}
else
{
	if(value > 0)
		value -= 0.1;
		
	var _value = value;
	with(obj_tile)
	{
		if(depth == -300)
			image_alpha = _value;
	}
	
	with(obj_tile)
	{
		if(depth == -400)
			image_alpha = 1.0 - _value;
	}
	
	layer_background_alpha(_c, 1.0 - _value);
}