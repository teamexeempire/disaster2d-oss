image_speed = 0;
offset = 0;
sY = y;
price = 25;

if(index == 0)
	price = 0;

if(index >= 9 && index <= 17)
	price = 50;
	
if(index >= 18 && index <= 24)
	price = 75;

click = function()
{
	obj_menu.buttonSelected(bid, bcolumn, 0, true);
	
	if(!isAvaiable())
	{
		if(obj_achivements.mercoins >= price)
		{
			obj_achivements.mercoins -= price;
			array_push(obj_unlockables.trades, $"icon{index}");
			obj_achivements.save();
			obj_unlockables.save();
			
			audio_play_sound(snd_cash, 0, false);
			obj_menu.buttonSelected(bid, bcolumn, 0, true);
			return;
		}
		else
		{
			audio_play_sound(snd_nono, 0, false);
			return;
		}	
	}
	else
		audio_play_sound(snd_menu_press, 0, false);
	
	obj_unlockables.lobbyIcon = index;
	obj_unlockables.save();
	
	audio_play_sound(snd_menu_press, 0, false);
}

isAvaiable = function()
{
	if(price == 0)
		return true;
		
	return array_contains(obj_unlockables.trades, $"icon{index}");
}