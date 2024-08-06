if(bid == obj_menu.bSelected && bcolumn == obj_menu.bSelectedColumn)
	image_blend = #910000;
else
{
	image_blend = c_white;
	
	if(obj_unlockables.pet == index)
		image_blend = c_green;
}

draw_self();

var time = sin(current_time / 400 + offff);
var spd = current_time / 150;

if(index == 1)
	spd /= 10;
	
if(spr == spr_pet_none)
	time = 0;

scr_palette_swap(from, to);
draw_sprite(spr,spd , x + 32, y + 32 + time * 3);
shader_reset();

var state = $"\\price `{price}~";
if(isAvaiable())
{
	state = "|equip~";
	if(obj_unlockables.pet == index)
		state = "@equipped~";
}

if(index != -1)
{
	var skinWidth = scr_text_spr(-200, -200, $"{name}{percent}");
	scr_text_spr(x - skinWidth / 2 + 32, y+6, $"{name}{percent}");
}
else
{
	var skinWidth = scr_text_spr(-200, -200, $"none");
	scr_text_spr(x - skinWidth / 2 + 32, y+6, $"none");
}

var stateWidth = scr_text_spr(-200, -200, state);
scr_text_spr(x - stateWidth / 2 + 32, y+sprite_height-12, state);

if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonPressed(bid, bcolumn);