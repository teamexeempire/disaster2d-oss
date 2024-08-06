image_alpha = clamp(image_alpha - fadeSpeed, 0, 1);

if(image_alpha <= 0)
{
	instance_destroy();
}