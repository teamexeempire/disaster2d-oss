if(bid == obj_menu.bSelected && bcolumn == obj_menu.bSelectedColumn)
	image_blend = #910000;
else
{
	image_blend = c_white;
	
	if(array_contains(obj_unlockables.trades, $"t{char}{index % 2}"))
		image_blend = c_green;
}

draw_self();
draw_sprite(spr, current_time / 100, x + 32 + off, y + 32);

var state = $"\\price `{price}~";

if(array_contains(obj_unlockables.trades, $"t{char}{index % 2}"))
	state = "@equipped~";

var stateWidth = scr_text_spr(-200, -200, state);
scr_text_spr(x - stateWidth / 2 + 32, y+sprite_height-12, state);

if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonPressed(bid, bcolumn);