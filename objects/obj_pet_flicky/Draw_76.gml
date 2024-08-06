if(!instance_exists(target))
{
	instance_destroy();
	return;
}

image_xscale = target.image_xscale;
image_speed = 0.2 + distance_to_object(target) / 150.0;

if(target == global.player)
	image_alpha = target.isHiding ? 0.5 : 1;
else
	image_alpha = target.isHiding ? 0 : 1;

if(distance_to_object(target) > 200)
{
	x = target.x - image_xscale * 32;
	y = target.y - 10;
}

x = lerp(x, target.x - image_xscale * (target.isHiding ? 16 : 32), 0.21);
y = lerp(y, target.y - 10 + sin(current_time / 500) * 5, 0.21);