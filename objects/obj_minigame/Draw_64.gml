if(!show)
	return;

if(!ingame && alarm[2] > 0 && current_time % 480 > 240)
	draw_sprite(spr_minisnoc_text, 0, 480/2, 34 + 81/2 + 28);

if(ingame)
{
	var _score = string_replace_all(string_format(cscore, 5, 0), " ", "0");
	var _hiscore = string_replace_all(string_format(hiscore, 5, 0), " ", "0");
	scr_text_spr(480-80, 34, $"score {_score}\n\\hi~    {_hiscore}");
	
	var charge = 1.0 - (obj_minisnoc.alarm[0] / (3 * 60));
	draw_sprite_ext(spr_minisnoc_charg, 0, 2 + (charge) * 3, 110, 1, 1, 0, charge >= 1 ? c_white : c_red , charge);
}

if(alarm[1] > 0)
	draw_sprite(spr_minisnoc_text, 1, 480/2, 34 + 4);