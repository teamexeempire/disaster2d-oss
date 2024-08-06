function net_send_palette()
{
	var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_PALETTE, true);
	buffer_write(pak, buffer_bool, true);
	buffer_write(pak, buffer_u16, obj_netclient.nid);
	buffer_write(pak, buffer_string, global.palleteName);
	buffer_write(pak, buffer_u8, array_length(global.palleteFrom));
	
	for(var i = 0; i < array_length(global.palleteFrom); i++)
		buffer_write(pak, buffer_u8, global.palleteFrom[i] * 255);
	
	send_server_tcp(pak);
	
	pak = cpacket_tcp(PacketType.CLIENT_PLAYER_PALETTE, true);
	buffer_write(pak, buffer_bool, false);
	buffer_write(pak, buffer_u16, obj_netclient.nid);
	buffer_write(pak, buffer_string, global.palleteName);
	buffer_write(pak, buffer_u8, array_length(global.palleteTo));
	
	for(var i = 0; i < array_length(global.palleteTo); i++)
		buffer_write(pak, buffer_u8, global.palleteTo[i] * 255);
		
	send_server_tcp(pak);
	
	if(obj_unlockables.pet != -1)
	{
		pak = cpacket_tcp(PacketType.CLIENT_PET_PALETTE, true);
		buffer_write(pak, buffer_bool, true);
		buffer_write(pak, buffer_u16, obj_netclient.nid);
		buffer_write(pak, buffer_u8, array_length(global.petPallettes[obj_unlockables.pet]));
		
		for(var i = 0; i < array_length(global.petPallettes[obj_unlockables.pet]); i++)
			buffer_write(pak, buffer_u8, global.petPallettes[obj_unlockables.pet][i] * 255);
		
		send_server_tcp(pak);
		
		var arr = obj_unlockables.pet >= 7 ? [ 0, 0, 0, 0 ] : obj_unlockables.petPallettes[? obj_unlockables.pet].to;
		pak = cpacket_tcp(PacketType.CLIENT_PET_PALETTE, true);
		buffer_write(pak, buffer_bool, false);
		buffer_write(pak, buffer_u16, obj_netclient.nid);
		buffer_write(pak, buffer_u8, array_length(arr));
		
		for(var i = 0; i < array_length(arr); i++)
			buffer_write(pak, buffer_u8, arr[i] * 255);
		
		send_server_tcp(pak);
	}
}

