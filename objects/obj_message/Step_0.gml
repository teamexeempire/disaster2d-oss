if(keyboard_check_pressed(global.KeyA) || (point_in_rectangle(mouse_x, mouse_y, 223, 153, 223+32, 153+16) && mouse_check_button_pressed(mb_any)))
{
	global.errorCode = -1;
	net_reset();
}