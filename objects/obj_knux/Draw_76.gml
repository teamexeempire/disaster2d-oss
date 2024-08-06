var arr = revivalTimes >= 2 ? global.player_eanims : global.player_anims;
sprite_index = arr[? CHARACTER_KNUX][state];

if(revivalTimes < 2 && state == IDLE && room == room_marijuna)
	sprite_index = spr_knux_marijuna;

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
		
	case WALK:
		image_speed = 0.2 + (abs(xspd) / (maxHSpeed));
		break;
		
	case FALL:
		image_index = yspd > 0 ? 1 : 0;
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
		image_speed = 1;
		
		// Stop on last frame
		if(image_index >= 1)
			image_index = 1;
			
		break;
		
	case SPIN:
		image_speed = abs(xspd) / 5;
		break;
		
	case KNUX_ATTACK:
		image_speed = 0.1;
		
		if(image_index >= image_number - 1)
		{
			isAttacking = false;
		}
		break;
		
	case KNUX_AIR_ATTACK:
		image_speed = 1.5;
		
		if(image_index >= image_number - 1)
		{
			isAttacking = false;
			isGrounded = false;
		}
		break;
		
	case KNUX_GLIDE:
		image_speed = 0;
		image_xscale = 1;
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
		image_speed = 1;		
		break;
}