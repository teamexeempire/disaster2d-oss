if(global.timeMinutes < 1)
	moved = true;
	
if(global.player.isDead || global.player.revivalTimes >= 2)
	moved = true;

if(!moved)
{
	if(fade < 1.0)
		fade += 0.016;
	else
		fade = 1.0;
}
else
{		
	if(fade > 0)
		fade -= 0.016;
	else
	{
		if(audio_is_playing(snd_bos))
			audio_stop_sound(snd_bos);
		
		fade = 0;
		instance_destroy();
	}
}

if(terraria)
{
	draw_set_font(fnt_big);
	draw_text_color(3, 240-60, terraText, c_black, c_black, c_black, c_black, 1);
	draw_text_color(4, 240-59, terraText, c_black, c_black, c_black, c_black, 1);
	draw_text_color(5, 240-60, terraText, c_black, c_black, c_black, c_black, 1);
	draw_text_color(4, 240-61, terraText, c_black, c_black, c_black, c_black, 1);
	draw_text_color(4, 240-60, terraText, #32FF82, #32FF82, #32FF82, #32FF82, 1);
}
else
{
	for(var i = 1; i < textLen + 1; i++)
	{
		var _ch = string_char_at(text, i);
		scr_text_spr(480/2-textWidth/2 + i * 8 + random_range(-2, 2), 160 + sin(timer + i * 10 + random_range(-10, 10)), _ch , c_red, fade);
	}
}

timer += 0.50;
scr_player_slow(5);