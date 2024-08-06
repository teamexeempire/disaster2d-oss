if(global.character == CHARACTER_EXE)
	return;
	
if(weed)
{
	var no_frames = sprite_get_number(spr_weed_arms) - 1;
	if(weed_anim < no_frames)
		weed_anim += 0.250;
	else
	{
		weed_anim = no_frames;
		
		if(weed_progress < 1)
			weed_progress += 0.016 / 30;
		else
			weed_progress = 1;
	}
}
else
{
	if(weed_anim > -1)
		weed_anim -= 0.250;
		
	if(weed_progress > 0)
		weed_progress -= 0.016;
	else
		weed_progress = 0;
}

if(weed_anim >= 0)
	draw_sprite(spr_weed_arms, weed_anim, -10 + sin(current_time / 300) * 8 + random_range(-2, 2), -10 + cos(current_time / 300) * 8 + random_range(-2, 2));
	
if(weed_progress > 0)
	draw_sprite_ext(spr_weed_vinjetk, 0, 0, 0, 1, 1, 0, c_white, weed_progress);