function net_state_game(rbuff, nps, isPasstrough)
{
	switch(nps)
	{
		case PacketType.SERVER_FELLA:
		{
			var pid = buffer_read_s(rbuff, buffer_u16);
			var _x = buffer_read_s(rbuff, buffer_f32);
			var _y = buffer_read_s(rbuff, buffer_f32);
			
			if(obj_netclient.nid == pid)
			{
				instance_create_depth(_x, _y, 0, obj_player_POVODOK);
				break;
			}
			
			if(instance_exists(obj_player_puppet))
			{
				with(obj_player_puppet)
				{
					if(pid != master_id)
						continue;
					
					is_cheating = 1;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_PLAYER_ESCAPED:
		{
			if(!instance_exists(global.player))
				break;
				
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = false;
		
			obj_camera.spectatingObj = noone;
			if(global.cameraMode != 2 && global.cameraMode != 3)
				global.cameraMode = 3;
	
			if(room != room_fartzone && !obj_achivements.achivements[10] && global.player.hp <= 20 && global.timeMinutes == 0 && global.timeSeconds <= 5)
			{
				obj_achivements.mercoins += 100;
				obj_achivements.save();
		
				obj_achivements.achivements[10] = true;
				obj_achivements.save();
				obj_achivements.show();
			}
			
			with(global.player)
				instance_destroy();
				
			if(instance_exists(obj_redring_screen))
			{
				audio_stop_sound(mus_mindfuck);
				instance_destroy(obj_redring_screen);
			}
			break;
		}
		
		case PacketType.SERVER_PLAYER_BACKTRACK:
		{
			if(isPasstrough)
				break;
				
			var _x = buffer_read_s(rbuff, buffer_f32);
			var _y = buffer_read_s(rbuff, buffer_f32);
			
			if(!instance_exists(global.player))
				break;
				
			global.player.x = _x;
			global.player.y = _y;
			break;
		}
		
		case PacketType.CLIENT_MERCOIN_BONUS:
		{
			var _tid = buffer_read_s(rbuff, buffer_u16);
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_tid != obj_netclient.nid)
				break;
				
			switch(_type)
			{
				case 0: //exe kill
					obj_achivements.mercoins += 2;
					obj_achivements.exeKills++;
					
					if(obj_achivements.exeKills >= 3 && room != room_fartzone && !obj_achivements.achivements[12])
					{
						obj_achivements.achivements[12] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 25;
					}
					
					if(obj_achivements.exeKills >= 10 && room != room_fartzone && !obj_achivements.achivements[13])
					{
						obj_achivements.achivements[13] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 50;
					}
					
					if(obj_achivements.exeKills >= 50 && room != room_fartzone && !obj_achivements.achivements[14])
					{
						obj_achivements.achivements[14] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 250;
					}
					
					if(obj_achivements.exeKills >= 100 && room != room_fartzone && !obj_achivements.achivements[15])
					{
						obj_achivements.achivements[15] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 500;
					}
					
					if(obj_achivements.rUsedClone && room != room_fartzone && !obj_achivements.achivements[37])
					{
						obj_achivements.achivements[37] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 100;
					}
					
					if(obj_achivements.rExeInvis && room != room_fartzone && !obj_achivements.achivements[34])
					{
						obj_achivements.achivements[34] = true;
						obj_achivements.show();
						obj_achivements.mercoins += 100;
					}
					
					obj_achivements.save();
					break;
					
				case 1: //exe stun
					
					if(++obj_achivements.stunnedExe >= 5 && room != room_fartzone && !obj_achivements.achivements[9])
					{
						obj_achivements.achivements[9] = true;
						obj_achivements.show();
						obj_achivements.save();
						
						obj_achivements.mercoins += 100;
					}
										
					obj_achivements.mercoins += 1;
					obj_achivements.save();
					break;
					
				case 2: //tails hit
					var _charge = buffer_read_s(rbuff, buffer_u8);
					
					if(_charge >= 6 && _charge <= 10 && room != room_fartzone && !obj_achivements.achivements[22])
					{
						obj_achivements.achivements[22] = true;
						obj_achivements.mercoins += 75;
						
						obj_achivements.save();
						obj_achivements.show();
					}
					
					if(_charge >= 60 && room != room_fartzone && !obj_achivements.achivements[23])
					{
						obj_achivements.achivements[23] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
					}
					
					if(_charge <= 10 && ++obj_achivements.stunnedExe >= 5 && room != room_fartzone && !obj_achivements.achivements[9])
					{
						obj_achivements.achivements[9] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
					}

					audio_play_sound(snd_tails_hit, 0, false);
					obj_achivements.mercoins++;
					obj_achivements.save();
					break;
					
				case 3: //amy.exe hit
					if(++obj_achivements.rExeAmyHits >= 5 && room != room_fartzone && !obj_achivements.achivements[29])
					{
						obj_achivements.achivements[29] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
					
				case 4: //demon kill
					obj_achivements.rDemonKills++;
					if(obj_achivements.demonLast && room != room_fartzone && !obj_achivements.achivements[8])
					{
						obj_achivements.achivements[8] = true;
						obj_achivements.mercoins += 125;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					
					if(room != room_fartzone && !obj_achivements.achivements[31] && obj_achivements.rDemonKills >= 2 && global.character == CHARACTER_CREAM)
					{
						obj_achivements.achivements[31] = true;
						obj_achivements.mercoins += 75;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					
					if(room != room_fartzone && !obj_achivements.achivements[7])
					{
						obj_achivements.achivements[7] = true;
						obj_achivements.mercoins += 25;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
					
				case 5:
				{
					if(++obj_achivements.rSallyShield >= 2 && room != room_fartzone && !obj_achivements.achivements[33])
					{
						obj_achivements.achivements[33] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
				}
				
				case 7:
				{
					if(++obj_achivements.rShockwave >= 2 && room != room_fartzone && !obj_achivements.achivements[36])
					{
						obj_achivements.achivements[36] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
				}
				
				case 8:
				{
					obj_achivements.alarm[7] = 60;
					if(++obj_achivements.rUpper >= 2 && room != room_fartzone && !obj_achivements.achivements[25])
					{
						obj_achivements.achivements[25] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
				}
				
				case 9:
				{
					obj_achivements.alarm[7] = 60;
					if(++obj_achivements.rUpper >= 2 && room != room_fartzone && !obj_achivements.achivements[24])
					{
						obj_achivements.achivements[24] = true;
						obj_achivements.mercoins += 75;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
				}
				
				case 10:
				{
					if(++obj_achivements.rChaosDash >= 2 && room != room_fartzone && !obj_achivements.achivements[35])
					{
						obj_achivements.achivements[35] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.save();
						obj_achivements.show();
						obj_achivements.save();
					}
					break;
				}
				
				case 11:
				{
					obj_achivements.rAmyStuns++;
					break;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_HDDOOR_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_type == 0)
			{
				var _state = buffer_read_s(rbuff, buffer_bool);
				
				if(!instance_exists(obj_hd_door))
					break;
					
				if(!instance_exists(obj_hd_door2))
					break;
					
				if(!instance_exists(obj_hd_crystal))
					break;
				
				with(obj_hd_crystal)
					state = _state;
					
				with(obj_hd_door)
				{
					state = _state;
					audio_play_sound_on(emitter, snd_door, false, 0);
				}
				
				with(obj_hd_door2)
				{
					state = _state;
					audio_play_sound_on(emitter, snd_door, false, 0);
				}
			}
			else
			{
				var _state = buffer_read_s(rbuff, buffer_bool);
					
				if(!instance_exists(obj_hd_crystal))
					break;
				
				with(obj_hd_crystal)
				{
					if(canUse)
						audio_play_sound_on(emitter, snd_message, false, 0);
						
					canUse = _state;
				}
			}
			break;
		}
		
		case PacketType.SERVER_WDLATERN_ACTIVATE:
		{
			var _state = buffer_read_s(rbuff, buffer_bool);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_weed))
				break;
				
			if(!instance_exists(obj_weed_lantern))
				break;
				
			with(obj_weed_lantern)
			{
				if(nid == _nid)
				{
					active = _state;
					
					if(active)
					{
						audio_play_sound(snd_wdlamp, false, 0);
						
						if(global.character == CHARACTER_EXE)
							break;
				
						if(!instance_exists(global.player))
							break;
				
						if(global.player.revivalTimes >= 2 || global.player.isDead)
							break;
							
						var _inst = instance_create_depth(global.player.x, global.player.y, 0, obj_surv_lampindicator);
						_inst.targetX = targetX;
						_inst.targetY = targetY;
					}
				}
				else
					active = false;
			}
			break;
		}
		
		case PacketType.SERVER_DTASS_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_type == 0)
			{
				var _id = buffer_read_s(rbuff, buffer_u8);
				var _x = buffer_read_s(rbuff, buffer_u16);
				var _y = buffer_read_s(rbuff, buffer_u16);
				
				var _inst = instance_create_depth(_x, _y, 0, obj_darktower_sisi);
				_inst.nid = _id;
				_inst.visible = true;
			}
			else if(_type == 1)
			{
				var _id = buffer_read_s(rbuff, buffer_u8);
				
				if(!instance_exists(obj_darktower_sisi))
					break;
					
				with(obj_darktower_sisi)
				{
					if(nid != _id)
						continue;
						
					_destroy();
					break;
				}
			}
			else
			{
				var _id = buffer_read_s(rbuff, buffer_u8);
				
				if(!instance_exists(obj_darktower_sisi))
					break;
					
				with(obj_darktower_sisi)
				{
					if(nid != _id)
						continue;
						
					audio_play_sound_on(emitter, snd_sisi_notice, false, 0);
					break;
				}
			}
			break;
		}
		
		case PacketType.SERVER_DTTAILSDOLL_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_type == 0)
			{
				var _x = buffer_read_s(rbuff, buffer_u16);
				var _y = buffer_read_s(rbuff, buffer_u16);
				var _tar = buffer_read_s(rbuff, buffer_u8);
				
				if(!instance_exists(obj_darktower_tailsdoll))
					instance_create_depth(_x, _y, 0, obj_darktower_tailsdoll);
					
				obj_darktower_tailsdoll.x = _x;
				obj_darktower_tailsdoll.y = _y;
				obj_darktower_tailsdoll.image_index = _tar;
			}
			else if(_type == 1 && instance_exists(global.player))
			{
				if(global.player.hp <= 0)
					break;
					
				audio_play_sound(snd_tailsball_jumpscare, false, 0);
				net_sound_emit(snd_tailsball_jumpscare2);
				
				obj_darktower_jumpscare.visible = true;
				obj_darktower_jumpscare.alarm[0] = 60;
				scr_player_slow(3);
			}
			else if(_type == 2)
			{
				if(!instance_exists(obj_darktower_tailsdoll))
					break;
					
				audio_play_sound(snd_tailsball, false, 0);
			}
			else if(_type == 3)
			{
				audio_play_sound(snd_tailsball_chase, 0, false);
			}
			
			break;
		}
		
		case PacketType.CLIENT_PLAYER_POTATER:
		{
			var _type = buffer_read_s(rbuff, buffer_u8);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			
			if(_type == 0) //Activate & Timer
			{
				var timer = buffer_read_s(rbuff, buffer_u8);
				
				if(!instance_exists(obj_player_puppet))
					return;
					
				with(obj_player_puppet)
				{
					if(_pid != master_id)
						continue;
						
					potater = true;
					potatoTimer = timer;
					break;
				}
				
				if(timer >= 4)
				{				
					if(obj_netclient.nid == _pid)
					{
						obj_fart_controller.potater = true;
						obj_fart_controller.potatoTimer = 60 * 4;
						break;
					}
				}
				
			}
			else //Deactivate
			{
				if(!instance_exists(obj_player_puppet))
					return;
					
				with(obj_player_puppet)
				{
					if(_pid != master_id)
						continue;
						
					potater = false;
					potatoTimer = 0;
					break;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_EXELLERCLONE_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_type == 0)
			{
				var _id = buffer_read_s(rbuff, buffer_u16);
				var _pid = buffer_read_s(rbuff, buffer_u16);
				var _x = buffer_read_s(rbuff, buffer_u16);
				var _y = buffer_read_s(rbuff, buffer_u16);
				var _dir = buffer_read_s(rbuff, buffer_s8);
				
				var _inst = instance_create_depth(_x, _y, 0, obj_exeller_clone);
				_inst.nid = _id;
				_inst.pindex = 0;
				_inst.image_xscale = _dir;
				
				if(ds_map_exists(obj_netclient.players, _pid))
					_inst.pname = obj_netclient.players[? _pid].nickname;
				
				if(global.character == CHARACTER_EXE)
				{
					if(global.player.clones[0] != -1)
						_inst.pindex = 1;
					
					global.player.clones[_inst.pindex] = _id;
					global.player.cloneCount++;
					
					net_sound_emit(snd_exeller_clone);
					audio_play_sound(snd_exeller_clone, 0, false);
				}
				
				net_quick_effect(_inst.x, _inst.y + 32, spr_ring_teleport, false, 1, 0, 0, 2);
			}
			else
			{
				var _id = buffer_read_s(rbuff, buffer_u16);
				
				if(!instance_exists(obj_exeller_clone))
					return;
			
				with(obj_exeller_clone)
				{
					if(nid != _id)
						continue;
					
					if(global.character == CHARACTER_EXE)
					{
						global.player.x = x;
						global.player.y = y;
						global.player.clones[pindex] = -1;
						global.player.cloneTimer = EXELLER_CLONE_RECHARGE;
						global.player.cloneCount--;
						
						obj_achivements.alarm[3] = 60;
						obj_achivements.rUsedClone = true;
						
						obj_exetior_indicator.showTimer = 7 * 60;	
						
						net_sound_emit(snd_exe_appear);
						audio_play_sound(snd_exe_appear, 0, false);
						net_quick_effect(x, y + 32, spr_ring_teleport, false, 1, 0, 0, 2);
					}
					
					instance_destroy();
					break;
				}
			}
			
			break;
		}
		
		case PacketType.CLIENT_ERECTOR_BALLS:
		{
			var xx = buffer_read_s(rbuff, buffer_f32);
			var yy = buffer_read_s(rbuff, buffer_f32);
			
			var inst = instance_create_depth(xx-25, yy+19, -1, obj_exetior_stompballs);
			inst.dir = -1;
			
			var inst = instance_create_depth(xx+25, yy+19, -1, obj_exetior_stompballs);
			inst.dir = 1;
			
			if(global.character == CHARACTER_EXE)
				obj_achivements.alarm[4] = 60;
				
			break;
		}
		
		case PacketType.SERVER_ERECTOR_BRING_SPAWN:
		{
			if(isPasstrough)
				break;
				
			var _gid = buffer_read_s(rbuff, buffer_u16);
			var _xx = buffer_read_s(rbuff, buffer_u16);
			var _yy = buffer_read_s(rbuff, buffer_u16);
			
			var _inst = instance_create_depth(_xx, _yy, 0, obj_blackring);
			_inst.nid = _gid;
			
			with(_inst)
			{
				tar = noone;
				if(global.character != CHARACTER_EXE)
				{
					if(!instance_exists(obj_player_puppet))
						return;
					
					var _tg = noone;
					with(obj_player_puppet)
					{
						if(character != CHARACTER_EXE)
							continue;
							
						_tg = self;
					}
					
					tar = _tg;
				}
				else
				{
					if(global.palleteName == "menace")
						sprite_index = spr_blackring_purple;
				}
				
				if(tar != noone)
				{
					if(tar.palleteName == "menace")
						sprite_index = spr_blackring_purple;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_TCGOM_STATE:
		{
			if(isPasstrough)
				break;
				
			var _gid = buffer_read_s(rbuff, buffer_u8);
			var _pus = buffer_read_s(rbuff, buffer_bool);
				
			if(_pus)
			{
				with(obj_soundemitter)
				{
					if(stype == _gid)
						scr_audio_play_3d(emitter, snd_acid, false, 0);
				}
			}
			
			if(!instance_exists(obj_abadon_cloud))
				break;
				
			with(obj_abadon_cloud)
			{
				if(nid != _gid)
					continue;
					
				if(_pus)
				{
					image_index = 0;
					visible = true;
				}
				
				damage = _pus;
			}
				
			break;
		}
		
		case PacketType.CLIENT_RMZSHARD_LAND:
		{
			if(isPasstrough)
				break;
				
			var _gid = buffer_read_s(rbuff, buffer_u16);
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			if(!instance_exists(obj_ravintmist_shard))
				break;
			
			with(obj_ravintmist_shard)
			{
				if(gid != _gid)
					continue;
				
				x = _x;
				y = _y;
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_RMZSHARD_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			switch(_type)
			{
				case 0:
				{
					var _id = buffer_read_s(rbuff, buffer_u16);
					var _x = buffer_read_s(rbuff, buffer_u16);
					var _y = buffer_read_s(rbuff, buffer_u16);
					
					var _inst = instance_create_depth(_x, _y, 0, obj_ravintmist_shard);
					_inst.x = _x;
					_inst.y = _y;
					_inst.gid = _id;
					_inst.grv = false;
					_inst.ground = true;
					
					break;
				}
					
				case 1:
				{
					var _id = buffer_read_s(rbuff, buffer_u16);
					var _x = buffer_read_s(rbuff, buffer_u16);
					var _y = buffer_read_s(rbuff, buffer_u16);
					
					var _inst = instance_create_depth(_x, _y, 0, obj_ravintmist_shard);
					_inst.x = _x;
					_inst.y = _y;
					_inst.gid = _id;
					_inst.grv = true;
					_inst.ground = false;
					break;
				}
					
				case 2:
				{
					var _id = buffer_read_s(rbuff, buffer_u16);
					var _pid = buffer_read_s(rbuff, buffer_u16);
					
					if(!instance_exists(obj_ravintmist_shard))
						break;
					
					with(obj_ravintmist_shard)
					{
						if(gid != _id)
							continue;
							
						net_quick_effect(x, y, spr_shard_sparkle);
						instance_destroy();
						break;
					}
						
					if(_pid == obj_netclient.nid)
					{
						if(!instance_exists(global.player))
							break;
							
						global.player.shards++;
						
						if(global.timeMinutes < 1)
							obj_achivements.rShardsCollected++;
						
						break;
					}
					
					if(!instance_exists(obj_player_puppet))
						break;
						
						
					with(obj_player_puppet)
					{
						if(master_id != _pid)
							continue;
							
						shards++;
						break;
					}
					
					break;
				}
				
				case 3:
				{
					if(!instance_exists(obj_ravinemist_controller))
						break;
						
					var _cnt = buffer_read_s(rbuff, buffer_u8);
					obj_ravinemist_controller.prevShardCount = obj_ravinemist_controller.shardCount;
					obj_ravinemist_controller.shardCount = _cnt;
					
					if(obj_ravinemist_controller.shardCount > obj_ravinemist_controller.prevShardCount)
					{
						audio_play_sound(snd_shard, 0, false);
					}
					break;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_GHZTHUNDER_STATE:
		{
			if(isPasstrough)
				break;
				
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			if(_type == 0)
			{
				instance_create_depth(0, 0, 0, obj_flash);
				audio_play_sound(snd_thunder, 0, false);
				
				obj_ghz_water.electro = true;
			}
			else if(_type == 1)
			{
				obj_ghz_water.electro = false;
			}
			
			break;
		}
		
		case PacketType.SERVER_VVVASE_STATE:
		{
			if(isPasstrough)
				break;
				
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _type = buffer_read_s(rbuff, buffer_u8);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _canHeal = buffer_read_s(rbuff, buffer_bool);
			
			if(!instance_exists(obj_vv_vase))
				break;
				
			with(obj_vv_vase)
			{
				if(nid != _id)
					continue;
					
				for(var i = 0; i < irandom_range(6, 8); i++)
				{
					var _inst = instance_create_depth(x, y, depth, obj_vv_vasepiece);
					_inst.xspd = irandom_range(2, 4) * (irandom(2) >= 1 ? -1 : 1);
					_inst.yspd = irandom_range(-4, -2);
				}
				
				sndid = scr_audio_play_3d(emitter, snd_vasebreak, false, 0);
				visible = false;
				break;
			} 
			
			if(!instance_exists(global.player))
				break;
				
			if(global.player.isDead)
				break;
			
			if(obj_netclient.nid != _pid)
				break;
			
			switch(_type)
			{
				case 0:
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
					net_quick_effect(global.player.x, global.player.y, spr_ring_sparkle);
					global.player.rings++;
					break;
					
				case 1:
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
					net_quick_effect(global.player.x, global.player.y, spr_ring_sparkle);
					global.player.rings += 2;
					break;
					
				case 2:
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
					net_quick_effect(global.player.x, global.player.y, spr_ring_sparkle);
					global.player.rings += 3;
					break;
					
				case 3:
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
					net_quick_effect(global.player.x, global.player.y, spr_ring_sparkle);
					global.player.rings += 4;
					break;
			}			
				
			if(global.player.redRingTimer >= 60)
			{
				var cnt = ((global.timeMinutes <= 0 && global.timeSeconds <  60) ? 2 : 0.5) * 60;
				
				global.player.redRingTimer = max(global.player.redRingTimer - cnt, 60);
			}
			
			if(global.player.rings >= 10 && global.player.hp < 100 && _canHeal)
			{
				global.player.rings -= 10;
				global.player.hp += 20;
				audio_play_sound(snd_heal, 0, false);
				net_sound_emit(snd_heal);
				
				var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(pak, buffer_u8, 0);
				send_server_tcp(pak);
				
				obj_achivements.healthRestore++;
				if(obj_achivements.healthRestore >= 3 && room != room_fartzone && !obj_achivements.achivements[16])
				{
					obj_achivements.mercoins += 100;
					obj_achivements.save();
					
					obj_achivements.achivements[16] = true;
					obj_achivements.save();
					obj_achivements.show();
				}
			}
			break;
		}
		
		case PacketType.SERVER_MOVINGSPIKE_STATE:
		{				
			if(isPasstrough)
				break;
				
			var _frame = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_movingspike))
				break;
						
			if(!instance_exists(obj_soundemitter))
				break;
			
			with(obj_soundemitter)
			{
				if(stype != SOUNDEMT_MOVINGSPIKE)
					continue;
				
				if(_frame == 1 || _frame == 3)
					scr_audio_play_3d(emitter, snd_movingspike, false, 0);
			}
			
			with(obj_movingspike)	
				image_index = _frame;
			
			break;
		}
		
		case PacketType.SERVER_YCRSMOKE_READY:
		{				
			if(isPasstrough)
				break;
				
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_ycr_smokearea))
				break;
				
			with(obj_ycr_smokearea)
			{
				if(nid == _nid)
				{
					activated = true;
					break;
				}
			}
				
			break;
		}
		
		case PacketType.SERVER_YCRSMOKE_STATE:
		{			
			if(isPasstrough)
				break;
				
			var _activated = buffer_read_s(rbuff, buffer_bool);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_ycr_smokearea))
				break;
			
			if(_activated)
			{
				with(obj_ycr_smokearea)
				{
					if(nid == _nid)
					{
						scr_audio_play_3d(emitter, snd_smoke, false, 0);
						for(var i = 0; i < sprite_width; i += 228)
						{
							for(var j = 0; j < sprite_height; j += 178)
							{
								if(i >= sprite_width || j >= sprite_height)
									break;
									
								var inst = instance_create_depth(bbox_left+i,bbox_top+j, -300, obj_ycr_smoke);
								inst.area = self;
							}
						}
						
						break;
					}
				}
			}
			else
			{
				with(obj_ycr_smokearea)
					activated = false;
				
				if(!instance_exists(obj_ycr_smoke))
					break;
					
				with(obj_ycr_smoke)
					mDestroy = true;
			}
			
			break;
		}
		
		case PacketType.SERVER_LCCHAIN_STATE:
		{				
			if(isPasstrough)
				break;
				
			var _active = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_limpcity_echain1))
				break;
				
			with(obj_limpcity_echain1)
				active = _active == 1;
				
			if(!instance_exists(obj_soundemitter))
				break;
			
			with(obj_soundemitter)
			{
				if(stype != SOUNDEMT_LCCHAIN)
					continue;
				
				if(_active == 0)
					scr_audio_play_3d(emitter, snd_echain_prepare, false, 0);
				else if(_active == 1)
					scr_audio_play_3d(emitter, snd_echain, false, 0);
			}
			break;
		}
		
		case PacketType.SERVER_LCEYE_STATE:
		{
			if(isPasstrough)
				break;
				
			if(!instance_exists(obj_limpcity_eyeA))
				break;
			
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _used = buffer_read_s(rbuff, buffer_bool);
			var _useID = buffer_read_s(rbuff, buffer_u16);
			var _target = buffer_read_s(rbuff, buffer_u8);
			var _charge = buffer_read_s(rbuff, buffer_u8);
						
			with(obj_limpcity_eyeA)
			{
				if(nid != _id)
					continue;
					
				requested = false;
				used = _used;
				useID = _useID;
				charge = _charge;
				break;
			}
			
			with(obj_limpcity_eyeB)
			{
				if(nid != _target)
					continue;
				
				used = _used;
					
				if(_used && _useID == obj_netclient.nid)
				{
					if(global.cameraMode == 0)
						global.cameraMode = 4;
					
					if(!instance_exists(obj_camera))
						break;
					
					obj_camera.target = self;
				}
				
				if(used)
					sprite_index = spr_limpcity_eye;
				else
					sprite_index = spr_limpcity_eye_recharge;
				break;
			}
			
			if(!_used && _useID == obj_netclient.nid && global.cameraMode == 4)
				global.cameraMode = 0;
			
			break;
		}
		
		case PacketType.SERVER_NPCONTROLLER_STATE:
		{
			if(isPasstrough)
				break;
				
			var _warn = buffer_read_s(rbuff, buffer_bool);
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _prevState = buffer_read_s(rbuff, buffer_u8);
			
			if(_warn)
			{
				instance_create_depth(-999, -999, -99999, obj_np_white);
				audio_play_sound(snd_npteleport, false, 0);
				
				with(obj_tile)
				{
					if(depth == 90)
					{
						isVis = false;
						image_alpha = 0;
					}
				}
				
				if(!instance_exists(global.player))
					break;
					
				if(global.character == CHARACTER_KNUX && global.player.isStuck)
				{
					global.player.isStuck = false;
					global.player.isGliding = false;
					global.player.glideTimer = KNUX_GLIDE_RECHARGE;
				}
				
				if(_prevState == 1 || _prevState == 3)
				{
					global.player.x -= 2904;
					
					with(obj_exeller_clone)
						x -= 2904;
				}
				
				if(_prevState == 2 || _prevState == 3)
				{
					global.player.y -= 1368;
					
					with(obj_exeller_clone)
						y -= 1368;
				}
				 
				if(_state == 1 || _state == 3)
				{
					global.player.x += 2904;
					
					with(obj_exeller_clone)
						x += 2904;
				}
				
				if(_state == 2 || _state == 3)
				{
					global.player.y += 1368;
					
					with(obj_exeller_clone)
						y += 1368;
				}
				
				if(global.character == CHARACTER_CREAM)
				{
					ringsTimer = global.player.revivalTimes >= 2 ? ECREAM_RINGS_RECHARGE : CREAM_RINGS_RECHARGE;
					ringsSpawn = 0;
				}
				
				with(obj_leftvitalkivatel)
					active = true;
					
				with(obj_rightvitalkivatel)
					active = true;
					
				obj_np_controller.tid = _state;
			}
			else
			{
				with(obj_tile)
				{
					if(depth == 90)
					{
						isVis = true;
						image_alpha = 0;
					}
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_KAFMONITOR_STATE:
		{
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_kaf_speedboobster))
				break;
			
			var inst = instance_find(obj_kaf_speedboobster, _nid % (instance_number(obj_kaf_speedboobster)));
			inst.nid = _nid;
			
			if(_state == 1)
			{
				inst.image_index = 0;
				inst.isBroken = false;
			}
			else if(_state == 2)
			{
				inst.image_index = 1;
				inst.isBroken = true;
				
				scr_audio_play_3d(inst.emitter, snd_break, false, 0);
				
				if(!instance_exists(global.player))
					break;
					
				var _pid = buffer_read_s(rbuff, buffer_u16);
				
				if(obj_netclient.nid != _pid)
					break;
				
				if(global.player.isBoosting)
					break;
				
				global.player.isBoosting = true;
				global.player.isSpinning = false;
				global.player.isJumping = false;
			}
				
			net_quick_effect(inst.x+15, inst.y+15, spr_explosion);
			break;
		}
		
		case PacketType.SERVER_NAPBALL_STATE:
		{			
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(_state == 0)
			{
				var _dir = buffer_read_s(rbuff, buffer_s8);
				
				with(obj_nap_snowball_waypoint)
				{
					if(nid != _nid)
						continue;
					
					if(wid != 0)
						continue;
					
					var snb = instance_create_depth(x+32, y+64, 0, obj_nap_snowball);
					snb.nid = _nid;
					snb.image_xscale = _dir;
					break;
				}
			}
			else if(_state == 2)
			{
				with(obj_nap_snowball)
				{
					if(nid == _nid)
					{
						var dir = (nid == 4 || nid == 1) ? 1 : -1;
						
						var ran = irandom_range(0, 2)
						for(var i = ran; i < ran + 2; i++)
						{
							var part = instance_create_depth(x, y-48, 0, obj_nap_snowball_part);
							part.y += random_range(-1.5, 1.5) * 24;
							part.image_index = i;
							
							part.xspd = (7 + random_range(-2, 2)) * dir;
							part.yspd = (-4 + random_range(-2, 2));
						}
						
						for(var i = 0; i < irandom_range(3, 6); i++)
						{
							var part = instance_create_depth(x, y-48, 0, obj_nap_snowball_part);
							part.y += random_range(-1, 1) * 24;
							part.image_index = irandom_range(4, 9);
							
							part.xspd = (4 + random_range(-2, 2)) * dir;
							part.yspd = (-4 + random_range(-2, 2));
						}
						
						sndid = scr_audio_play_3d(emitter, snd_snowball_break, 0, false);
						doDestroy = true;
						visible = false;
					}
				}
			}
			break;
		}
		
		case PacketType.SERVER_NAPICE_STATE:
		{
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(_state == 0)
			{
				with(obj_nap_iceblock)
				{
					if(nid != _nid)
						continue;
						
					visible = false;
					sprite_index = spr_nap_iceblock3;
					
					scr_audio_play_3d(emitter, snd_ice_break, false, 0);
					
					for(var i = 0; i < 2; i++)
					{
						var inst = instance_create_depth(x + 20, y + i * 20, -20, obj_nap_iceblock_part);
						inst.xspd = 1 - i;
						inst.yspd = -3;
						inst.dir = -1;
					}
					
					for(var i = 0; i < 2; i++)
					{
						var inst = instance_create_depth(x + 20, y + i * 20, -20, obj_nap_iceblock_part);
						inst.xspd = 1 + i;
						inst.yspd = -3;
						inst.dir = 1;
					}
					
					break;
				}
			}
			else if(_state == 1)
			{
				with(obj_nap_iceblock)
				{
					if(nid != _nid)
						continue;
						
					scr_audio_play_3d(emitter, snd_ice_spawn, false, 0);
					sprite_index = spr_nap_iceblock2;
					image_index = 0;
					visible = true;
					break;
				}
			}
			
			break;
		}
		
		case PacketType.CLIENT_SPRING_USE:
		{				
			var _nid = buffer_read_s(rbuff, buffer_u16);
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			if(!instance_exists(global.player))
				break;
			
			if(room != room_hideandseek2)
				break;
			
			if(global.character != CHARACTER_EXE)
				break;
				
			with(obj_exe_sprindicator)
			{
				spring = true;
				sprX = _x;
				sprY = _y;
				
				alarm[0] = 60 * 2;
			}
			
			if(point_distance(obj_camera.x, obj_camera.y, _x, _y) >  600)
				audio_play_sound_at(snd_spring_reverb, _x, _y, 0, 250, 500, 1, false, 0);
				
			break;
		}
		
		case PacketType.SERVER_PFLIFT_STATE:
		{				
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _id = buffer_read_s(rbuff, buffer_u8);
				
			if(!instance_exists(obj_pf_lift))
				break;
				
			var inst = noone;
			with(obj_pf_lift)
			{
				if(nid != _id)
					continue;
				
				inst = self;
				break;
			}
			
			if(inst == noone)
				break;
			
			if(_state == 0)
			{
				var _pid = buffer_read_s(rbuff, buffer_u16);
				inst.activated = true;
				inst.pid = _pid;
				
				if(obj_netclient.nid == _pid)
				{
					if(!instance_exists(global.player))
						break;
					
					global.playerControls = false;
					global.player.x = inst.x;
					global.player.y = inst.y;
				}
			}
			else if(_state == 2)
			{
				var _pid = buffer_read_s(rbuff, buffer_u16);
				var _y = buffer_read_s(rbuff, buffer_u16);
				
				inst.activated = false;
				inst.shouldFade = true;
				inst.pid = 0;
				inst.y = _y;
				
				with(obj_pf_lift)
					scr_audio_play_3d(emitter, snd_lift, 0, false);
				
				if(obj_netclient.nid == _pid)
				{
					if(!instance_exists(global.player))
						break;
					
					if(!obj_netclient.gameEnds)
						global.playerControls = true;
					
					global.player.x = inst.x;
					global.player.y = inst.y;
					global.player.yspd = -3;
				}
			}
			else if(_state == 3)
			{
				var _sY = buffer_read_s(rbuff, buffer_u16);
				inst.activated = false;
				inst.shouldFade = false;
				inst.pid = 0;
				inst.y = _sY;
			}
			
			break;
		}
		
		case PacketType.SERVER_BRING_STATE:
		{			
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _id = buffer_read_s(rbuff, buffer_u16);
			
			if(_state == 0)
			{
				var _spawn = instance_find(obj_blackring_spawner, _id-1);
				
				if(!instance_exists(_spawn))
					break;
				
				var _inst = instance_create_depth(_spawn.x, _spawn.y, 0, obj_blackring);
				_inst.nid = _id;
			}
			else if(_state == 1)
			{
				if(!instance_exists(obj_blackring))
					break;
					
				with(obj_blackring)
				{
					if(nid != _id)
						continue;
						
					var _target = noone;
					var _pur = false;
			
					if(global.character != CHARACTER_EXE)
					{
						if(!instance_exists(obj_player_puppet))
							return;
				
						var _tg = noone;
						with(obj_player_puppet)
						{
							if(character != CHARACTER_EXE)
								continue;
						
							_tg = self;
						}
				
						_target = _tg;
					}
					else
					{
						if(global.palleteName == "menace")
							_pur = true;
					}
			
					if(_target != noone)
					{
						if(_target.palleteName == "menace")
							_pur = true;
					}
			
					scr_effect_quick(x, y, _pur ? spr_blackring_sparkle_purple : spr_blackring_sparkle);
					instance_destroy();
					break;
				}
			}
			
			break;
		}
		
		case PacketType.CLIENT_RING_BROKE:
		{
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			var _xspd = buffer_read_s(rbuff, buffer_f16);
			var _depth = (instance_exists(global.player) ? global.player.depth : obj_player_puppet.depth) - 1;
			
			for(var i = 0; i < 4; i++)
			{		
				switch(i)
				{
					case 0:
						var _part = instance_create_depth(_x+16-4, _y+4, _depth, obj_ringpart);
						_part.xspd = 1 + _xspd;
						_part.yspd = irandom_range(-4, -2);
						_part.sprite_index = spr_ringpart;
						break;
		
					case 1:
						var _part = instance_create_depth(_x, _y+16-4, _depth, obj_ringpart);
						_part.xspd = -1 + _xspd;
						_part.yspd = irandom_range(1, 2);
						_part.sprite_index = spr_ringpart2;
						break;
		
					case 2:
						var _part = instance_create_depth(_x+4, _y+4, _depth, obj_ringpart);
						_part.xspd = -1 + _xspd;
						_part.yspd = irandom_range(-4, -2);
						_part.sprite_index = spr_ringpart3;
						break;
		
					case 3:
						var _part = instance_create_depth(_x+16-4, _y+16-4, _depth, obj_ringpart);
						_part.xspd = 1 + _xspd;
						_part.yspd = irandom_range(1, 2);
						_part.sprite_index = spr_ringpart4;
						break;
				}
			}
			break;
		}
		
		case PacketType.SERVER_BRING_COLLECTED:
		{	
			if(isPasstrough)
				break;
				
			if(!instance_exists(global.player))
				return;
			
			obj_achivements.wasHurt = true;
			if(global.player.rings >= 5)
			{
				global.player.rings -= 5;
				
				audio_play_sound(snd_ringabsorb, 0, false);
				net_sound_emit(snd_ringabsorb);
				return;
			}
				
			if(global.player.rings < 10)
			{
				global.player.hp -= 20;
				
				var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(pak, buffer_u8, 3);
				buffer_write(pak, buffer_u8, 20);
				send_server_tcp(pak);
				
				if(global.player.hp <= 0)
				{
					global.player.hp = 0;
					scr_player_instakill();
				}
			}
			else
			{
				global.player.rings -= 10;
			}
			
			obj_level.bloodFade = 0.4;
			
			net_sound_emit(snd_blackring);
			audio_play_sound(snd_blackring, 0, false);
			break;
		}
	
		case PacketType.CLIENT_PLAYER_HURT:
		{				
			var pid = buffer_read_s(rbuff, buffer_u16);
			var xx = buffer_read_s(rbuff, buffer_u16);
			var yy = buffer_read_s(rbuff, buffer_u16);
			
			if(pid == obj_netclient.nid)
			{
				if(!instance_exists(global.player))
					break;
				
				scr_camera_shake(20, 2, 0.2);
			}
			
			break;
		}
		
		case PacketType.CLIENT_SOUND_EMIT:
		{				
			var pid = buffer_read_s(rbuff, buffer_u16);
			var sid = buffer_read_s(rbuff, buffer_u8);
			var shouldPlay = buffer_read_s(rbuff, buffer_bool);
			
			if(sid >= array_length(global.net_snds))
				break;
			
			if(shouldPlay && pid == obj_netclient.nid)
				audio_play_sound(global.net_snds[sid], false, 0);
			
			if(instance_exists(obj_player_puppet))
			{
				with(obj_player_puppet)
				{
					if(master_id != pid)
						continue;
						
					scr_audio_play_3d(emitter, global.net_snds[sid], false, 0);
					break;
				}
			}
			break;
		}
		
		case PacketType.SERVER_TPROJECTILE_STATE:
		{				
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			
			if(_state == 0) // Spawn
			{	
				// Dont spawn again
				if(instance_exists(obj_tails_projectile))
					break;
					
				var _xx = buffer_read_s(rbuff, buffer_u16);
				var _yy = buffer_read_s(rbuff, buffer_u16);
				var _owner = buffer_read_s(rbuff, buffer_u16);
				var _dir = buffer_read_s(rbuff, buffer_s8);
				var _dmg = buffer_read_s(rbuff, buffer_u8);
				var _exe = buffer_read_s(rbuff, buffer_bool);
				var _charge = buffer_read_s(rbuff, buffer_u8);
				
				var inst = instance_create_depth(_xx, _yy, 0, obj_tails_projectile);
				inst.image_index = _charge;
				inst.image_xscale = _dir;
				inst.charge = _charge;
				inst.dir = _dir;
				inst.dmg = _dmg;
				inst.isExe = _exe;
				inst.isOwner = _owner == obj_netclient.nid;
			}
			else if(_state == 2) //Destroy
			{
				if(!instance_exists(obj_tails_projectile))
					break;
					
				with(obj_tails_projectile)
					_destroy();
			}
			break;
		}
		
		case PacketType.SERVER_RING_STATE:
		{			
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			if(_state == 0)
			{
				var _id = buffer_read_s(rbuff, buffer_u8);
				var _uid = buffer_read_s(rbuff, buffer_u16);
				var _redRing = buffer_read_s(rbuff, buffer_bool);
				
				var _inst = instance_find(obj_ring_spawner, _id);
				
				if(_inst == noone)
					break;
				
				_inst.iid = _id;
				
				var inst = instance_create_depth(_inst.x, _inst.y, 0, _redRing ? obj_redring : obj_ring);
				inst.iid = _id;
				inst.nid = _uid;
			}
			else if(_state == 1)
			{
				var _id = buffer_read_s(rbuff, buffer_u8);
				var _uid = buffer_read_s(rbuff, buffer_u16);
				
				with(obj_ring)
				{
					if(nid != _uid)
						continue;
					
					if(global.character != CHARACTER_EXE)
						scr_effect_quick(x, y, spr_ring_sparkle).depth = depth;
	
					instance_destroy();
					break;
				}
			}
			else if(_state == 2)
			{
				var _x = buffer_read_s(rbuff, buffer_s16);
				var _y = buffer_read_s(rbuff, buffer_s16);
				var _id = buffer_read_s(rbuff, buffer_u8);
				var _uid = buffer_read_s(rbuff, buffer_u16);
				var _redRing = buffer_read_s(rbuff, buffer_bool);
				
				var inst = instance_create_depth(_x, _y, 0, _redRing ? obj_redring : obj_ring);
				inst.nid = _uid;
				inst.iid = _id;
			}
			break;
		}
		
		case PacketType.SERVER_RING_COLLECTED:
		{				
			if(isPasstrough)
				break;
				
			if(!instance_exists(global.player))
				break;
				
			if(global.character == CHARACTER_EXE)
				break;
				
			if(global.player.revivalTimes >= 2)
				break;
				
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _eid = buffer_read_s(rbuff, buffer_u16);
			var _redRing = buffer_read_s(rbuff, buffer_bool);
			var _canHeal = buffer_read_s(rbuff, buffer_bool);
			
			if(_redRing)
			{
				if(global.player.redRingTimer > 0)
					break;
					
				audio_play_sound(snd_redring, 0, false);
				net_sound_emit(snd_redring);
				
				audio_play_sound(mus_mindfuck, 0, false);
				instance_create_depth(0, 0, -100, obj_redring_screen);
				global.player.redRingTimer = 60 * 10;
			}
			else
			{						
				//Hp regen
				global.player.rings++;
				if(global.player.redRingTimer >= 60)
				{
					var cnt = ((global.timeMinutes <= 0 && global.timeSeconds <  60) ? 2 : 0.5) * 60;
					
					global.player.redRingTimer = max(global.player.redRingTimer - cnt, 60);
				}
				
				if(global.player.rings >= 10 && global.player.hp < 100 && _canHeal)
				{
					global.player.rings = 0;
					global.player.hp += 20;
					audio_play_sound(snd_heal, 0, false);
					net_sound_emit(snd_heal);
					
					var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
					buffer_write(pak, buffer_u8, 0);
					send_server_tcp(pak);
					
					obj_achivements.healthRestore++;
					if(obj_achivements.healthRestore >= 3 && room != room_fartzone && !obj_achivements.achivements[16])
					{
						obj_achivements.mercoins += 100;
						obj_achivements.save();
						
						obj_achivements.achivements[16] = true;
						obj_achivements.save();
						obj_achivements.show();
					}
				}
				else
				{
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
				}
			}
			
			break;
		}
		
		case PacketType.CLIENT_SPAWN_EFFECT:
		{				
			var xx = buffer_read_s(rbuff, buffer_u16);
			var yy = buffer_read_s(rbuff, buffer_u16);
			var fade = buffer_read_s(rbuff, buffer_bool);
			var dir = buffer_read_s(rbuff, buffer_s8);
			var spr = buffer_read_s(rbuff, buffer_u8);
			var xspd = buffer_read_s(rbuff, buffer_s8);
			var yspd = buffer_read_s(rbuff, buffer_s8);
			var spd = buffer_read_s(rbuff, buffer_f32);
			
			if(spr >= array_length(global.net_effs))
				break;
			
			var inst = scr_effect_quick(xx, yy, global.net_effs[spr], spd, fade, xspd, yspd);
			inst.image_xscale = dir;
			
			break;
		}
		
		case PacketType.SERVER_RMZSLIME_STATE:
		{				
			if(isPasstrough)
				break;
				
			var type = buffer_read_s(rbuff, buffer_u8);
			
			if(type == 0) //Spawn
			{
				var _uid = buffer_read_s(rbuff, buffer_u16);
				var _xx = buffer_read_s(rbuff, buffer_u16);
				var _yy = buffer_read_s(rbuff, buffer_u16);
				var _state = buffer_read_s(rbuff, buffer_u8);
				
				var inst = instance_create_depth(_xx, _yy, 0, obj_rmzsonic);
				inst.x = _xx;
				inst.y = _yy;
				inst.state = _state;
				inst.nid = _uid;
			}
			else if(type == 2) //Despawn
			{
				var _uid = buffer_read_s(rbuff, buffer_u8);
				
				if(!instance_exists(obj_rmzsonic))
					break;
					
				with(obj_rmzsonic)
				{
					if(nid != _uid)
						continue;
					
					destroy();
					break;
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_RMZSLIME_RINGBONUS:
		{
			if(isPasstrough)
				break;
				
			var _isRed = buffer_read_s(rbuff, buffer_u8);
			var _canHeal = buffer_read_s(rbuff, buffer_bool);
			
			if(!instance_exists(global.player))
				break;
				
			if(global.player.isDead)
				break;
				
			if(global.player.revivalTimes >= 2)
				break;
				
			if(global.character == CHARACTER_EXE)
				break;
				
			if(_isRed && global.player.redRingTimer <= 0)
			{
				audio_play_sound(mus_mindfuck, 0, false);
				audio_play_sound(snd_redring, 0, false);
				net_sound_emit(snd_redring);
				net_quick_effect(x, y-10, spr_ring_sparkle);
				instance_create_depth(0, 0, -100, obj_redring_screen);
				global.player.redRingTimer = 60 * 10;
			}
			else if(!_isRed)
			{
				net_quick_effect(x, y-10, spr_ring_sparkle);
				
				global.player.rings++;
				
				if(global.player.redRingTimer >= 60)
				{
					var cnt = ((global.timeMinutes <= 0 && global.timeSeconds <  60) ? 2 : 0.5) * 60;
					
					global.player.redRingTimer = max(global.player.redRingTimer - cnt, 60);
				}
				
				if(global.player.rings >= 10 && global.player.hp < 100 && _canHeal)
				{
					global.player.rings = 0;
					global.player.hp += 20;
					audio_play_sound(snd_heal, 0, false);
					net_sound_emit(snd_heal);
					
					var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
					buffer_write(pak, buffer_u8, 0);
					send_server_tcp(pak);
					
					obj_achivements.healthRestore++;
					if(obj_achivements.healthRestore >= 3 && room != room_fartzone && !obj_achivements.achivements[16])
					{
						obj_achivements.mercoins += 100;
						obj_achivements.save();
						
						obj_achivements.achivements[16] = true;
						obj_achivements.save();
						obj_achivements.show();
					}
				}
				else
				{
					audio_play_sound(snd_ring, 0, false);
					net_sound_emit(snd_ring);
				}
			}
			
			break;
		}
		
		case PacketType.SERVER_FORCE_DAMAGE:
		{				
			if(isPasstrough)
				break;
				
			var dmg = buffer_read_s(rbuff, buffer_u8);
			var dirX = buffer_read_s(rbuff, buffer_s8);
			var dirY = buffer_read_s(rbuff, buffer_s8);
			
			scr_player_hurt(dmg, dirX, dirY);				
			break;
		}
		
		case PacketType.SERVER_ETRACKER_STATE:
		{			
			if(isPasstrough)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			
			if(_state == 0)
			{
				var _id = buffer_read_s(rbuff, buffer_u16);
				var _x = buffer_read_s(rbuff, buffer_u16);
				var _y = buffer_read_s(rbuff, buffer_u16);
				
				var inst = instance_create_depth(_x, _y, 0, obj_eggtrack);
				inst.nid = _id;
				inst.x = _x;
				inst.y = _y;
			}
			else
			{						
				if(!instance_exists(obj_eggtrack))
					break;
					
				var _id = buffer_read_s(rbuff, buffer_u16);
				var _pid = buffer_read_s(rbuff, buffer_u16);
				
				with(obj_eggtrack)
				{
					if(nid != _id)
						continue;
						
					image_index = 0;
					sprite_index = spr_eggtrack_destroy;
					activated = true;
					break;
				}
								
				if(!instance_exists(obj_player_puppet))
					break;
				
				var target = noone;
				with(obj_player_puppet)
				{
					if(master_id != _pid)
						continue;
					
					target = self;
				}
				
				if(!instance_exists(obj_surv_indicator))
					break;
					
				if(!instance_exists(global.player))
					break;
					
				if(global.character == CHARACTER_EGGMAN)
				{
					if(global.player.revivalTimes <= 2 && _pid == obj_netclient.exeId)
						obj_achivements.rEggTrack++;
					else
						obj_achivements.rExeEggTrack++;
						
					if(obj_achivements.rEggTrack >= 4 && room != room_fartzone && !obj_achivements.achivements[26])
					{
						obj_achivements.achivements[26] = true;
						obj_achivements.show();
						obj_achivements.save();
						
						obj_achivements.mercoins += 100;
						obj_achivements.save();
					}
					
					if(obj_achivements.rExeEggTrack >= 3 && room != room_fartzone && !obj_achivements.achivements[27])
					{
						obj_achivements.achivements[27] = true;
						obj_achivements.show();
						obj_achivements.save();
						
						obj_achivements.mercoins += 75;
						obj_achivements.save();
					}
				}
				
				var isDemon = false;
				if(global.character == CHARACTER_EGGMAN)
				{
					isDemon = global.player.revivalTimes >= 2;					
				}
				else
				{
					with(obj_player_puppet)
					{
						if(character != CHARACTER_EGGMAN)
							continue;
							
						isDemon = isDemonized;
					}
				}
				
				if(isDemon && (global.player.revivalTimes < 2 && global.character != CHARACTER_EXE))
					break;
					
				if(!isDemon && (global.player.revivalTimes >= 2 || global.character == CHARACTER_EXE))
					break;
				
				obj_surv_indicator.target = target;
				obj_surv_indicator.alarm[0] = 60 * 3;
			}
			break;
		}
			
		case PacketType.SERVER_GAME_TIME_SYNC:
		{				
			if(isPasstrough)
				break;
				
			var _timer = buffer_read_s(rbuff, buffer_u16);
			if(instance_exists(obj_level))
			{
				global.timeMinutes = ceil((_timer+1) / 3600) - 1;
				global.timeSeconds = ceil(_timer /  60) %  60;
			}
			
			if(!instance_exists(obj_level))
				break;
				
			obj_level.timeFrame++;
			if(global.timeMinutes == 2 && global.timeSeconds == 1)
				instance_create_depth(0, 0, 0, obj_suddendeath);
				
			if(global.timeMinutes == 0 && global.timeSeconds <= 10)
				audio_play_sound(snd_clock, 1, false);
			
			break;
		}
		
		case PacketType.SERVER_GAME_DEATHTIMER_TICK:
		{
			var _exeNear = buffer_read_s(rbuff, buffer_u8);
			var _id = buffer_read_s(rbuff, buffer_u16);
			var _timer = buffer_read_s(rbuff, buffer_u8);
			
			if(obj_netclient.nid == _id)
			{
				if(!instance_exists(global.player))
					break;
					
				global.player.deadTimer = _timer;
				global.player.deadColor = _exeNear ? c_red : c_white;
				break;
			}
			
			if(!instance_exists(obj_player_puppet))
				break;
				
			with(obj_player_puppet)
			{
				if(master_id != _id)
					continue;
					
				deadTimer = _timer;
				deadColor = _exeNear ? c_red : c_white;
				break;
			}
			break;
		}
		
		case PacketType.SERVER_GAME_DEATHTIMER_END:
		{				
			if(isPasstrough)
				break;
				
			var demonize = buffer_read_s(rbuff, buffer_bool);
			
			if(!instance_exists(global.player))
				break;
			
			if(!demonize)
			{ 
				global.player.deadTimer = 31;
				global.player.revivalTimes = 1;
				break;
			}
			
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = true;
			
			instance_create_depth(global.player.x, global.player.y, 0, obj_demon_indicator);
			net_quick_effect(global.player.x, global.player.y + 32, spr_ring_teleport, false, 1, 0, 0, 2);
			audio_play_sound(snd_demonization, 0, false);
			
			switch(global.character)
			{
				case CHARACTER_TAILS:
					global.player.attackTimer = 0;
					global.player.flyTimer = -420;
					break;
					
				case CHARACTER_KNUX:
					global.player.attackTimer = 0;
					global.player.glideTimer = 0;
					break;
					
				case CHARACTER_EGGMAN:
					global.player.djumpRecharge = 0;
					global.player.trackerRecharge = 0;
					global.player.shieldRechrage = 0;		
					break;
					
				case CHARACTER_AMY:
					global.player.attackTimer = 0;
					global.player.hjumpTimer = 0;
					break;
					
				case CHARACTER_CREAM:
					global.player.flyTimer = 0;
					global.player.dashTimer = 0;
					global.player.ringsTimer = 0;
					break;
					
				case CHARACTER_SALLY:
					global.player.attackTimer = 0;
					global.player.shieldTimer = 0;
					global.player.shieldRechrage = 0;	
					break;
			}
			
			var table = obj_unlockables.palettes[? global.character + PALETTE_DEMON];
			
			global.palleteFrom = table.from;
			global.palleteTo = table.to;
			global.palleteName = table.name;
			net_send_palette();
			
			obj_achivements.alarm[1] = 60 * 5;
			obj_achivements.demonLast = true;
			
			global.player.hp = 100;
			global.player.isDead = false;
			global.player.revivalTimes = 2;
			
			with(global.player.reviveObj)
				instance_destroy();
			
			global.player.reviveObj = noone;
			global.player.hurttime = 60 * 2;
			global.cameraMode = 0;
			break;
		}
		
		case PacketType.SERVER_GAME_PLAYER_ESCAPED:
		{				
			var pid = buffer_read_s(rbuff, buffer_u16);
			
			obj_achivements.rPlayersEscaped++;
			
			if(!instance_exists(obj_player_puppet))
				break;
			
			with(obj_player_puppet)
			{
				if(pid == master_id)
				{
					if(obj_camera.spectatingObj == self)
						obj_camera.spectatingObj = noone;
						
					instance_destroy();
					break;
				}
			}
			
			audio_play_sound(snd_teleport, 0, false);
			
			if(!instance_exists(obj_bigring))
				break;
			
			instance_create_depth(obj_bigring.x, obj_bigring.y, -100, obj_bigring_teleport);
			break;
		}
		
		case PacketType.SERVER_GAME_SPAWN_RING:
		{
			if(isPasstrough)
				break;
				
			var type = buffer_read_s(rbuff, buffer_bool);
			
			if(gameEnds)
				break;
			
			if(!type)
			{
				if(instance_exists(obj_bigring))
				{
					with(obj_bigring)
						sprite_index = spr_bigring;
					break;
				}
				
				if(room == room_dotdotdot)
				{
					audio_stop_sound(mus_dotdotdot);
					audio_stop_sound(mus_dotdotdot2);
					
					scr_play_music(mus_dotdotdot_chase);
				}
				else if(room == room_act9)
				{
					audio_sound_gain(mus_act9, 0, 1000);
					audio_sound_gain(mus_act9_chase, 1, 1000);
				}
				else
					scr_play_music(global.levels[lvlId].chaseMusic);
				
				var ind = buffer_read_s(rbuff, buffer_u8); 
				var inst = instance_find(obj_ringspawn, ind % (instance_number(obj_ringspawn)));
				
				instance_create_depth(inst.x, inst.y, 0, obj_bigring);
							
				with(obj_level)
					state = 1;
					
				if(room == room_notperfect)
				{
					with(obj_npring)
						visible = true;
				}
			}
			else
			{
				if(!instance_exists(obj_bigring))
					break;
					
				with(obj_bigring)
					sprite_index = spr_bigring_ready;
			}
				
			break;
		}
		
		case PacketType.SERVER_GAME_EXE_WINS:
		{				
			if(isPasstrough)
				break;
				
			var _achiv = buffer_read_s(rbuff, buffer_bool);
				
			gameEnds = true;
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = false;
				
			audio_play_sound(snd_exe_wins, 0, false);
			var inst = instance_create_depth(0, 0, -9999, obj_ending);
			
			if(global.character == CHARACTER_EXE)
			{
				inst.sprite_index = spr_youkilledeveryone;
				
				if(room != room_fartzone && _achiv)
				{
					obj_achivements.exeWins++;

					var map = room_get_name(room);
					if(!array_contains(obj_achivements.maps, map))
						array_push(obj_achivements.maps, map);
						
					if(array_length(obj_achivements.maps) >= 20 && room != room_fartzone && !obj_achivements.achivements[49])
					{
						obj_achivements.achivements[49] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.show();
					}
					
					obj_achivements.save();
				}
				
				if(_achiv)
				{
					switch(global.exeCharacter)
					{
						case EXE_ORIGINAL: obj_achivements.exe = true; break;
						case EXE_CHAOS: obj_achivements.chaos = true; break;
						case EXE_EXETIOR: obj_achivements.exetior = true; break;
						case EXE_EXELLER: obj_achivements.exeller = true; break;
					}
				
					with(obj_achivements)
					{
						if(!achivements[19] && exe && chaos && exetior && exeller)
						{
							obj_achivements.achivements[19] = true;
							obj_achivements.mercoins += 100;
					
							obj_achivements.show();
						}
					}
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 10 && room != room_fartzone && !obj_achivements.achivements[0])
					{
						obj_achivements.achivements[0] = true;
						obj_achivements.mercoins += 50;
					
						obj_achivements.show();
					}
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 50 && room != room_fartzone && !obj_achivements.achivements[1])
					{
						obj_achivements.achivements[1] = true;
						obj_achivements.mercoins += 250;
					
						obj_achivements.show();
					}	
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 100 && room != room_fartzone && !obj_achivements.achivements[2])
					{
						obj_achivements.achivements[2] = true;
						obj_achivements.mercoins += 500;
					
						obj_achivements.show();
					}
				
					if(ds_exists(obj_netclient.players, ds_type_map))
					{
						var dick = ds_map_size(obj_netclient.players);
					
						if(dick > 0)
							obj_achivements.mercoins += (dick - 1) * 2;
					}
				}
			}
			else if(instance_exists(global.player) && global.player.revivalTimes >= 2)
				inst.sprite_index = spr_youkilledeveryone;
			else
				inst.sprite_index = spr_gameover;
			
			obj_achivements.save();
			obj_achivements.save();
				
			if(!instance_exists(obj_level))
			{
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
			
			with(obj_level)
				alarm[1] = 60 * 3;
			
			if(instance_exists(obj_bigring))
				with(obj_bigring)
					instance_destroy();
			
			with(obj_player_puppet)
			{
				if(master_id != obj_netclient.exeId)
					continue;
					
				global.cameraMode = 2;
				obj_camera.spectatingObj = self;
				obj_camera.locked = true;
				break;
			}
				
			if(!instance_exists(global.player))
				break;
				
			if(global.character == CHARACTER_EXE)
			{
				global.player.won = true;
				global.playerControls = false;
			}
			
			break;
		}
		
		case PacketType.SERVER_GAME_TIME_OVER:
		{			
			if(isPasstrough)
				break;
			
			var _achiv = buffer_read_s(rbuff, buffer_bool);
				
			gameEnds = true;
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = false;
				
			global.playerControls = false;
			
			audio_play_sound(snd_exe_wins, 0, false);
			var inst = instance_create_depth(0, 0, -9999, obj_ending);
			inst.sprite_index = spr_timeover;
						
			if(global.character == CHARACTER_EXE)
			{
				if(room != room_fartzone && _achiv)
				{
					obj_achivements.exeWins++;
					
					var map = room_get_name(room);
					if(!array_contains(obj_achivements.maps, map))
						array_push(obj_achivements.maps, map);
						
					if(array_length(obj_achivements.maps) >= 18 && room != room_fartzone && !obj_achivements.achivements[49])
					{
						obj_achivements.achivements[49] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.show();
					}
				}
				
				if(_achiv)
				{
					switch(global.exeCharacter)
					{
						case EXE_ORIGINAL: obj_achivements.exe = true; break;
						case EXE_CHAOS: obj_achivements.chaos = true; break;
						case EXE_EXETIOR: obj_achivements.exetior = true; break;
						case EXE_EXELLER: obj_achivements.exeller = true; break;
					}
				
					with(obj_achivements)
					{
						if(!achivements[19] && exe && chaos && exetior && exeller)
						{
							obj_achivements.achivements[19] = true;
							obj_achivements.mercoins += 100;
					
							obj_achivements.show();
						}
					}
					
					if(obj_achivements.survWins + obj_achivements.exeWins >= 10 && room != room_fartzone && !obj_achivements.achivements[0])
					{
						obj_achivements.achivements[0] = true;
						obj_achivements.mercoins += 50;
					
						obj_achivements.show();
					}
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 50 && room != room_fartzone && !obj_achivements.achivements[1])
					{
						obj_achivements.achivements[1] = true;
						obj_achivements.mercoins += 250;
					
						obj_achivements.show();
					}	
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 100 && room != room_fartzone && !obj_achivements.achivements[2])
					{
						obj_achivements.achivements[2] = true;
						obj_achivements.mercoins += 500;
					
						obj_achivements.show();
					}
				
					if(ds_exists(obj_netclient.players, ds_type_map))
					{
						var dick = ds_map_size(obj_netclient.players);
					
						if(dick > 0)
							obj_achivements.mercoins += (dick - 1) * 2;
					}
				
					if(obj_achivements.mercoins <= 0)
						obj_achivements.mercoins = 0;
				}
			}
			
			obj_achivements.save();
			obj_achivements.save();
			
			if(!instance_exists(obj_level))
			{
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
			
			with(obj_level)
				alarm[1] = 60 * 3;
			
			if(instance_exists(obj_bigring))
				with(obj_bigring)
					instance_destroy();
			
			with(obj_player_puppet)
			{
				if(master_id != obj_netclient.exeId)
					continue;
					
				global.cameraMode = 2;
				obj_camera.spectatingObj = self;
				obj_camera.locked = true;
				break;
			}
				
			if(!instance_exists(global.player))
				break;
				
			if(global.character == CHARACTER_EXE)
			{
				global.player.won = true;
				global.playerControls = false;
			}
			
			break;
		}
		
		case PacketType.SERVER_GAME_PLAYERS_READY:
		{
			if(isPasstrough)
				break;
				
			isServerReady = true;
			net_send_palette();
			break;
		}
		
		case PacketType.CLIENT_PET_PALETTE:
		{
			var _type = buffer_read_s(rbuff, buffer_bool);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _size = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_player_puppet))
				break;
			
			with(obj_player_puppet)
			{
				if(master_id != _pid)
					continue;
				
				if(_type)
				{
					petFromPallete = array_create(_size, 0);
					
					for(var i = 0; i < _size; i++)
						petFromPallete[i] = buffer_read_s(rbuff, buffer_u8) / 255.0;
				}
				else
				{
					petToPallete = array_create(_size, 0);
					
					for(var i = 0; i < _size; i++)
						petToPallete[i] = buffer_read_s(rbuff, buffer_u8) / 255.0;
				}
				break;
			}
			
			
			break;
		}
		
		case PacketType.SERVER_MJCRYSTAL_STATE:
		{
			if(isPasstrough)
				 break;
				 
			var _state = buffer_read_s(rbuff, buffer_bool);
			if(!instance_exists(obj_marijuna_crystal))
				break;
				
			with(obj_marijuna_crystal)
			{
				activated = _state;
				
				if(activated)
					audio_play_sound_on(emitter, snd_destiny, false, 0);
			}
			break;
		}
		
		case PacketType.SERVER_MJJUDGER_STATE:
		{
			if(isPasstrough)
				 break;
				 
			var _state = buffer_read_s(rbuff, buffer_bool);
			if(!instance_exists(obj_marijuna_judger))
				break;
				
			with(obj_marijuna_judger)
			{					
				state = _state;
				
				if(state == 1)
					audio_play_sound_on(emitter, snd_judger, false, 0);
			}
			
			break;
		}
		
		case PacketType.CLIENT_PLAYER_PALETTE:
		{
			var _type = buffer_read_s(rbuff, buffer_bool);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _name = buffer_read_s(rbuff, buffer_string);
			var _size = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_player_puppet))
				break;
				
			with(obj_player_puppet)
			{
				if(master_id != _pid)
					continue;
				
				palleteName = _name;
				
				if(_type)
				{
					fromPallete = array_create(_size, 0);
					
					for(var i = 0; i < _size; i++)
						fromPallete[i] = buffer_read_s(rbuff, buffer_u8) / 255.0;
				}
				else
				{
					toPallete = array_create(_size, 0);
					
					for(var i = 0; i < _size; i++)
					{						
						toPallete[i] = buffer_read_s(rbuff, buffer_u8) / 255.0;
					}
				}
					
				break;
			}
			
			var _pur = false;
			var _target = noone;
			
			if(global.character != CHARACTER_EXE)
			{
				if(!instance_exists(obj_player_puppet))
					return;
				
				var _tg = noone;
				with(obj_player_puppet)
				{
					if(character != CHARACTER_EXE)
						continue;
						
					_tg = self;
				}
				
				_target = _tg;
			}
			else
			{
				if(global.palleteName == "menace")
					_pur = true;
			}
			
			if(_target != noone)
			{
				if(_target.palleteName == "menace")
					_pur = true;
			}
			
			if(_pur)
			{
				if(!instance_exists(obj_blackring))
					break;
					
				with(obj_blackring)
					sprite_index = spr_blackring_purple;
			}
			
			break;
		}
		
		case PacketType.SERVER_GAME_SURVIVOR_WIN:
		{			
			if(isPasstrough)
				break;
				
			var _achiv = buffer_read_s(rbuff, buffer_bool);
				
			gameEnds = true;
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = false;
			
			global.playerControls = false;
			
			audio_play_sound(snd_survivor_win, 0, false);
			var inst = instance_create_depth(0, 0, -9999, obj_ending);
			
			if(global.character == CHARACTER_EXE || (instance_exists(global.player) && (global.player.revivalTimes >= 2 || global.player.hp <= 0)))
				inst.sprite_index = spr_gameover;
			else
			{
				if(room != room_fartzone && _achiv)
				{
					obj_achivements.survWins++;
				
					var map = room_get_name(room);
					if(!array_contains(obj_achivements.maps, map))
						array_push(obj_achivements.maps, map);
						
					if(array_length(obj_achivements.maps) >= 18 && !obj_achivements.achivements[49])
					{
						obj_achivements.achivements[49] = true;
						obj_achivements.mercoins += 100;
						
						obj_achivements.show();
					}
					
					obj_achivements.save();
				}
				
				if(_achiv)
				{
					switch(global.character)
					{
						case CHARACTER_TAILS: obj_achivements.tails = true; break;
						case CHARACTER_KNUX: obj_achivements.knux = true; break;
						case CHARACTER_EGGMAN: obj_achivements.eggman = true; break;
						case CHARACTER_AMY: obj_achivements.amy = true; break;
						case CHARACTER_CREAM: obj_achivements.cream = true; break;
						case CHARACTER_SALLY: obj_achivements.sally = true; break;
					}
				
					if(room != room_fartzone && room == room_pricelessfreedom && !obj_achivements.achivements[47] && obj_achivements.rBlackRings == 0)
					{
						obj_achivements.mercoins += 25;
						obj_achivements.save();
					
						obj_achivements.achivements[47] = true;
						obj_achivements.save();
						obj_achivements.show();
					}
				
					if(room != room_fartzone && !obj_achivements.achivements[48] && obj_achivements.rShardsCollected >= 6)
					{
						obj_achivements.mercoins += 25;
						obj_achivements.save();
					
						obj_achivements.achivements[48] = true;
						obj_achivements.save();
						obj_achivements.show();
					}
				
					if(room != room_fartzone && !obj_achivements.achivements[28] && global.character == CHARACTER_AMY && obj_achivements.rAmyStuns == 0)
					{
						obj_achivements.mercoins += 75;
						obj_achivements.save();
					
						obj_achivements.achivements[28] = true;
						obj_achivements.save();
						obj_achivements.show();
					}
				
					if(!obj_achivements.wasHurt && room != room_fartzone && !obj_achivements.achivements[11])
					{
						obj_achivements.achivements[11] = true;
					
						obj_achivements.mercoins += 50;
						obj_achivements.show();
					}
				
					with(obj_achivements)
					{
						switch(room)
						{
							case room_hideandseek2:
							case room_angelisland:
								if(global.character == CHARACTER_TAILS)
								{
									if(!achivements[38])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[38] = true;
										save();
										show();
									}
								}
								break;
						
							case room_youcantrun:
								if(global.character == CHARACTER_KNUX)
								{
									if(!achivements[39])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[39] = true;
										save();
										show();
									}
								}
								break;
							
							case room_dotdotdot:
								if(global.character == CHARACTER_EGGMAN)
								{
									if(!achivements[40])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[40] = true;
										save();
										show();
									}
								}
								break;
							
							case room_notperfect:
								if(global.character == CHARACTER_AMY)
								{
									if(!achivements[41])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[41] = true;
										save();
										show();
									}
								}
								break;
							
							case room_kindandfair:
								if(global.character == CHARACTER_CREAM)
								{
									if(!achivements[42])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[42] = true;
										save();
										show();
									}
								}
								break;
								
							case room_act9:
								if(global.character == CHARACTER_SALLY)
								{
									if(!achivements[43])
									{
										obj_achivements.mercoins += 25;
										obj_achivements.save();
									
										achivements[43] = true;
										save();
										show();
									}
								}
								break;
							
							case room_torturecave:
								if(global.character == CHARACTER_TAILS)
								{
									var exeChar = 0;
								
									if(instance_exists(obj_player_puppet))
									{
										with(obj_player_puppet)
										{
											if(character != CHARACTER_EXE)
												continue;
											
											exeChar = exeCharacter;
											break;
										}
									}
								
									if(exeChar == EXE_CHAOS)
									{
										if(!achivements[44])
										{
											obj_achivements.mercoins += 25;
											obj_achivements.save();
										
											achivements[44] = true;
											save();
											show();
										}
									}
								}
								break;
							
							case room_limpcity:
								if(global.character == CHARACTER_SALLY)
								{
									var exeChar = 0;
								
									if(instance_exists(obj_player_puppet))
									{
										with(obj_player_puppet)
										{
											if(character != CHARACTER_EXE)
												continue;
											
											exeChar = exeCharacter;
											break;
										}
									}
								
									if(exeChar == EXE_EXELLER)
									{
										if(!achivements[46])
										{
											obj_achivements.mercoins += 25;
											obj_achivements.save();
										
											achivements[46] = true;
											save();
											show();
										}
									}
								}
								break;
							
							case room_nastyparadise:
								if(global.character == CHARACTER_CREAM)
								{
									var exeChar = 0;
								
									if(instance_exists(obj_player_puppet))
									{
										with(obj_player_puppet)
										{
											if(character != CHARACTER_EXE)
												continue;
											
											exeChar = exeCharacter;
											break;
										}
									}
								
									if(exeChar == EXE_EXETIOR)
									{
										if(!achivements[45])
										{
											obj_achivements.mercoins += 25;
											obj_achivements.save();
										
											achivements[45] = true;
											save();
											show();
										}
									}
								}
								break;
						}
				
						if(!achivements[18] && tails && knux && eggman && amy && cream && sally)
						{
							obj_achivements.mercoins += 100;
							obj_achivements.save();
						
							achivements[18] = true;
							save();
							show();
						}
					
						if(!achivements[20] && rPlayersEscaped >= 5)
						{
							obj_achivements.mercoins += 50;
						
							achivements[20] = true;
							show();
						}
					}
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 10 && room != room_fartzone && !obj_achivements.achivements[0])
					{
						obj_achivements.achivements[0] = true;
						obj_achivements.mercoins += 50;
					
						obj_achivements.show();
					}
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 50 && room != room_fartzone && !obj_achivements.achivements[1])
					{
						obj_achivements.achivements[1] = true;
						obj_achivements.mercoins += 250;
					
						obj_achivements.show();
					}	
				
					if(obj_achivements.survWins + obj_achivements.exeWins >= 100 && room != room_fartzone && !obj_achivements.achivements[2])
					{
						obj_achivements.achivements[2] = true;
						obj_achivements.mercoins += 500;
					
						obj_achivements.show();
					}
				}
				
				inst.sprite_index = spr_survivorsescaped;
			}
			
			obj_achivements.save();
			obj_achivements.save();
			
			if(!instance_exists(obj_level))
			{
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
			
			with(obj_level)
				alarm[1] = 60 * 3;
			
			with(obj_player_puppet)
			{
				if(master_id != obj_netclient.exeId)
					continue;
					
				global.cameraMode = 2;
				obj_camera.spectatingObj = self;
				obj_camera.locked = true;
				break;
			}
			
			if(!instance_exists(global.player))
				break;
				
			if(global.character == CHARACTER_EXE)
			{
				global.player.lost = true;
				global.playerControls = false;
			}
			
			break;
		}
		
		case PacketType.SERVER_REVIVAL_REVIVED:
		{
			if(isPasstrough)
				break;
				
			if(!instance_exists(global.player))
				return;
			
			if(global.player.revivalTimes >= 2)
				return;
				
			var packet = cpacket_tcp(PacketType.CLIENT_PLAYER_DEATH_STATE);
			buffer_write(packet, buffer_bool, false);
			buffer_write(packet, buffer_u8, global.player.revivalTimes);
			send_server_tcp(packet);
			
			if(instance_exists(obj_deserttown_i))
				with(obj_deserttown_i)
					show = true;
			
			global.player.hp = 40;
			global.player.isDead = false;
			global.player.revivalTimes++;
			
			with(global.player.reviveObj)
				instance_destroy();
				
			global.player.reviveObj = noone;
			global.player.hurttime = 60 * 4;
			global.cameraMode = 0;
			break;
		}
		
		case PacketType.CLIENT_PLAYER_HEAL_PART:
		{
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			instance_create_depth(_x, _y, -10, obj_heal_particle);
			break;
		}
		
		case PacketType.CLIENT_PLAYER_HEAL:
		{
			var _pid = buffer_read_s(rbuff, buffer_u16);
			
			if(obj_netclient.nid != _pid)
				break;
			
			if(!instance_exists(global.player))
				 break;
				 
			if(global.player.hp >= 100)
				return;
			
			audio_play_sound(snd_heal, 0, false);
			net_sound_emit(snd_heal);
			
			global.player.hp += 20;
			break;
		}
		
		case PacketType.SERVER_REVIVAL_RINGSUB:
		{
			if(isPasstrough)
				break;
			
			if(!instance_exists(global.player))
				 break;
				
			global.player.rings = 0;
			obj_achivements.revivals++;
			
			if(obj_achivements.revivalLast && room != room_fartzone && !obj_achivements.achivements[5])
			{
				obj_achivements.achivements[5] = true;
				obj_achivements.mercoins += 100;
				obj_achivements.save();
				obj_achivements.save();
				
				obj_achivements.show();
			}
			
			obj_achivements.alarm[0] = 60;
			obj_achivements.revivalLast = true;
			
			if(obj_achivements.revivals >= 1 && room != room_fartzone && !obj_achivements.achivements[3])
			{
				obj_achivements.achivements[3] = true;
				obj_achivements.mercoins += 25;
				obj_achivements.save();
				obj_achivements.save();
				
				obj_achivements.show();
			}
			
			if(obj_achivements.revivals >= 2 && room != room_fartzone && !obj_achivements.achivements[4])
			{
				obj_achivements.achivements[4] = true;
				obj_achivements.mercoins += 50;
				obj_achivements.save();
				obj_achivements.save();
				
				obj_achivements.show();
			}
			
			if(obj_achivements.revivals >= 3 && room != room_fartzone && !obj_achivements.achivements[6])
			{
				obj_achivements.achivements[6] = true;
				obj_achivements.mercoins += 200;
				obj_achivements.save();
				obj_achivements.save();
				
				obj_achivements.show();
			}
			
			break;
		}
		
		case PacketType.SERVER_REVIVAL_STATUS:
		{
			if(isPasstrough)
				break;
				
			var _status = buffer_read_s(rbuff, buffer_bool);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			
			with(obj_revival_puppet)
			{
				if(master_id != _pid)
					continue;
					
				show = _status;
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_PLAYER_DEATH_STATE:
		{
			if(isPasstrough)
				break;
				
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _dead = buffer_read_s(rbuff, buffer_bool);
			var _revTimes = buffer_read_s(rbuff, buffer_u8);
			
			if(!_dead)
				break;
			
			if(!instance_exists(obj_player_puppet))
				break;
				
			if(_pid == obj_netclient.nid)
			{
				if(!instance_exists(global.player))
					break;
			
				global.player.revivalTimes = _revTimes;		
				global.player.shards = 0;
				obj_achivements.rShardsCollected = 0;
				break;
			}
			
			with(obj_player_puppet)
			{
				if(master_id != _pid)
					continue;
					
				shards = 0;
				break;
			}
			break;
		}
		
		case PacketType.SERVER_RESULTS:
		{
			lvlId = buffer_read_s(rbuff, buffer_u8);
			
			gameEnds = true;
			isReady = true;
			state = STATE_RESULTS;
			room_goto(room_results);
			return true;
		}
	}
	
	return false;
}