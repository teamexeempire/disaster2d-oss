sprite_index = global.player_exesanims[? EXE_CHAOS][state + (slimeTimer > 0 && slimeAnim ? CHAOS_AIRTRANSFORM+1 : 0)];
switch(state)
{
	case IDLE:
		image_speed = 1;
		break;
		
	case HURT:
	case CHAOS_ZIPLINE:
		if(slimeTimer > 0)
		{
			image_speed = 1;
			break;
		}
		
		image_speed = 0;
		image_index = 0;
		break;
		
	case BALANCING:
		image_xscale = edgeDir;
		image_speed = 1;
		break;
		
	case FALL:
		image_speed = 1;
		image_index = yspd > 0 ? 1 : 0;
		break;
		
	case WALK:
		if(slimeTimer > 0)
		{
			image_speed = (abs(xspd) / (maxHSpeed)) * 2.5
			break;
		}
		
		image_speed = (abs(xspd) / (maxHSpeed)) * 1.8;
		break;
		
	case RUN:
		if(slimeTimer > 0)
		{
			image_speed = 2.6;
			break;
		}
		
		image_speed = max(abs(xspd) / 20, 0.5) * 1.2;
		break;
	
	case JUMP:
		if(slimeTimer > 0)
		{
			image_speed = 1.3;
			if(image_index >= image_number - 1)
				image_index = image_number - 1;
			break;
		}
		
		image_speed = max(abs(xspd) / 20, 0.5) * 1.2;
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
		
	case CHAOS_ATTACK:
		image_speed = 2;
		
		if(image_index >= image_number - 1)
		{
			xspd = xspd * .7;
			gspd = gspd * .7;
			isAttacking = false;
		}
		break;
		
	case CHAOS_AIR_ATTACK:
		if(abs(xspd) > 0)
			image_xscale = sign(xspd);
			
		image_speed = 0.8;
		break;
		
	case CHAOS_SHOCKED:
	{
		image_speed = 0.5;
		break;
	}
	
	case CHAOS_LOST:
		image_speed = 1;
			
		if(image_index >= image_number - 1)
			image_index = image_number - 1;
		break;
	
	case CHAOS_LOST2:
		image_speed = 1;
		
		if(image_index >= image_number - 1)
			image_index = image_number - 5;
		
		break;
	
	case CHAOS_WON:
		image_speed = 1;
		
		if(image_index >= image_number - 1)
			image_index = image_number - 1;
		break;
		
	case CHAOS_STUCKBALLS:
	case CHAOS_STUCKDICKS:
		image_xscale = stuckDir;
		if(stuckTimer >= 30/2)
			image_index = (current_time / 10) % 2;
		else
			image_index = 2;
		break;
		
	case CHAOS_AIRTRANSFORM:
	case CHAOS_TRANSFORM:
		image_speed = 1;
		
		if(image_index >= image_number - 1)
			slimeAnim = true;
		
		break;
		
	case EMOTION1:
	case EMOTION2:
	case EMOTION3:
		image_speed = 1;
		break;
}