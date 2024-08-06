y = sY + sin(current_time / 550 + sS) * 4;

if(instance_exists(global.player))
{
	if(global.character - 1 == image_index)
	{
		if(global.player.revivalTimes != 1 || global.player.hp > 0)
			return;
		else
			exists = false;
	}
}

if(instance_exists(obj_player_puppet))
{
	var inst = self;
	
	with(obj_player_puppet)
	{
		if(character - 1 == inst.image_index)
		{
			if(revivalTimes != 1 || hp > 0)
				return;
			else
			{
				inst.exists = false;
				break;
			}
		}	
	}
}

if(exists)
	return;
	
if(image_alpha < 1)
	image_alpha += 0.016 * 0.25;