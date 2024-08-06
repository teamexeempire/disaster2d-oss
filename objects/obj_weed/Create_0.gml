fade = 0;
weed = false;
weed_anim = -1;
weed_progress = 0;
scroll = 0;

depth = -400;
alarm[1] = irandom_range(5, 7) * 60;

if(global.character != CHARACTER_EXE)
	alarm[0] = (20 + random_range(1, 2)) * 60;