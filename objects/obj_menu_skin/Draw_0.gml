if(bid == obj_menu.bSelected && bcolumn == obj_menu.bSelectedColumn)
	image_blend = #910000;
else
{
	image_blend = c_white;
			
	if(obj_unlockables.palettes[? tableIndex].name == skinName[palette+1])
		image_blend = c_green;
}

draw_self();

var spr = spr_merfurmu;
var offX = 0;
var offY = 0;
var frame = 0;

if(!exe)
{
	switch(character)
	{
		case 0:
			spr = spr_merfurmu;
			break;
			
		case CHARACTER_TAILS:
			spr = demon ? spr_etails_idle : spr_tails_idle;
			offX += 4;
			break;
			
		case CHARACTER_KNUX:
			spr = demon ? spr_eknux_idle : spr_knux_idle;
			break;
			
		case CHARACTER_EGGMAN:
			spr = demon ? spr_eegg_idle : spr_egg_idle;
			offY += 7;
			break;
			
		case CHARACTER_CREAM:
			spr = demon ? spr_ecream_idle : spr_cream_idle;
			offX += 2;
			break;
			
		case CHARACTER_AMY:
			spr = demon ? spr_eamy_idle : spr_amy_idle;
			break;
			
		case CHARACTER_SALLY:
			spr = demon ? spr_esally_idle : spr_sally_idle;
			offY += 4;
			break;
	}
}
else
{
	switch(character)
	{
		case EXE_ORIGINAL:
			spr = spr_exe_idle;
			break;
			
		case EXE_CHAOS:
			spr = spr_chaos_won;
			frame = 3;
			break;
			
		case EXE_EXETIOR:
			spr = spr_exetior_idle;
			break;
			
		case EXE_EXELLER:
			spr = spr_exeller_idle;
			break;
	}
}

scr_palette_swap(from, to);

if(!exe)
{
	if(character == CHARACTER_TAILS && !demon)
		draw_sprite(spr_tails_tail2, 0, x + 32 + 2 + offX, y + 44 + 4);
	else if(character == CHARACTER_TAILS)
		draw_sprite(spr_etails_tail2, 0, x + 32 + 2 + offX, y + 44 + 4);
}

draw_sprite(spr, frame, x + 32 + offX, y + 44 + offY);
shader_reset();

var state = $"\\price `{price}~";

if(isAvaiable())
{
	state = "|equip~";
	if(obj_unlockables.palettes[? tableIndex].name == skinName[palette+1])
		state = "@equipped~";
}

var skinWidth = scr_text_spr(-200, -200, $"{skinName[palette+1]}{percent}");
var stateWidth = scr_text_spr(-200, -200, state);

scr_text_spr(x - skinWidth / 2 + 32, y+6, $"{skinName[palette+1]}{percent}");
scr_text_spr(x - stateWidth / 2 + 32, y+sprite_height-12, state);

if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonPressed(bid, bcolumn);