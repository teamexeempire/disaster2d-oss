if(!obj_minigame.ingame)
	return;
	
shooting = false;

if(random_range(0, 15) <= 10)
	shooting = true;

alarm[0] = 60 * 7;