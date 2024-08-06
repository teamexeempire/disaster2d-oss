if(os_type == os_android && mouse_check_button(mb_any))
	y -= 1.50;
	
if(keyboard_check(global.KeyDown))
	y -= 2;
else if(keyboard_check(global.KeyUp))
	y += 2;
else 
	y -= 0.25;
	
if(y <= -sprite_height - 38)
	y = room_height - 1 - 38;
	
if(y >= room_height + 38)
	y = -sprite_height + 1 + 38;
	
draw_self();