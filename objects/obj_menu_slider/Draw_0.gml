if(position_meeting(mouse_x, mouse_y, self))
{
	if(mouse_check_button_pressed(mb_any))
		obj_menu.buttonSelected(bid, -1, true);
	
	if(mouse_check_button(mb_any))
	{
		var raw = (mouse_x - bbox_left) / (bbox_right - bbox_left);
		value = floor(raw * 5) / 5.0;
	}
}

obj_menu.sliderChanged(value);
image_index = value * 5;
draw_self();