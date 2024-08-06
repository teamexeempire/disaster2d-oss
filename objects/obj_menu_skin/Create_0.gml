image_speed = 0;
offset = 0;
sY = y;

skinName = [
	"default",
	"classic",
	"eccentric",
	"custom"
];

tableIndex = character;
percent = "";

if(demon)
	tableIndex += PALETTE_DEMON;
	
if(exe)
	tableIndex += PALETTE_EXE;

if(exe)
{
	switch(character)
	{
		case EXE_ORIGINAL:
			skinName[2] = "coldblood";
			break;
			
		case EXE_CHAOS:
			skinName[1] = "prismarine";
			skinName[2] = "vermillion";
			break;
			
		case EXE_EXETIOR:
			skinName[2] = "menace";
			break;
			
		case EXE_EXELLER:
			skinName[2] = "oldschool";
			break;
	}
}

if(palette == -1)
{
	from = PALLETE_DEFAULT;
	to = PALLETE_DEFAULT;
}
else if(palette != 2)
{
	from = global.palettes[? tableIndex][palette].from;
	to = global.palettes[? tableIndex][palette].to;
}
else
{
	show_debug_message(tableIndex);
	if(obj_unlockables.palettes[? tableIndex].custom)
	{
		from = obj_unlockables.palettes[? tableIndex].from;
		to = obj_unlockables.palettes[? tableIndex].to;
	}
	else
	{
		from = global.paletteShifts[? tableIndex];
		to = global.paletteShifts[? tableIndex];
		
		if(exe)
		{
			switch(character)
			{
				case EXE_EXELLER:
				case EXE_EXETIOR:
					to = scr_pallete_shift(to, 0, 0, -60);
					
					var v1 = color_get_value(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
					var v2 = color_get_value(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
					
					if(v1 == v2)
						percent = "\n(def.)";
					else
						percent = $"\n({floor(v2)})";
					
					break;
					
				default:
					to = scr_pallete_shift(to, 60, 0, 0);
			
					var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
					var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
					
					if(v1 == v2)
						percent = "\n(def.)";
					else
						percent = $"\n({floor(v2)})";
			}
		}
		else
			to = scr_pallete_shift(to, 60, 0, 0);
			
			var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
			var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
			
			if(v1 == v2)
				percent = "\n(def.)";
			else
				percent = $"\n({floor(v2)})";
	}
}

click = function()
{
	obj_menu.buttonSelected(bid, bcolumn, 0, true);
	
	if(!isAvaiable())
	{
		if(obj_achivements.mercoins >= price)
		{
			obj_achivements.mercoins -= price;
			array_push(obj_unlockables.trades, tradeName);
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
	
	if(palette == 2)
	{
		if(!obj_unlockables.palettes[? tableIndex].custom)
		{
			obj_unlockables.palettes[? tableIndex].custom = true;
			obj_unlockables.palettes[? tableIndex].from = from;
			obj_unlockables.palettes[? tableIndex].to = to;
			obj_unlockables.palettes[? tableIndex].name = skinName[palette+1];
			obj_unlockables.save();
			return;
		}
		
		if(exe)
		{
			switch(character)
			{
				case EXE_EXELLER:
				case EXE_EXETIOR:
					
					var clr = make_color_rgb(to[0] * 255, to[1] * 255, to[2] * 255);
					
					if(color_get_value(clr) < 155)
						to = scr_pallete_shift(to, 0, 0, 75);
					else
						to = scr_pallete_shift(to, 0, 0, -15);
					
					var v1 = color_get_value(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
					var v2 = color_get_value(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
					
					percent = $"\n({floor(v2)})";
					break;
					
				default:
					to = scr_pallete_shift(to, 15, 0, 0);
			
					var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
					var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
					
					if(v1 == v2)
						percent = "\n(def.)";
					else
						percent = $"\n({floor(v2)})";
					
			}
		}
		else
		{
			to = scr_pallete_shift(to, 10, 0, 0);
			
			var v1 = color_get_hue(make_color_rgb(from[0]*255, from[1]*255, from[2]*255));
			var v2 = color_get_hue(make_color_rgb(to[0]*255, to[1]*255, to[2]*255));
			
			if(v1 == v2)
				percent = "\n(def.)";
			else
				percent = $"\n({floor(v2)})";
		}
	}
	else
		obj_unlockables.palettes[? tableIndex].custom = false;	
	
	obj_unlockables.palettes[? tableIndex].from = from;
	obj_unlockables.palettes[? tableIndex].to = to;
	obj_unlockables.palettes[? tableIndex].name = skinName[palette+1];
	obj_unlockables.save();
}

isAvaiable = function()
{
	if(price == 0)
		return true;
		
	return array_contains(obj_unlockables.trades, tradeName);
}