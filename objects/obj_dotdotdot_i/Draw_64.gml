if(bgnew == background_dotdotdot)
{
	if(fade3 > 0)
		fade3 -= 0.025;
		
	if(fade2 > 0)
		fade2 -= 0.025;
}
else if(bgnew == background_dotdotdot2)
{
	if(fade3 > 0)
		fade3 -= 0.025;
		
	if(fade2 < 1)
		fade2 += 0.025;
}
else if(bgnew == background_dotdotdot3)
{
	if(fade3 < 1)
		fade3 += 0.025;
		
	if(fade2 > 0)
		fade2 -= 0.025;
}

draw_sprite_ext(spr_screenoverlay2, 0, 0, 0, 1, 1, 0, c_white, fade2); 
draw_sprite_ext(spr_screenoverlay2, 1, 0, 0, 1, 1, 0, c_white, fade3); 