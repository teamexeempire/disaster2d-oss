if(!instance_exists(global.player))
	return;

if(global.player.x <= 240 && global.player.xspd < 0)
{
	global.player.x = room_width - 240;
}

if(global.player.x >= room_width - 240 && global.player.xspd > 0)
{
	global.player.x = 240;
}