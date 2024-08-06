if(!instance_exists(global.player) || obj_netclient.gameEnds)
{
	application_surface_draw_enable(true);
	return;
}

if(alarm[0] > 90)
{
	if(size < room_height)
		size += acc;
	else
	{
		posX = global.player.x;
		posY = global.player.y;
		size = room_height;
	}

	acc += 0.016 * 4;
}
else
{
	posX = global.player.x;
	posY = global.player.y;

	if(size > 0)
		size -= acc;
	else
		size = 0;
	
	acc += 0.016 * 4;
}

if(obj_level.state == 1)
{
	if(instance_exists(obj_marjiuna_static))
		return;
	
	var rand = irandom_range(0, instance_number(obj_marijuna_guko) - 1);
	instance_find(obj_marijuna_guko, rand).index = 2;
	instance_create_depth(0, 0, -501, obj_marjiuna_static);
}