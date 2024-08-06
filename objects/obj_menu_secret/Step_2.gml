if(obj_menu.submenu != SUBMENU_ABOUT_CREDITS)
	return;

array_foreach(codes, function (_element, _index) 
{
	var _petCode = _index + 7;
	if(string_ends_with(keyboard_string, _element) && obj_unlockables.pet != _petCode)
	{		
		obj_unlockables.pet = _petCode;
		obj_unlockables.save();
		
		audio_play_sound(snd_ring, 0, false);
	}
});