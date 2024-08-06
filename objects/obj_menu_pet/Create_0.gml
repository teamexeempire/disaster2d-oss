image_speed = 0;
offset = 0;
sY = y;
offff = random(99999);
spr = spr_pet_flicky;
percent = "";
name = "";

switch(index)
{
	case -1:
		price = 0;
		spr = spr_pet_none;
		break;
		
	case 0:
		spr = spr_pet_flicky;
		name = "flicky";
		percent = "(def.)";
		break;
		
	case 1:
		spr = spr_pet_chao;
		name = "chao";
		percent = "(def.)";
		break;
		
	case 2:
		spr = spr_pet_metal;
		name = "metal";
		percent = "(def.)";
		break;
		
	case 3:
		spr = spr_pet_daldol_b;
		name = "t. doll";
		percent = "(def.)";
		break;
		
	case 4:
		spr = spr_pet_majin;
		name = "majong";
		percent = "(def.)";
		break;
		
	case 5:
		spr = spr_pet_mknux;
		name = "m. knux";
		percent = "(def.)";
		break;
		
	case 6:
		name = "eggor";
		percent = "(def.)";
		spr = spr_pet_egg;
		break;
}

from = [ 0, 0, 0, 0 ];
to =   [ 0, 0, 0, 0 ];

if(index != -1)
{
	from = obj_unlockables.petPallettes[? index].from;
	to = obj_unlockables.petPallettes[? index].to;
}
			
var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));

percent = $"\n({floor(v2)})";

click = function()
{
	obj_menu.buttonSelected(bid, bcolumn, 0, true);
	
	if(!isAvaiable())
	{
		if(obj_achivements.mercoins >= price)
		{
			obj_achivements.mercoins -= price;
			array_push(obj_unlockables.trades, $"pet{index}");
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
		
	if(obj_unlockables.pet == index && index != -1)
	{
		to = scr_pallete_shift(to, 15, 0, 0);
		
		var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
		var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
		
		percent = $"\n({floor(v2)})";
		
		obj_unlockables.petPallettes[? index].to = to;
	}
	
	obj_unlockables.pet = index;
	obj_unlockables.save();
}

isAvaiable = function()
{
	if(price == 0)
		return true;
		
	return array_contains(obj_unlockables.trades, $"pet{index}");
}