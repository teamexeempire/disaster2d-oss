sprite_index = global.player_exesanims[? EXE_ORIGINAL][state + (invisTimer > 0 ? EXE_ZIPLINE+1 : 0)];
switch(state)
{
	case IDLE:
		image_speed = 1;
		break;
		
	case HURT:
	case EXE_ZIPLINE:
		image_speed = 0;
		image_index = 0;
		break;
		
	case BALANCING:
		image_xscale = edgeDir;
		image_speed = 1;
		break;
		
	case FALL:
		image_speed = 0.1;
		if(image_index >= image_number - 1)
			image_index = image_number - 1;
			
		if(xspd > 0)
			image_xscale = 1;
		else if(xspd < 0)
			image_xscale = -1;
		break;
		
	case WALK:
		image_speed = (abs(xspd) / (maxHSpeed));
		break;
		
	case RUN:
	case JUMP:
		image_speed = max(abs(xspd) / 20, 0.5);
		break;
		
	case LOOKUP:
	case LOOKDOWN:
		image_speed = 0.2;
		
		// Stop on last frame
		if(image_index >= 1)
			image_index = 1;
			
		break;
		
	case SPIN:
		image_speed = abs(xspd) / 5;
		break;
		
	case EXE_ATTACK:
		image_speed = 2;
		
		if(image_index >= image_number - 1)
		{
			xspd = xspd * .7;
			gspd = gspd * .7;
			isAttacking = false;
		}
		break;
		
	case EXE_AIR_ATTACK:
		image_speed = 0.8;
		
		if(image_index >= image_number - 1)
		{
			xspd = xspd * .7;
			gspd = gspd * .7;
			isAttacking = false;
			isJumping = false;
		}
		
		break;
		
	case EXE_SHOCKED:
	{
		image_speed = 0.5;
		break;
	}
	
	case EXE_LOST:
	case EXE_WON:
		image_speed = 0.8;
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
		image_speed = 0.8;		
		break;
}