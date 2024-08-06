if(!instance_exists(obj_camera))
	return;

if(position_meeting(obj_camera.x + 480/2, obj_camera.y + 270/2, obj_weed_zone))
{
	if(fade > 0)
		fade -= 0.016;
}
else
{
	if(fade < 1)
		fade += 0.016;
}

var player_exists = instance_exists(global.player); 
if(!player_exists || player_exists && (global.player.isDead || global.player.revivalTimes >= 2))
	weed = false;	

layer_background_alpha(layer_background_get_id("Foguis"), fade);