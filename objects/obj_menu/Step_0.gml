buttonA = false;

if(bind)
{
	if(keyboard_check_pressed(vk_anykey))
	{
		 bindChanged(bindBtn, keyboard_lastkey);
		 bind = false;
	}
	return;
}

if(scheme)
{
	if(keyboard_check_pressed(global.KeyUp))
	{
		if(--bSelected < 0)
		{
			bSelectedColumn = -1;
			bSelected = bCount - 1;
		}
		
		buttonSelected(bSelected, bSelectedColumn, 0, true);
		audio_play_sound(snd_menu_select, 0, false);
	}
	
	if(keyboard_check_pressed(global.KeyDown))
	{
		if(++bSelected >= bCount)
			bSelected = 0;
			
		buttonSelected(bSelected, bSelectedColumn, 0, true);
		audio_play_sound(snd_menu_select, 0, false);
	}
	
	if(keyboard_check_pressed(global.KeyLeft))
	{		
		if(--bSelectedColumn < 0)
		{
			if(!buttonListed(bSelected, bSelectedColumn, -1))
				bSelectedColumn = bColumnCount - 1;
		}
		
		buttonSelected(bSelected, bSelectedColumn, -1, true);
		audio_play_sound(snd_menu_select, 0, false);
	}
	
	if(keyboard_check_pressed(global.KeyRight))
	{
		var listed = false;
		
		if(++bSelectedColumn >= bColumnCount)
		{
			if(!buttonListed(bSelected, bSelectedColumn, 1))
				bSelectedColumn = 0;
			else listed = true;
		}
		
		buttonSelected(bSelected, bSelectedColumn, 1, true);
		audio_play_sound(snd_menu_select, 0, false);
		
		if(bSelectedColumn == -1 && !listed)
			buttonListed(bSelected, bSelectedColumn, 1);
	}
}
else
{
	if(keyboard_check_pressed(global.KeyLeft))
	{		
		if(--bSelected < 0)
			bSelected = bCount - 1;
		
		buttonSelected(bSelected, bSelectedColumn, 0, true);
		audio_play_sound(snd_menu_select, 0, false);
	}
	
	if(keyboard_check_pressed(global.KeyRight))
	{
		if(++bSelected >= bCount)
			bSelected = 0;
		
		buttonSelected(bSelected, bSelectedColumn, 0, true);
		audio_play_sound(snd_menu_select, 0, false);
	}
}

if(!ignoreButtons)
{
	if(keyboard_check_pressed(global.KeyA))
	{
		buttonPressed(bSelected, bSelectedColumn);
	}
	
	
	if(keyboard_check_pressed(global.KeyB))
	{
		changeSubmenu(SUBMENU_NONE);
	}
}

if(keyboard_check_pressed(vk_escape))
{
	changeSubmenu(SUBMENU_NONE);
}

if(keyboard_check_pressed(vk_enter))
{
	buttonPressed(bSelected, bSelectedColumn);
}