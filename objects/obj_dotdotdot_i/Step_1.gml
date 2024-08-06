if(!instance_exists(global.player))
	return;
	
if(!global.player.isSlow)
{
	switch(global.character)
	{
		case CHARACTER_EXE:
		{
			global.player.maxHSpeed = EXE_MAXSPEED;
			global.player.acc = EXE_ACC;
			break;
		}
		
		case CHARACTER_TAILS:
		{
			global.player.maxHSpeed = TAILS_MAXSPEED;
			global.player.acc = TAILS_ACC;
			break;
		}
		
		case CHARACTER_KNUX:
		{
			global.player.maxHSpeed = KNUX_MAXSPEED;
			global.player.acc = KNUX_ACC;
			break;
		}
		
		case CHARACTER_EGGMAN:
		{
			global.player.maxHSpeed = EGGMAN_MAXSPEED;
			global.player.acc = EGGMAN_ACC;
			break;
		}
		
		case CHARACTER_AMY:
		{
			global.player.maxHSpeed = AMY_MAXSPEED;
			global.player.acc = AMY_ACC;
			break;
		}
		
		case CHARACTER_SALLY:
		{
			global.player.maxHSpeed = SALLY_MAXSPEED;
			global.player.acc = SALLY_ACC;
			break;
		}
		
		case CHARACTER_CREAM:
		{
			global.player.maxHSpeed = CREAM_MAXSPEED;
			global.player.acc = CREAM_ACC;
			break;
		}
	}
}