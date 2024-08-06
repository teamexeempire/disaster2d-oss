if(!instance_exists(global.player))
	return;
	
if(obj_np_controller.tid != tid)
	return;
	
if(!place_meeting(x, y, global.player))
{	
	global.player.x = pX;
	global.player.y = pY;
}

for(var i = 0; i < instance_number(obj_exeller_clone); i++)
{
	var inst = instance_find(obj_exeller_clone, i);
	
	if(instance_exists(obj_exeller_clone) && !place_meeting(x, y, inst))
	{
		inst.x = pX;
		inst.y = pY;
	}
}