function net_state_pending(rbuff, nps, isPasstrough)
{
	switch(nps)
	{
		case PacketType.SERVER_IDENTITY_RESPONSE:
		{
			if(isPasstrough)
				break;
				
			var _wait = buffer_read_s(rbuff, buffer_bool);
			nid = buffer_read_s(rbuff, buffer_u16);
			
			if(!_wait)
			{
				scr_play_music(mus_waiting);
				obj_menu_waiting.sprite_index = spr_menu_waiting;
				
				with(obj_minigame)
				{
					show = true;
					alarm[2] = 60 * 2;
				}
				
				break;
			}
			isReady = true;
			state = STATE_LOBBY;
			
			room_goto(room_lobby);
			var buffer = cpacket_tcp(PacketType.CLIENT_LOBBY_PLAYERS_REQUEST, false);
			send_server_tcp(buffer);
			return true;
		}
		
		case PacketType.SERVER_GAME_TIME_SYNC:
		{				
			if(isPasstrough)
				break;
				
			var _timer = buffer_read_s(rbuff, buffer_u16);
			
			if(instance_exists(obj_menu_waiting))
			{
				with(obj_menu_waiting)
				{
					draw_clock = true;
					time_minutes = ceil((_timer+1) / 3600) - 1;
					time_seconds = ceil(_timer /  60) %  60;
					timeFrame++;
					
					if(time_minutes == 0 && time_seconds <= 10)
						audio_play_sound(snd_clock, 1, false);
				}
			}
			break;
		}
		
		case PacketType.SERVER_WAITING_PLAYER_INFO:
		{
			if(isPasstrough)
				break;
			
			var _ingame = buffer_read_s(rbuff, buffer_bool);
			var _id = buffer_read_s(rbuff, buffer_u16);
			var _nick = buffer_read_s(rbuff, buffer_string);
			
			if(_ingame)
			{
				var _exe = buffer_read_s(rbuff, buffer_bool);
				var _char = buffer_read_s(rbuff, buffer_s8);
			
				with(obj_menu_waiting)
					ds_map_set(players, _id, { "nid": _id, "scale": 0, "icon": 19954, "nickname": _nick, "exe": _exe, "char": _char } );
			}
			else
			{
				var _sid = buffer_read_s(rbuff, buffer_s8);
				
				with(obj_menu_waiting)
					ds_map_set(players, _id, { "nid": _id, "scale": 0, "icon": _sid, "nickname": _nick, "exe": -1, "char": -1 } );
			}
			
			if(!audio_is_playing(snd_ring))
				audio_play_sound(snd_ring, 0, false);
			break;
		}
		
		case PacketType.CLIENT_CHAT_MESSAGE:
		{				
			if(isPasstrough)
				break;
				
			var _id = buffer_read_s(rbuff, buffer_u16);
			var _msg = buffer_read_s(rbuff, buffer_string);
			
			with(obj_menu_waiting)
			{
				if(_id == 0)
				{
					lobby_add_message("(server)", _msg);
					break;
				}
			
				if(!ds_map_exists(players, _id))
					break;
			
				var _plr = players[? _id];
				lobby_add_message(_plr.nickname, _msg);
			}
			
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEKICK:
		{
			var inst = instance_create_depth(0, 0, 0, obj_menu_waitkick);
			inst.str = "kick";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEKICK;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEBAN:
		{
			var inst = instance_create_depth(0, 0, 0, obj_menu_waitkick);
			inst.str = "ban";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEBAN;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEOP:
		{
			var inst = instance_create_depth(0, 0, 0, obj_menu_waitkick);
			inst.str = "op";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEOP;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_RESULTS:
		{
			lvlId = buffer_read_s(rbuff, buffer_u8);
			
			isReady = true;
			gameEnds = true;
			state = STATE_RESULTS;
			room_goto(room_results);
			return true;
		}
		
		case PacketType.SERVER_PREIDENTITY:
		{
			net_identity();
			break;
		}
	}
	
	return false;
}