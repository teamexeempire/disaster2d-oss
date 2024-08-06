if(!instance_exists(global.player))
	return;

if(spring)
{
	var angle = degtorad(point_direction(global.player.x, global.player.y, sprX, sprY));
	x = ceil(global.player.x) + cos(angle) * 32;
	y = ceil(global.player.y) + -sin(angle) * 32;
}

image_alpha = 0.7 * (alarm[0] / (60 * 2.0));
visible = (global.character == CHARACTER_EXE && spring);