image_angle += hspeed / 2.0;

if(obj_minisnoc.dead)
	return;

if(place_meeting(x, y, obj_minisnoc) && !obj_minisnoc.dead)
	obj_minigame.dead();
	
if(x <= -60)
{
	obj_minigame.cscore += 100;
	instance_destroy();
}