if(submenu == 999)
	image_blend = #666666;

if(obj_menu.bSelected == bid && obj_menu.bSelectedColumn == bcolumn)
{
	draw_sprite(spr_menu_public2, timer, x, y + offset);
	timer += 0.25;
	
	var mes = scr_text_spr(-999, -999, region);
	scr_text_spr(480/2 - mes/2, 214, region);
}
draw_self();

if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonPressed(bid, bcolumn);