if(obj_level.state >= 1)
{
	if(fade < 1)
		fade += 0.016;
	else
		fade = 1;
}

image_index = index;
image_alpha = 1.0 - fade;