if((!voteKick && !chatMode && keyboard_check_pressed(global.KeyB)) || point_in_rectangle(mouse_x, mouse_y, 223, 153, 223+32, 153+16) && mouse_check_button_pressed(mb_any))
	net_reset();

if(!obj_minigame.show)
	return;

if(chatMode)
{
	if(keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
		keyboard_string = clipboard_get_text();
		
	chatMsg = string_copy(string_lower(keyboard_string), 0, 36);
	if(string_length(keyboard_string) > 36)
		keyboard_string = chatMsg;
}