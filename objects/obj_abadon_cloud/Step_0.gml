if(image_index >= image_number - 1)
{
	image_index = image_number - 1;
	visible = false;
	return;
}

if(!visible)
	return;
	
if(!instance_exists(global.player))
	return;
	
if(place_meeting(x, y, global.player) && image_index >= 18 && damage)
	obj_am_controller.collision = true;