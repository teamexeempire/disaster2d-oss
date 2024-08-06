function scr_controls_keycode_to_key(code)
{
	switch(code)
	{
		case -1: return "???";
		case vk_backspace: return "backspace";
		case vk_tab: return "tab";
		case vk_enter: return "enter";
		case vk_space: return "space";
		
		case vk_shift: return "shift";
		case vk_control: return "ctrl";
		case vk_alt: return "alt";
		
		case vk_lshift: return "lshift";
		case vk_lcontrol: return "lctrl";
		case vk_lalt: return "lalt";
		
		case vk_rshift: return "rshift";
		case vk_rcontrol: return "rctrl";
		case vk_ralt: return "ralt";
		
		case vk_pause: return "pause";
		case 20: return "capslock";
		case vk_escape: return "esc";
		case vk_pagedown: return "pdown";
		case vk_pageup: return "pup";
		case vk_end: return "end";
		case vk_home: return "home";
		case vk_left: return "left";
		case vk_up: return "up";
		case vk_right: return "right";
		case vk_down: return "down";
		case vk_insert: return "insert";
		case vk_delete: return "delete";
		case vk_numpad0: return "num 0";
		case vk_numpad1: return "num 1";
		case vk_numpad2: return "num 2";
		case vk_numpad3: return "num 3";
		case vk_numpad4: return "num 4";
		case vk_numpad5: return "num 5";
		case vk_numpad6: return "num 6";
		case vk_numpad7: return "num 7";
		case vk_numpad8: return "num 8";
		case vk_numpad9: return "num 9";
		case vk_f1: return "f1";
		case vk_f2: return "f2";
		case vk_f3: return "f3";
		case vk_f4: return "f4";
		case vk_f5: return "f5";
		case vk_f6: return "f6";
		case vk_f7: return "f7";
		case vk_f8: return "f8";
		case vk_f9: return "f9";
		case vk_f10: return "f10";
		case vk_f11: return "f11";
		case vk_f12: return "f12";
		default: return string_lower(chr(code));
	}
}