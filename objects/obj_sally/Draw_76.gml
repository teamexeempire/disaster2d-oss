var arr = revivalTimes >= 2 ? global.player_eanims : global.player_anims;
sprite_index = arr[? CHARACTER_SALLY][state];

switch(state)
{
	case IDLE:
		image_speed = 1;
		break;
		
	case BALANCING:
		image_xscale = edgeDir;
		image_speed = 1;
		break;
		
	case HURT:
		image_speed = 0.4;
		break;
		
	case WALK:
		image_speed = 0.2 + (abs(xspd) / (maxHSpeed));
		break;
		
	case FALL:
		image_index = 0;
		break;
		
	case RUN:
		image_speed = max(abs(xspd) / 20, 0.5);
		break;
		
	case JUMP:
		if(yspd > 0)
		{
			image_speed = 1;
			if(image_index >= image_number - 1)
				image_index = image_number - 1;
		}
		else
			image_speed = 0;
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
		image_speed = 1;
		
		// Stop on last frame
		if(image_index >= image_number - 1)
			image_index = image_number - 1;
			
		break;
		
	case SPIN:
		image_speed = abs(xspd) / 5;
		break;
		
	case SALLY_SLIDE:
		image_speed = 0;
		break;
		
	case SALLY_ATTACK:
		image_speed = 1;
		if(image_index >= image_number - 1)
		{
			isAttacking = false;
			image_index = image_number - 1;
		}
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
	case 16:
		image_speed = 1;
		break;
	
}