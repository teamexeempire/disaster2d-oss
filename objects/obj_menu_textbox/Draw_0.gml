if(obj_menu.bSelected == bid)
{
	if(keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
		keyboard_string = clipboard_get_text();
		
	if(keyboard_string != prevText)
	{
		if(string_length(keyboard_string) > limit)
			keyboard_string = string_copy(keyboard_string, 0, limit);
		
		text = string_lower(keyboard_string);
		text = string_replace_all(text, "\r", "");
		text = string_replace_all(text, "\t", "");
		text = string_replace_all(text, "\n", "");
		
		obj_menu.textChanged(bid, text);
		prevText = keyboard_string;
	}
	
	obj_menu.ignoreButtons = true;
}
else if(keyboard_virtual_status())
	keyboard_virtual_hide();
      
if(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, self))
	obj_menu.buttonSelected(bid, -1);

draw_self();
scr_text_spr(x + 2, y + 5, text == "" ? placeholder : text, text == "" ? c_grey : c_white);