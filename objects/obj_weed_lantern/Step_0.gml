light.show = active;
if(active)
{
	image_index += 0.16;
	if(image_index >= image_number - 1)
		image_index = 1;
}
else
	image_index = 0;
	
if(!instance_exists(global.player))
	return;
	
if(active && distance_to_object(global.player) < 80)
{
	obj_weed.weed = false;
	obj_weed.alarm[0] = (20 + random_range(1, 2)) * 60;
}