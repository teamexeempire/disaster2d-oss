if(popup)
{
	draw_sprite(spr_pay_us_money2, 0, x - 4, y);
	
	if(mouse_check_button_pressed(mb_left))
	{
		if(point_in_rectangle(mouse_x, mouse_y, 105, 208, 128, 212))
			url_open("https://boosty.to/handyrka");
		
		if(point_in_rectangle(mouse_x, mouse_y, 105, 222, 128, 226))
			url_open("https://boosty.to/merfamphetamine");
	}
}

if(mouse_check_button_pressed(mb_left))
{
	if(position_meeting(mouse_x, mouse_y, self))
		popup = !popup;
	else
		popup = false;
}

if(popup && keyboard_check_pressed(vk_anykey))
	popup = false;
	
draw_self();