if(!instance_exists(global.player))
	return;

if(!instance_exists(target))
{
	visible = false;
	return;
}

if(target != noone)
{
	image_angle = point_direction(global.player.x, global.player.y, target.x, target.y);
	visible = !global.player.isDead;
}
else 
{
	visible = false;
}