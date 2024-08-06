if(audio_is_playing(mus_waiting) || audio_is_playing(mus_minigame))
{
	var str = "";
	for(var i = 0; i < array_length(chat); i++)
		str += chat[i] + "\n";

	scr_text_spr(3, 148-6+40, str);

	var ind = chatMode;
	if(string_length(chatMsg) > 0)
		ind = 1;

	draw_sprite(spr_lobby_chatbox, ind, 0, 211+40);
	scr_text_spr(2, 214+40, chatMsg);
}

if(!obj_minigame.ingame)
{
	var i = 0;
	for(var k = ds_map_find_first(players); !is_undefined(k); k = ds_map_find_next(players, k)) 
	{
		var plr = ds_map_find_value(players, k);
	
		var _x = 40 + i * 80;
		var _y = 58;
	
		var sprite = spr_lobby_dicon;
		var index = 0;
	
		if(plr.icon == 19954)
		{
			if(plr.exe)
			{
				switch(plr.char)
				{
					case 0:
						sprite = spr_lobby_exeicon;
						break;
					
					case 1:
						sprite = spr_lobby_exeicon2;
						break;
					
					case 2:
						sprite = spr_lobby_exeicon3;
						break;
					
					case 3:
						sprite = spr_lobby_exeicon4;
						break;
				}
			}
			else
			{
				sprite = spr_lobby_icon;
				index = plr.char + 2;
			}
		}
		else
		{
			sprite = spr_lobby_dicon;
			index = plr.icon;
		}
	
		draw_sprite_ext(sprite, index, _x, _y, plr.scale, 1, 0, c_white, 1);
		var _size = scr_text_spr(-2000, -200, plr.nickname);
		scr_text_spr(_x - _size/2, _y + 16, plr.nickname);
	
		if(plr.scale < 1)
			plr.scale += 0.2;
		else
			plr.scale = 1;
		
		i++;
	}	
}

if(voteKick)
{
	draw_sprite(spr_lobby_votekick, (current_time / 300) % 4, 240, 8);
	return;
}

if(!draw_clock)
	return;

draw_sprite(spr_clock, 0, 211, 0);
clockAngle = lerp(clockAngle, (-45 * timeFrame), 0.2);
draw_sprite_ext(spr_clockhand, 0, 212, 11.5, 1, 1, clockAngle, c_white, 1);

draw_sprite(spr_counter, 10, 233, 4);
scr_counter_draw(time_minutes, 224, 4);
scr_counter_draw_m(time_seconds, 244, 4, 2);