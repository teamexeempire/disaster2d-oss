if(submenu == 999)
	image_blend = #666666;

draw_self();

if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonPressed(bid, bcolumn);