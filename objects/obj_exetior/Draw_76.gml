sprite_index = global.player_exesanims[? EXE_EXETIOR][state];
switch(state)
{
	case IDLE:
		image_speed = 1;
		break;
		
	case HURT:
	case EXETIOR_ZIPLINE:
		image_speed = 0;
		image_index = 0;
		break;
		
	case BALANCING:
		image_xscale = edgeDir;
		image_speed = 1;
		break;
		
	case FALL:
		image_speed = 0.1;			
		image_index = yspd > 0 ? 1 : 0;
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
		
	case EXETIOR_ATTACK:
		image_speed = 2;
		
		if(image_index >= image_number - 1)
		{
			xspd = xspd * .7;
			gspd = gspd * .7;
			isAttacking = false;
		}
		break;
		
	case EXETIOR_AIR_ATTACK:
		image_speed = 0.8;
		
		if(image_index >= image_number - 1)
		{
			xspd = xspd * .7;
			gspd = gspd * .7;
			isAttacking = false;
			isJumping = false;
		}
		
		break;
		
	case EXETIOR_SHOCKED:
	{
		image_speed = 0.5;
		break;
	}
	
	case EXETIOR_LOST:
	case EXETIOR_WON:
		image_speed = 0.8;
		break;
		
	case EXETIOR_STOMP:
		image_speed = 1;
		break;
		
	case EXETIOR_STOMP_LAND:
		image_speed = 1;
		
		if(image_index >= image_number - 1)
		{
			canMove = true;
			isStomping = false;
		}
		
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
		image_speed = 0.8;		
		break;
}