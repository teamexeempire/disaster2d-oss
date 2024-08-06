var arr = revivalTimes >= 2 ? global.player_eanims : global.player_anims;
sprite_index = arr[? CHARACTER_TAILS][state];

switch(state)
{
	case IDLE:
		image_speed = 1;
		break;
		
	case HURT:
		image_speed = 0;
		image_index = 0;
		break;
		
	case BALANCING:
		image_xscale = edgeDir;
		image_speed = 1;
		break;
		
	case FALL:
		image_index = yspd > 0 ? 1 : 0;
		break;
		
	case WALK:
		image_speed = (abs(xspd) / (maxHSpeed));
		break;
		
	case RUN:
	case JUMP:
		image_speed = max(abs(xspd) / 20, 0.5);
		break;
		
	case DEAD:
		if(revivalTimes >= 2)
		{
			image_speed = 0.5;
			break;
		}
		
		if(isGrounded)
			image_speed = 1;
		else
			image_speed = 0;
		
		if(image_index >= image_number - 1)
			image_index = image_number - 1;
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
		
	case TAILS_FLY:
		image_speed = 2;
		break;
		
	case TAILS_ZIPLINE:
		image_speed = 0;
		image_index = 0;
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
		image_speed = 1;		
		break;
}