function scr_player_slow(time)
{
	if(!instance_exists(global.player))
		return;
		
	switch(global.character)
	{
		case CHARACTER_EXE:
			global.player.isSlow = true;
			global.player.acc = (EXE_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (EXE_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
		case CHARACTER_TAILS:
			global.player.isSlow = true;
			global.player.acc = (TAILS_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (TAILS_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
			
		case CHARACTER_KNUX:
			global.player.isSlow = true;
			global.player.acc = (KNUX_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (KNUX_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
			
		case CHARACTER_EGGMAN:
			global.player.isSlow = true;
			global.player.acc = (EGGMAN_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (EGGMAN_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
		case CHARACTER_AMY:
			global.player.isSlow = true;
			global.player.acc = (AMY_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (AMY_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
		case CHARACTER_SALLY:
			global.player.isSlow = true;
			global.player.acc = (SALLY_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (SALLY_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
			
		case CHARACTER_CREAM:
			global.player.isSlow = true;
			global.player.acc = (CREAM_ACC * (100-40)) / 100;
			global.player.maxHSpeed = (CREAM_MAXSPEED * (100-40)) / 100;
			global.player.alarm[4] = 60 * time;
			
			break;
	}
}