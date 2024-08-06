image_speed = 0;
offset = 0;
off = 0;
sY = y;
char = "exe";

switch(floor(index/2))
{
	case 0:
		if(index % 2 == 0)
			spr = spr_exe_emotion3;
		else
			spr = spr_exe_emotion2;
		
		char = "exe";
		break;
		
	case 1:
		if(index % 2 == 0)
			spr = spr_chaos_emotion1;
		else
			spr = spr_chaos_emotion2;
			
		char = "chaos";
		break;
		
	case 2:
		if(index % 2 == 0)
			spr = spr_exetior_emotion3;
		else			 
			spr = spr_exetior_emotion2;
		
		char = "exetior";
		break;
		
	case 3:
		if(index % 2 == 0)
		{
			spr = spr_exeller_emotion3;
			off = 16;
		}
		else
			spr = spr_exeller_emotion2;
			
		char = "exeller";
		break;
}

click = function()
{
	obj_menu.buttonSelected(bid, bcolumn, 0, true);
	
	if(!isAvaiable())
	{
		if(obj_achivements.mercoins >= price)
		{
			obj_achivements.mercoins -= price;
			array_push(obj_unlockables.trades, $"t{char}{index % 2}");
			obj_unlockables.save();
			obj_achivements.save();
			
			audio_play_sound(snd_cash, 0, false);
			obj_menu.buttonSelected(bid, bcolumn, 0, true);
		}
		else
		{
			audio_play_sound(snd_nono, 0, false);
			return;
		}	
	}
	else
		audio_play_sound(snd_menu_press, 0, false);
}

isAvaiable = function()
{
	if(price == 0)
		return true;
		
	return array_contains(obj_unlockables.trades, $"t{char}{index % 2}");
}