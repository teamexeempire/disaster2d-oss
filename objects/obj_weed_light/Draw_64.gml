if(!instance_exists(obj_camera))
	return;
	
if(show)
{
	if(image_alpha < 1)
		image_alpha += (1 / 60) * 2;
	else
		image_alpha = 1;
}
else
{
	if(image_alpha > 0)
		image_alpha -= (1 / 60) * 2;
	else
		image_alpha = 0;
}

draw_sprite_ext(spr_weed_light, 0, x - obj_camera.x, y - obj_camera.y, 1, 1, 0, c_white, image_alpha);