if(!instance_exists(global.player))
	return;

if(show)
{
	var angle = degtorad(point_direction(global.player.x, global.player.y, sprX, sprY));
	x = ceil(global.player.x) + cos(angle) * 32;
	y = ceil(global.player.y) + -sin(angle) * 32;
}

visible = (global.character == CHARACTER_EXE && show);
show = false;