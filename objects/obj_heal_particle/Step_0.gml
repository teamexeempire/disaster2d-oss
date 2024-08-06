image_alpha -= fade;

if(image_alpha <= 0)
{
	instance_destroy();
	return;
}

y += spd;
x = sX + sin((current_time + offset) / 300.0) * range;