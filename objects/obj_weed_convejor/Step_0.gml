var _self = self;
var _touched = false;

if(!instance_exists(obj_player_sensorBL) || !instance_exists(obj_player_sensorBR))
	return;

if(instance_exists(obj_player_sensorBL))
{
	if(obj_player_sensorBL.x >= bbox_left-4 && obj_player_sensorBL.x <= bbox_right &&
	   obj_player_sensorBL.y >= bbox_top && obj_player_sensorBL.y <= bbox_bottom) 
	{
		_touched = true;
	}
}

if(instance_exists(obj_player_sensorBR))
{
	if(obj_player_sensorBR.x >= bbox_left-4 && obj_player_sensorBR.x <= bbox_right &&
	   obj_player_sensorBR.y >= bbox_top && obj_player_sensorBR.y <= bbox_bottom) 
	{
		_touched = true;
	}
}

if(_touched)
	global.player.x -= 4;