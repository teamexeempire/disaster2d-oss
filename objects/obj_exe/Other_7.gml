switch(state)
{
	case IDLE:
		image_index = image_number - 25;
		break;
		
	case EMOTION1:
		if(keyboard_check(global.KeyEm1))
			image_index = 0;
		else
		{
			image_index = 0;
			state = IDLE;
			emotion = false;
		}
		break;
		
	case EMOTION2:
		if(keyboard_check(global.KeyEm2))
			image_index = 0;
		else
		{
			image_index = 0;
			state = IDLE;
			emotion = false;
		}
		break;
		
	case EMOTION3:
		if(keyboard_check(global.KeyEm3))
			image_index = 0;
		else
		{
			image_index = 0;
			state = IDLE;
			emotion = false;
		}
		break;
}