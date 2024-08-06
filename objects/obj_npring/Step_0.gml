if(!visible)
	return;
	
if(image_alpha < 1)
	image_alpha += 0.032;
	
if(place_meeting(x, y, obj_bigring))
	instance_destroy();