if(!instance_exists(global.player))
	return;
	
if(global.player.state != DEAD)
	return;
	
if(global.player.hp > 0)
	return;
	
if(place_meeting(x, y, obj_player_sensorBL) || place_meeting(x, y, obj_player_sensorBL))
{
	var nearest = instance_nearest(global.player.x, global.player.y, obj_deathtp_point);
	
	if(nearest == noone)
		return;
		
	global.player.x = nearest.x;
	global.player.y = nearest.y - 2;
	global.player.gspd = 0;
	global.player.xspd = 0;
	global.player.yspd = 0;
}