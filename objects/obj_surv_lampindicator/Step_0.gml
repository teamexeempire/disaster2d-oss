if(!instance_exists(global.player))
	return;

if(!instance_exists(obj_weed_lantern))
	return;

if(global.player.revivalTimes >= 2 || global.player.isDead)
{
	instance_destroy();
	return;
}

image_angle = point_direction(global.player.x, global.player.y, targetX, targetY);