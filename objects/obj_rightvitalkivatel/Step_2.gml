if(!active)
	return;

if(!instance_exists(global.player))
	return;
	
active = false;
	
var p = global.player;
if(collision_rectangle(p.x-6, p.y-20, p.x+6, p.y+18, self, false, false))
{
	global.player.x = bbox_right + 14;
	global.player.xspd = 0;
	global.player.yspd = 0;
}

if(!instance_exists(obj_exeller_clone))
	return;

var _self = self;
with(obj_exeller_clone)
{
	while(collision_rectangle(x-22, y-22, x+22, y+22, _self, false, false))
		x ++;
}