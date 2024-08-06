if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player))
{	
	var inst = instance_nearest(x, y, obj_abyss_target);
	global.player.x = inst.x;
	global.player.y = inst.y;
	global.player.xspd = 0;
	global.player.gspd = 0;
	global.player.yspd = 0;
	
	if(global.character == CHARACTER_SALLY)
		global.player.isSliding = false;
	
	if(shouldStun && (global.character == CHARACTER_EXE || global.player.revivalTimes >= 2))
		global.player.shockedTimer += 60 * 0.5;
	
	scr_player_hurt(20, 0, 0);
}

if(!instance_exists(obj_ravintmist_shard))
	return;

var _inst = instance_place(x, y, obj_ravintmist_shard);
if(_inst != noone)
{
	var inst = instance_nearest(x, y, obj_abyss_target);
	_inst.x = inst.x - _inst.sprite_height/2;
	_inst.y = inst.y - _inst.sprite_height/2;
}