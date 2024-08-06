var cam = obj_bluespheres_sonic;
depth = -9;

if(distance_to_object(obj_bluespheres_sonic) < 16)
	flag = true;
	
if(flag)
{
	image_xscale = 1 - fade * 0.5;
	image_yscale = 1 + fade;
	image_alpha = 1 - fade;
	
	if(fade < 1)
		fade += (1/32);
	else
		instance_destroy();
}