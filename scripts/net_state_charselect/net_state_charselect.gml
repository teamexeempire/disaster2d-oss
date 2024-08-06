function net_state_charselect(rbuff, nps, isPasstrough)
{
	switch(nps)
	{
		case PacketType.SERVER_CHAR_TIME_SYNC:
		{
			if(isPasstrough)
				break;
			
			if(!instance_exists(obj_lobby))
				break;
				
			with(obj_lobby)
			{
				countScale = 1;
				charTimer = buffer_read_s(rbuff, buffer_u8);
				
				if(charTimer <= 3)
				{
					countScale = 1.5;
					audio_play_sound(snd_clock, 0, false);
				}
			}
			break;
		}
		
		case PacketType.SERVER_LOBBY_GAME_START:
		{			
			if(isPasstrough)
				break;
				
			with(obj_lobby)
				state = 3;
			
			state = STATE_GAME;
			
			var ch = 0;
			if(global.character == CHARACTER_EXE)
				ch = global.exeCharacter;
			else
				ch = obj_netclient.players[? obj_netclient.exeId].exeCharacter;
			
			switch(ch)
			{
				case EXE_ORIGINAL:
					audio_play_sound(snd_exe_laugh, 0, false);
					break;
					
				case EXE_CHAOS:
					audio_play_sound(snd_chaos_laugh, 0, false);
					break;
					
				case EXE_EXETIOR:
					audio_play_sound(snd_exetior_laugh, 0, false);
					break;
					
				case EXE_EXELLER:
					audio_play_sound(snd_exeller_laugh, 0, false);
					break;
			}
			break;
		}
			
		case PacketType.SERVER_LOBBY_CHARACTER_RESPONSE:
		{			
			if(isPasstrough)
				break;
				
			var char = buffer_read_s(rbuff, buffer_u8);
			var result = buffer_read_s(rbuff, buffer_bool);
			
			if(result)
			{
				global.character = char;
				global.player = player_get(char);
				
				with(obj_lobby_icon)
				{
					if(master_id != obj_netclient.nid)
						continue;
						
					isSelected = true;
					offset = 3;
					
					sprite_index = spr_lobby_icon;
					image_index = char + 1;
					image_xscale = 0;
				}
				
				var table = obj_unlockables.palettes[? global.character];
				
				global.palleteFrom = table.from;
				global.palleteTo = table.to;
				global.palleteName = table.name;
				
				audio_play_sound(snd_clock, 0, false);
			}
			else
			{
				audio_play_sound(snd_nono, 0, false);
				avCharacters[char] = false;
			}
			
			break;
		}
		
		case PacketType.SERVER_LOBBY_EXECHARACTER_RESPONSE:
		{				
			if(isPasstrough)
				break;
				
			var char = buffer_read_s(rbuff, buffer_u8);
			var result = buffer_read_s(rbuff, buffer_bool);
			
			global.character = CHARACTER_EXE;
			global.exeCharacter = char;
			global.player = player_getexe(char);
			
			with(obj_lobby_icon)
			{
				if(master_id != obj_netclient.nid)
					continue;
					
				isSelected = true;
				offset = 3;
				
				switch(char)
				{							
					case EXE_ORIGINAL:
						sprite_index = spr_lobby_exeicon;
						break;
						
					case EXE_CHAOS:							
						sprite_index = spr_lobby_exeicon2;
						break;
						
					case EXE_EXETIOR:
						sprite_index = spr_lobby_exeicon3;
						break;
						
					case EXE_EXELLER:
						sprite_index = spr_lobby_exeicon4;
						break;
				}
				
				image_index = 0;
				image_xscale = 0;
			}
			
			var table = obj_unlockables.palettes[? global.exeCharacter + PALETTE_EXE];
			
			global.palleteFrom = table.from;
			global.palleteTo = table.to;
			global.palleteName = table.name;
			
			audio_play_sound(snd_clock, 0, false);
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHARACTER_CHANGE:
		{				
			if(isPasstrough)
				break;
				
			var pid = buffer_read_s(rbuff, buffer_u16);
			var char = buffer_read_s(rbuff, buffer_u8);
			
			if(!ds_map_exists(players, pid))
				break;
			
			if(obj_netclient.exeId == pid)
			{
				players[? pid].character = CHARACTER_EXE;
				players[? pid].exeCharacter = char;
			}
			else
			{
				players[? pid].character = char;
				avCharacters[char] = false;
			}
			
			with(obj_lobby_icon)
			{
				if(master_id != pid)
					continue;
					
				isSelected = true;
				offset = 3;
				
				if(obj_netclient.exeId == pid)
				{
					switch(char)
					{									
						case EXE_ORIGINAL:
							sprite_index = spr_lobby_exeicon;
							break;
							
						case EXE_CHAOS:							
							sprite_index = spr_lobby_exeicon2;
							break;
							
						case EXE_EXETIOR:
							sprite_index = spr_lobby_exeicon3;
							break;
							
						case EXE_EXELLER:
							sprite_index = spr_lobby_exeicon4;
							break;
					}
					
					image_xscale = 0;
				}
				else
				{
					sprite_index = spr_lobby_icon;
					
					image_xscale = 0;
					image_index = char + 1;
				}
			}
			
			audio_play_sound(snd_clock, 0, false);
			break;
		}
	}
	
	return false;
}