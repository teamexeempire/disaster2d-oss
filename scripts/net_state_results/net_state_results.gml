function net_state_results(rbuff, nps, isPasstrough)
{
	show_debug_message(nps);
	switch(nps)
	{
		case PacketType.SERVER_RESULTS_DATA:
		{
			var _name = buffer_read_s(rbuff, buffer_string);
			var _char = buffer_read_s(rbuff, buffer_s8);
			var _end = buffer_read_s(rbuff, buffer_u8);
			var _time = buffer_read_s(rbuff, buffer_u16);
			var _quit = buffer_read_s(rbuff, buffer_u8);
			var _type = buffer_read_s(rbuff, buffer_u8);
			
			var _rings = buffer_read_s(rbuff, buffer_u16);
			var _kills = buffer_read_s(rbuff, buffer_u16);
			var _damage = buffer_read_s(rbuff, buffer_u16);
			var _damageTaken = buffer_read_s(rbuff, buffer_u16);
			var _stunTime = buffer_read_s(rbuff, buffer_u16);
			var _stuns = buffer_read_s(rbuff, buffer_u16);
			var _restored = buffer_read_s(rbuff, buffer_u16);
			
			var _survTime = floor(buffer_read_s(rbuff, buffer_f64) / 60.0);
			var _dangerTime = floor(buffer_read_s(rbuff, buffer_f64) / 60.0);
			
			var _inst = instance_create_layer(3, 33 + (30 * obj_results.index++), "Results", obj_results_icon);
			
			with(_inst)
			{
				image_blend = _quit ? c_gray : c_white;
				nick = _name;
				type = _type;
				rings = _rings;
				kills = _kills;
				damage = _damage;
				damage_taken = _damageTaken;
				stuns = _stuns;
				hp_restored = _restored;
				surv_time = _survTime;
				stun_time = _stunTime;
				danger_time = _dangerTime;
			}
			
			switch(_type)
			{
				case 0:
				{
					switch(_char)
					{
						case 0:
							_inst.icon = spr_lobby_exeicon;
							break;
							
						case 1:
							_inst.icon = spr_lobby_exeicon2;
							break;
							
						case 2:
							_inst.icon = spr_lobby_exeicon3;
							break;
							
						case 3:
							_inst.icon = spr_lobby_exeicon4;
							break;
							
					}
					break;
				}
				
				case 1:
				{
					_inst.icon = spr_playerhealth_demon;
					_inst.frame = _char;
					break;
				}
				
				case 2:
				{
					_inst.icon = spr_playerhealth;
					_inst.frame = 6 + _char * 7;
					break;
				}
				
				case 3:
				{
					_inst.icon = spr_lobby_icon;
					_inst.frame = 2 + _char;
					break;
				}
				
				case 4:
				{
					_inst.icon = spr_playerescaped;
					_inst.frame = _char;
					break;
				}
			}
			
			with(obj_results)
			{
				timeMin = floor(_time / 60);
				timeSec = _time % 60;
				showBlack = false;
				result = _end;
				alarm[0] = 4;
			}
			
			with(obj_lobby_prolet)
			{
				if(_end == 0)
					blackwhite = true;
			}
			
			instance_create_layer(0, 0, "Instances_1", obj_blackfadeout);
			break;
		}
	}
	
	return false;
}