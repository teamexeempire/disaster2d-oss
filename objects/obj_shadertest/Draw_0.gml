var ch = char;

if(char > CHARACTER_SALLY)
{
	ch -= CHARACTER_SALLY + 1;
	ch += PALETTE_EXE;
}
else if(demon)
	ch += PALETTE_DEMON;

switch(char)
{
	case CHARACTER_TAILS:
		sprite_index = demon ? spr_etails_idle : spr_tails_idle;
		break;
		
	case CHARACTER_KNUX:
		sprite_index = demon ? spr_eknux_idle : spr_knux_idle;
		break;
		
	case CHARACTER_EGGMAN:
		sprite_index = demon ? spr_eegg_idle : spr_egg_idle;
		break;
		
	case CHARACTER_CREAM:
		sprite_index = demon ? spr_ecream_idle : spr_cream_idle;
		break;
		
	case CHARACTER_AMY:
		sprite_index = demon ? spr_eamy_idle : spr_amy_idle;
		break;
		
	case CHARACTER_SALLY:
		sprite_index = demon ? spr_esally_idle : spr_sally_idle;
		break;
		
	case CHARACTER_SALLY+1:
		sprite_index = spr_exe_idle;
		break;
		
	case CHARACTER_SALLY+2:
		sprite_index = spr_chaos_attack1;
		break;
		
	case CHARACTER_SALLY+3:
		sprite_index = spr_exetior_idle;
		break;
		
	case CHARACTER_SALLY+4:
		sprite_index = spr_exeller_idle;
		break;
}

if(ind == -1)
{
	draw_self();
	return;
}

var from = global.palettes[? ch][ind].from;
var to = global.palettes[? ch][ind].to;

scr_palette_swap(from, to);
draw_self();
shader_reset();

var text = "none";

if(ch <= CHARACTER_SALLY)
{
	if(!demon && ind > -1)
	{
		if(ind == 0)
			text = "classic";
			
		if(ind == 1)
			text = "sexcentric";
	}
	else if(demon && ind > -1)
	{
		text = "sexcentric";
	}
}
else
{
	if(ind > -1)
		text = "alt";
}

scr_text_spr(x, y-40, text);