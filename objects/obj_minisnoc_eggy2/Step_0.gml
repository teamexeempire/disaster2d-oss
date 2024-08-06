x -= 4;

if(place_meeting(x, y, obj_minisnoc) && !obj_minisnoc.dead)
	obj_minigame.dead();
	
if(x <= 0)
{
	obj_minigame.cscore += 10;
	instance_destroy();
}