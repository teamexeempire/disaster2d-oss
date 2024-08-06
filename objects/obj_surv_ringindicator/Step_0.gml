visible = false;

if(!instance_exists(global.player))
	return;

if(!instance_exists(obj_bigring))
	return;

if(global.player.revivalTimes >= 2)
	return;

if(global.player.hp <= 0)
	return;
	
if(global.player.shards <= 0)
	return;

if(obj_ravinemist_controller.shardCount < 6)
	return;

target = instance_nearest(x, y, obj_bigring);
if(target != noone)
{
	image_angle = point_direction(global.player.x, global.player.y, target.x, target.y);
	visible = true;
}