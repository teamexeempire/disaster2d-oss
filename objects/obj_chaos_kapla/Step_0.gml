if(!place_meeting(x, y, obj_floor_parent))
{
	y += spd;
	image_index = 0;
}
else
{
	if(image_index >= image_number - 1)
		instance_destroy();
}