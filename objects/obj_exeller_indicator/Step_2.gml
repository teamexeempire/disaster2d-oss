if(!instance_exists(global.player))
	return;

visible = redRings;

target = noone;
redRings = false;

if(instance_exists(obj_player_puppet))
{
	for(var i = 0; i < instance_number(obj_player_puppet); i++)
	{
		var inst = instance_find(obj_player_puppet, i);
		
		if(inst.hp <= 0 || inst.revivalTimes >= 2)
			continue;
			
		if(inst.hasRedRing && (global.character != CHARACTER_EXE || global.player.invisTimer <= 0))
		{
			redRings = true;
			target = inst;
			break;
		}
	}
	
	if(target != noone)
		image_angle = point_direction(global.player.x, global.player.y, target.x, target.y);
}