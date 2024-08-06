y -= vel;
color = merge_color(#ee9428, #874d05, (sin(current_time / 100.0) + 1) / 2.0);

if(!ignore)
{
	vel -= 0.15;
	
	if(vel < 0)
	{
		vel = 0;
		ignore = true;
		alarm[0] = 60;
	}
}

if(doShit)
{
	y -= 0.05;
	
	scale -= (1.05 - scale);

	if(scale <= 0)
		instance_destroy();
}