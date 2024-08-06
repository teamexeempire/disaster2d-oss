var _x = 0;
var _y = 0;
var _fmt = 0;

if(type == 0)
{
	_x = 26/2;
	_y = 26/2;
	frame += 0.15;
}
else if(type == 3)
{
	_x = 24/2;
	_y = 24/2 + 1;
}
else
{
	_x = 0;
	_y = sprite_get_height(icon);
}

if(type <= 1)
{
	scr_text_spr(x + 47, y + 17, $"{kills}", image_blend);
	scr_text_spr(x + 83, y + 17, $"{damage}", image_blend);
	scr_text_spr(x + 116, y + 17, $"{rings}", image_blend);
	scr_text_spr(x + 152, y + 17, $"{stun_time} sec.", image_blend);
	
	if(type == 1)
	{
		scr_text_spr(x + 194 + 9, y + 17, $"{floor(surv_time / 60)}:{string_replace_all(string_format(surv_time % 60, 2, 0), " ", "0")}", image_blend);
		_fmt = 1;
	}
	else
		_fmt = 2;
}
else
{
	scr_text_spr(x + 47, y + 17, $"{floor(surv_time / 60)}:{string_replace_all(string_format(surv_time % 60, 2, 0), " ", "0")}", image_blend);
	scr_text_spr(x + 92, y + 17, $"{floor(danger_time / 60)}:{string_replace_all(string_format(danger_time % 60, 2, 0), " ", "0")}", image_blend);
	scr_text_spr(x + 132, y + 17, $"{rings}", image_blend);
	scr_text_spr(x + 168, y + 17, $"{hp_restored}", image_blend);
	scr_text_spr(x + 197, y + 17, $"{damage_taken}", image_blend);
	scr_text_spr(x + 226, y + 17, $"{stuns}", image_blend);
	_fmt = 0;
}

draw_sprite_ext(icon, frame, x + _x, y + _y, 1, 1, 0, image_blend, 1);
scr_text_spr(x + 34, y + 3, nick, image_blend);
draw_sprite_ext(spr_results_icons, _fmt, x, y, 1, 1, 0, image_blend, 1);