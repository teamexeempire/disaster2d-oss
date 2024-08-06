if(!instance_exists(global.player))
	return;

coll = false;

if(position_meeting(obj_player_sensorL.x, obj_player_sensorL.y, self))
{
	if(!global.player.isSlow)
	{
		if(global.player.xspd > 7)
		{
			global.player.xspd = 7;
			global.player.gspd = 7;
		}
		
		
		if(global.player.xspd < -7)
		{
			global.player.xspd = -7;
			global.player.gspd = -7;
		}
		
		global.player.maxHSpeed = 7;
	}
	
	coll = true;
}
else if(position_meeting(obj_player_sensorR.x, obj_player_sensorR.y, self))
{
	if(!global.player.isSlow)
	{
		if(global.player.xspd > 7)
		{
			global.player.xspd = 7;
			global.player.gspd = 7;
		}
		
		
		if(global.player.xspd < -7)
		{
			global.player.xspd = -7;
			global.player.gspd = -7;
		}
		
		global.player.maxHSpeed = 7;
	}
	
	coll = true;
}