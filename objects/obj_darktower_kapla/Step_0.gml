if(!grounded)
{
	y += yspd;
	
	while(place_meeting(x, y, obj_floor_parent))
	{
		y = floor(y);
		y--;
		grounded = true;
	}
	
	image_index = 0;
}

if(image_index >= image_number-1)
	instance_destroy();