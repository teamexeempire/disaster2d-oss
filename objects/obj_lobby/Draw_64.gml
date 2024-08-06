if(state == 3)
{
	scr_stop_music();
	draw_sprite_ext(spr_black, 0, 0, 0, 1, 1, 0, c_white, fade);
	
	fade += 0.01;
	if(fade > 1)
	{
		room_goto(global.levels[nextMap].rid);
	}
}