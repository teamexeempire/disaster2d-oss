if(!instance_exists(global.player))
	return;

target = noone;

if(instance_exists(obj_player_puppet))
{
	var dist = 999999999;
	for(var i = 0; i < instance_number(obj_player_puppet); i++)
	{
		var inst = instance_find(obj_player_puppet, i);
		
		if(inst.character != CHARACTER_EXE)
			continue;
		
		if(dist > distance_to_object(inst))
		{
			dist = distance_to_object(inst);
			target = inst;
		}
	}
	
	if(target != noone)
	{
		image_angle = point_direction(global.player.x, global.player.y, target.x, target.y);
		visible = true;
	}
}