function net_state_vote(rbuff, nps, isPasstrough)
{
	switch(nps)
	{		
		case PacketType.SERVER_LOBBY_EXE:
		{
			if(isPasstrough)
				break;
				
			var whoExe = buffer_read_s(rbuff, buffer_u16);
			var map = buffer_read_s(rbuff, buffer_u16);
			lvlId = map;
			
			layer_set_visible(layer_get_id("Mercoin1"), false);
			layer_set_visible(layer_get_id("Mercoin2"), false);
			
			instance_create_depth(0, 0, -100, obj_lobby_white);
			obj_lobby_waiting.visible = false;
			
			with(obj_lobby)
			{
				state = 2;
				nextMap = map;
			}
			
			global.character = -1;
			global.exeCharacter = -1;
			
			if(nid == whoExe)
			{
				global.character = CHARACTER_EXE;
				global.player = obj_exe;
			}
			else if(ds_map_exists(players, whoExe))
			{
				players[? whoExe].character = CHARACTER_EXE;
			}
			
			exeId = whoExe;
			state = STATE_CHARSELECT;
			scr_play_music(mus_lobby_epic);
			
			with(obj_lobby_prolet)
			{
				image_blend = c_white;
				setZone(map);
			}
			
			with(obj_lobby_icon)
			{
				hidden = false;
				
				if(master_id == obj_netclient.nid)
					sprite_index = spr_lobby_icon;

				if(master_id == obj_netclient.exeId && master_id != obj_netclient.nid)
				{
					sprite_index = spr_lobby_exeicon5;
					
					if(obj_netclient.nid == master_id)
						image_index = obj_unlockables.lobbyIcon;
					else if(ds_map_exists(obj_netclient.players, master_id))
						image_index = obj_netclient.players[? master_id].icon;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_VOTE_TIME_SYNC:
		{
			if(isPasstrough)
				break;
				
			with(obj_lobby)
			{
				countScale = 1;
				voteTimer = buffer_read_s(rbuff, buffer_u8);
				
				if(voteTimer <= 3)
				{
					countScale = 1.5;
					audio_play_sound(snd_clock, 0, false);
				}
			}
			break;
		}
		
		case PacketType.SERVER_VOTE_SET:
		{
			if(isPasstrough)
				break;
				
			with(obj_lobby)
			{
				map1Votes = buffer_read_s(rbuff, buffer_u8);
				map2Votes = buffer_read_s(rbuff, buffer_u8);
				map3Votes = buffer_read_s(rbuff, buffer_u8);
			}
			break;
		}
	}
	
	return false;
}