#macro DR_OTHER 255

function net_tcpprocess(rbuff)
{
	with(obj_netclient)
	{
		var _passtrough = buffer_read_s(rbuff, buffer_u8);
		var nps = buffer_read_s(rbuff, buffer_u8);
		
		switch(nps)
		{			
			case PacketType.SERVER_PLAYER_LEFT:
			{
				if(_passtrough)
					 break;
					 
				var _id = buffer_read_s(rbuff, buffer_u16);
				
				//Free character
				if(state == STATE_PENDING)
				{
					if(room == room_waiting)
					{
						with(obj_menu_waiting)
						{
							if(!ds_map_exists(players, _id))
								break;
				
							ds_map_delete(players, _id);
							audio_play_sound(snd_hurt, 0, false);
						}
					}
				}
				
				if(!ds_map_exists(players, _id))
					break;
				
				if(state == STATE_CHARSELECT && ds_map_exists(players, _id) && players[? _id].character != -1)
					avCharacters[players[? _id].character] = true;
				
				if(state == STATE_LOBBY || state == STATE_VOTE || state == STATE_CHARSELECT)
				{
					with(obj_lobby)
						lobby_player_left(_id);
				}
				
				if(state == STATE_GAME && instance_exists(obj_player_puppet))
				{
					with(obj_player_puppet)
						if(master_id == _id)
							instance_destroy();
							
					if(ds_map_exists(obj_netclient.players, _id))
					{
						var _plr = obj_netclient.players[? _id];
						
						if(room == room_act9)
						{
							with(obj_act9_bodies)
							{
								if(_plr.character - 1 == image_index)
								{
									exists = false;
									break;
								}
							}
						}
					}
				}
				
				ds_map_delete(players, _id);
				show_debug_message("client: " + string(_id) + " left.");
				break;
			}
			
			case PacketType.SERVER_PLAYER_FORCE_DISCONNECT:
			{
				if(_passtrough)
					 break;
				
				if(type == 9)
				{
					isConnected = false;
					reconnAttempts++;
					
					if(reconnAttempts >= 5 || want_lobby != -1)
					{
						want_lobby = -1;
						reconnAttempts = 0;
						global.errorCode = type;
						room_goto(room_message);
						break;
					}
					
					net_join(ip);
					return true;
				}
				
				var msg = buffer_read_s(rbuff, buffer_string);
				show_message_async(msg);
				global.errorCode = 1;
				room_goto(room_message);
			}
			
			case PacketType.SERVER_LOBBY_COUNTDOWN:
			{
				if(_passtrough)
					 break;
					 
				if(state != STATE_LOBBY && state != STATE_CHARSELECT)
					break;
					
				var count = buffer_read_s(rbuff, buffer_bool);
				var val = buffer_read_s(rbuff, buffer_u8);
										
				with(obj_lobby)
				{
					countScale = 1.5;
					isCounting = count;
					countdown = val;
				}
				
				audio_play_sound(snd_clock, 0, false);
				break;
			}
			
			case PacketType.SERVER_LOBBY_CHANGELOBBY:
			{
				var _lobby = buffer_read_s(rbuff, buffer_s32);
				with(obj_netclient)
				{
					isConnected = false;
					disnet_reset();
					
					net_join(ip, _lobby);
				}
				
				break;
			}
			
			case PacketType.SERVER_LOBBY_EXE_CHANCE:
			{
				if(_passtrough)
					 break;
					 
				chance = buffer_read_s(rbuff, buffer_u8);
				break;
			}
			
			case PacketType.SERVER_GAME_BACK_TO_LOBBY:
			{				
				if(_passtrough)
					 break;
					 
				audio_stop_all();
				global.ringId = 0;
				global.player = noone;
				global.character = -1;
				global.exeCharacter = -1;
				global.playerControls = true;
				ds_map_destroy(players);
				players = ds_map_create();
				exeId = -1;
				
				avCharacters = 
				[ 
					false, //0 (exe) (cannot)
					true,  //1 (t)
					true,
					true,
					true,
					true,
					true
				];
				
				gameEnds = false;
				state = STATE_LOBBY;
				room_goto(room_lobby);
				
				var buffer = cpacket_tcp(PacketType.CLIENT_LOBBY_PLAYERS_REQUEST, false);
				send_server_tcp(buffer);
				return true;
			}
			
			default:
				if(state == STATE_LOBBY)
					return net_state_lobby(rbuff, nps, _passtrough);
				else if(state == STATE_VOTE)
					return net_state_vote(rbuff, nps, _passtrough);
				else if(state == STATE_CHARSELECT)
					return net_state_charselect(rbuff, nps, _passtrough);
				else if(state == STATE_GAME)
					return net_state_game(rbuff, nps, _passtrough);
				else if(state == STATE_PENDING)
					return net_state_pending(rbuff, nps, _passtrough);
				else if(state == STATE_RESULTS)
					return net_state_results(rbuff, nps, _passtrough);
				
				break;
		}
	}
	
	return false;
}