if(!instance_exists(global.player))
	return;

with(global.player)
{
	if(place_meeting(x, y, obj_nap_trigger))
		return;
}

for(var i = 0; i < (optimize ? 1 : 3); i++)
	instance_create_depth(obj_camera.x + random_range(-120, 560), obj_camera.y - 1, -200, obj_nap_snow);
	
for(var i = 0; i < (optimize ? 1 : 2); i++)
	instance_create_depth(obj_camera.x + 481, obj_camera.y + random_range(-120, 350), -200, obj_nap_snow);