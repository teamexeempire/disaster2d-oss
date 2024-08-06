draw_self();

if(mouse_check_button(mb_any) && position_meeting(mouse_x, mouse_y, self))
	obj_menu_achivements.move(image_yscale);