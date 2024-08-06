targetX = x + sin(degtorad(image_angle)) * sprite_height;
targetY = y + cos(degtorad(image_angle)) * sprite_height;

light.show = active;
if(active)
{
	frame += 0.16;
	if(frame >= 4 - 1)
		frame = 1;
}
else
	frame = 0;
	
if(instance_exists(global.player))
{
	if(active && point_distance(targetX, targetY + 33/2, global.player.x, global.player.y) < 80)
	{
		obj_weed.weed = false;
		obj_weed.alarm[0] = (20 + random_range(1, 2)) * 60;
	}
}
	
image_angle = ((sin(current_time / 400) + 1) / 2.0) * 4;