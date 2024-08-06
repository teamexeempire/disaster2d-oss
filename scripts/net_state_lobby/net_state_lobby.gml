function lobby_player_joined(plr, ng=true)
{		
	var found = false;
	
	with(obj_lobby_icon)
	{
		if(master_id == plr.nid)
		{
			found = true;
			break;
		}
	}
	
	if(found)
		return;
	
	var inst = instance_create_depth(32+12, 128 + 12, 0, obj_lobby_icon);
	inst.master_id = plr.nid;
	inst.nickname = plr.nickname;
	inst.isReady = plr.isReady;
	inst.aY = 58;
	
	playerCnt++;
	
	if(ng)
		audio_play_sound(snd_ring, 0, false);
}

function lobby_player_left(nid) 
{
	playerCnt--;
	
	with(obj_lobby_icon)
	{
		if(master_id != nid)
			continue;
			
		instance_create_depth(x, y, -999, obj_lobby_blood); 
		instance_destroy();
		audio_play_sound(snd_hurt, 0, false);
	}
}

function lobby_add_message(sender, msg)
{
	if(global.muteChat)
		return;
	
	audio_stop_sound(snd_message);
	audio_play_sound(snd_message, 0, false);
	array_push(chat, "" + sender + ": " + scr_chat_filter(msg) + "~");
	
	if(array_length(chat) >= 9)
		array_delete(chat, 0, 1);
}

function net_state_lobby(rbuff, nps, isPasstrough)
{
	switch(nps)
	{
		case PacketType.SERVER_LOBBY_EXE:
		{	
			if(isPasstrough)
				break;
				
			layer_set_visible(layer_get_id("Mercoin1"), false);
			layer_set_visible(layer_get_id("Mercoin2"), false);
				
			var whoExe = buffer_read_s(rbuff, buffer_u16);
			var map = buffer_read_s(rbuff, buffer_u16);
			lvlId = map;
			
			instance_create_depth(0, 0, -100, obj_lobby_white);
			obj_lobby_waiting.visible = false;
			
			with(obj_lobby)
			{
				state = 2;
				nextMap = map;
			}
			
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
		
		case PacketType.SERVER_PLAYER_JOINED:
		{				
			if(isPasstrough)
				break;
				
			var _id = buffer_read_s(rbuff, buffer_u16);
			var _name = buffer_read_s(rbuff, buffer_string);
			var _icon = buffer_read_s(rbuff, buffer_u8);
			var _pet = buffer_read_s(rbuff, buffer_s8);
						
			players[? _id] = 
			{
				character: -1,
				exeCharacter: -1,
				pet: -1,
				
				isReady: false,
				isAlive: true,
				hasEscaped: false,
				icon: 0
			};
			
			players[? _id].pending = false;
			players[? _id].nid = _id
			players[? _id].nickname = _name;
			players[? _id].icon = _icon;
			players[? _id].pet = _pet;
			
			with(obj_lobby)
				lobby_player_joined(obj_netclient.players[? _id]);
			
			break;
		}
		
		case PacketType.SERVER_LOBBY_READY_STATE:
		{				
			if(isPasstrough)
				break;
				
			var pid = buffer_read_s(rbuff, buffer_u16);
			var st = buffer_read_s(rbuff, buffer_bool);
			
			if(!ds_map_exists(players, pid))
				break;
				
			players[? pid].isReady = st;
			audio_play_sound(snd_ready, 0, false);			
			break;
		}
		
		case PacketType.SERVER_LOBBY_CORRECT:
		{
			with(obj_lobby)
			{
				lobby_player_joined({ nid: obj_netclient.nid, nickname: global.nickname, isReady: false });
				canUse = true;
			}
			break;
		}
				
		case PacketType.SERVER_LOBBY_PLAYER:
		{				
			if(isPasstrough)
				break;
							
			var _nid = buffer_read_s(rbuff, buffer_u16);
			var _ready = buffer_read_s(rbuff, buffer_bool);
			var _nick = buffer_read_s(rbuff, buffer_string);
			var _icon = buffer_read_s(rbuff, buffer_u8);
			var _pet = buffer_read_s(rbuff, buffer_s8);
					
			players[? _nid] = 
			{
				pending: false,
				nid: _nid,
				nickname: _nick,
				character: -1,
				exeCharacter: -1,
				
				isReady: _ready,
				isAlive: true,
				hasEscaped: false,
				icon: _icon,
				pet: _pet
			};
			
			if(instance_exists(obj_lobby))
				with(obj_lobby)
					lobby_player_joined(obj_netclient.players[? _nid], false);
				
			break;
		}
		
		case PacketType.CLIENT_CHAT_MESSAGE:
		{				
			if(isPasstrough)
				break;
				
			var _id = buffer_read_s(rbuff, buffer_u16);
			var _msg = buffer_read_s(rbuff, buffer_string);
			
			if(_id == 0)
			{
				with(obj_lobby)
					lobby_add_message("(server)", _msg);
				break;
			}
			
			if(!ds_map_exists(players, _id))
				break;
			
			var _plr = players[? _id];
			with(obj_lobby)
				lobby_add_message(_plr.nickname, _msg);
				
			break;
		}
		
		case PacketType.SERVER_VOTE_MAPS:
		{
			if(isPasstrough)
				break;
				
			var _map1 = buffer_read_s(rbuff, buffer_u8);
			var _map2 = buffer_read_s(rbuff, buffer_u8);
			var _map3 = buffer_read_s(rbuff, buffer_u8);
			
			layer_set_visible(layer_get_id("Mercoin1"), false);
			layer_set_visible(layer_get_id("Mercoin2"), false);
			
			with(obj_lobby)
			{
				state = 1;
				map1 = _map1;
				map2 = _map2;
				map3 = _map3;
			}
			
			with(obj_lobby_prolet)
			{
				for(var i = 0; i < array_length(mapData[_map1].tiles); i++)
					sprite_prefetch(mapData[_map1].tiles[i]);
					
				sprite_prefetch(mapData[_map1].bg);
				
				for(var i = 0; i < array_length(mapData[_map2].tiles); i++)
					sprite_prefetch(mapData[_map2].tiles[i]);
					
				sprite_prefetch(mapData[_map2].bg);
				
				for(var i = 0; i < array_length(mapData[_map3].tiles); i++)
					sprite_prefetch(mapData[_map3].tiles[i]);
					
				sprite_prefetch(mapData[_map3].bg);
			}
			
			with(obj_lobby_icon)
				hidden = true;
			
			layer_set_visible(layer_get_id("Background"), false);
			state = STATE_VOTE;
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEVOTEKICK:
		{
			instance_create_depth(0, 0, 0, obj_lobby_votekick);
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEKICK:
		{
			var inst = instance_create_depth(0, 0, 0, obj_lobby_votekick);
			inst.str = "kick";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEKICK;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEBAN:
		{
			var inst = instance_create_depth(0, 0, 0, obj_lobby_votekick);
			inst.str = "ban";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEBAN;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
		
		case PacketType.SERVER_LOBBY_CHOOSEOP:
		{
			var inst = instance_create_depth(0, 0, 0, obj_lobby_votekick);
			inst.str = "op";
			inst.packet = PacketType.CLIENT_LOBBY_CHOOSEOP;
			chatMsg = "";
			keyboard_string = "";
			break;
		}
	}
	
	return false;
}