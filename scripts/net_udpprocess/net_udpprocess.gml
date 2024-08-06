function net_udpprocess(rbuff)
{
	obj_netclient.udp_timeout = 60 * 5;
	var passtrough = buffer_read_s(rbuff, buffer_u8);
	
	//Other clients
	switch(buffer_read_s(rbuff, buffer_u8))
	{		
		case PacketType.SERVER_GAME_PING:
		{
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _ms = buffer_read_s(rbuff, buffer_u16);
			obj_netclient.pings[? _pid] = _ms;
			break;
		}
		
		case PacketType.SERVER_FART_STATE:
		{			
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			if(!instance_exists(obj_fart_dummy))
				return;
			
			with(obj_fart_dummy)
			{
				x = _x;
				y = _y;
			}
			
			break;
		}
		
		case PacketType.SERVER_REVIVAL_PROGRESS:
		{
			if(passtrough)
				 break;
					 
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _prog = buffer_read_s(rbuff, buffer_f64);
			
			with(obj_revival_puppet)
			{
				if(master_id != _pid)
					continue;
					
				progress = _prog;
				break;
			}
			
			break;
		}
		
		case PacketType.CLIENT_PLAYER_DATA:
		{
			if(state != STATE_GAME)
				break;
			
			var pid = buffer_read_s(rbuff, buffer_u16);
			if(instance_exists(obj_player_puppet))
			{				
				with(obj_player_puppet)
				{
					if(pid != master_id)
						continue;
						
					isInactive = false;
					alarm[1] = 60;
					alarm[2] = 5;
					
					pX = x;
					pY = y;
					x = buffer_read_s(rbuff, buffer_u16);
					y = buffer_read_s(rbuff, buffer_u16);
					xspd = buffer_read_s(rbuff, buffer_f16);
					yspd = buffer_read_s(rbuff, buffer_f16);
					
					state = buffer_read_s(rbuff, buffer_u8);
					angle = buffer_read_s(rbuff, buffer_s16);
					image_index = buffer_read_s(rbuff, buffer_u8);
					image_xscale = buffer_read_s(rbuff, buffer_s8);
					
					if(image_xscale > 1)
						image_xscale = 1;
					else if(image_xscale < -1)
						image_xscale = -1;
					
					if(character == CHARACTER_EXE)
					{
						var bitflags = buffer_read_s(rbuff, buffer_u8);
						
						isAttacking = bitflags & PLAYER_ATTACKING;
						isHurt = bitflags & PLAYER_HURT;
						effect = bitflags & PLAYER_EFFECT;
						
						switch(exeCharacter)
						{
							case 0:
								visible = !(bitflags & PLAYER_INVIS);
								break;
							case 1:
								slimeMode = bitflags & PLAYER_SLIME ? CHAOS_AIRTRANSFORM+1 : 0;
								break;
						}
					}
					else
					{
						hp = buffer_read_s(rbuff, buffer_s8);
						revivalTimes = buffer_read_s(rbuff, buffer_u8);
						rings = buffer_read_s(rbuff, buffer_s16);
						
						var bitflags = buffer_read_s(rbuff, buffer_u8);
						if(character == CHARACTER_TAILS)
						{
							tailsCharge = buffer_read_s(rbuff, buffer_u8);
							
							if(instance_exists(obj_puppet_tail))
								obj_puppet_tail.image_angle = buffer_read_s(rbuff, buffer_s16);
						}
						
						if(character == CHARACTER_KNUX || character == CHARACTER_EGGMAN || character == CHARACTER_AMY || character == CHARACTER_SALLY)
							isAttacking = bitflags & PLAYER_ATTACKING;
							
						isHurt = bitflags & PLAYER_HURT;
						hasRedRing = bitflags & PLAYER_REDRING;
						effect = bitflags & PLAYER_EFFECT;
						
						if(character == CHARACTER_SALLY)
							sallyShield = bitflags & PLAYER_SALLYSHIELD;
					}
					break;
				}
			}
			break;
		}
			
		case PacketType.SERVER_TPROJECTILE_STATE:
		{
			if(passtrough)
				 break;
				 
			if(state != STATE_GAME)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			
			if(_state != 1) //impossible
				break;
			
			var _xx = buffer_read_s(rbuff, buffer_u16);
			var _yy = buffer_read_s(rbuff, buffer_u16);
			
			// If doesnt exist then spawn ig
			if(!instance_exists(obj_tails_projectile))
				break;
			
			with(obj_tails_projectile)
			{
				if(isBreaking)
					continue;
					
				x = _xx;
				y = _yy;
				break;
			}
			break;
		}
		
		case PacketType.SERVER_RMZSLIME_STATE:
		{
			if(passtrough)
				 break;
				 
			var type =  buffer_read_s(rbuff, buffer_u8);
			
			if(type != 1)
				return;
				
			var _uid = buffer_read_s(rbuff, buffer_u16);
			var _xx = buffer_read_s(rbuff, buffer_u16);
			var _yy = buffer_read_s(rbuff, buffer_u16);
			var _state = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_rmzsonic))
				break;
			
			with(obj_rmzsonic)
			{
				if(nid != _uid)
					continue;
				
				x = _xx;
				y = _yy;
				state = _state;
					
				break;
			}
			break;
		}
		
		case PacketType.SERVER_ACT9WALL_STATE:
		{
			if(passtrough)
				 break;
				 
			if(state != STATE_GAME)
				break;
			
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			with(obj_act9_wall)
			{
				if(nid != _id)
					continue;
				
				if(nid == 0)
				{
					x = -2240;
					y = _y - 768;
				}
				else if(nid == 1)
				{
					x = _x - 2240;
					y = _y;
				}
				else if(nid == 2)
				{
					x = room_width - _x;
					y = _y; 
				}
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_NAPBALL_STATE:
		{
			if(passtrough)
				 break;
				 
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _nid = buffer_read_s(rbuff, buffer_u8);
			
			if(_state == 1)
			{
				var _waypoint = buffer_read_s(rbuff, buffer_u8);
				var _frame = buffer_read_s(rbuff, buffer_u8);
				var _waypointProgress = buffer_read_s(rbuff, buffer_f64);
				
				var _first = noone;
				var _next = noone;
				
				with(obj_nap_snowball_waypoint)
				{ 
					if(nid != _nid)
						continue;
					
					if(wid == _waypoint)
						_first = self;
						
					if(wid == _waypoint + 1)
						_next = self;
				}
				
				if(_first == noone)
					break;
					
				if(_next == noone)
					break;
				
				if(!instance_exists(obj_nap_snowball))
					break;
				
				with(obj_nap_snowball)
				{
					if(nid != _nid)
						continue;
						
					x = _first.x + ((_next.x - _first.x) * _waypointProgress) + 32;
					y = _first.y + ((_next.y - _first.y) * _waypointProgress) + 64;
					image_index = _frame;
					break;
				}
			}
			break;
		}
		
		case PacketType.CLIENT_SPRING_USE:
		{
			if(state != STATE_GAME)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _y = buffer_read_s(rbuff, buffer_u16);
		}
		
		case PacketType.SERVER_PFLIFT_STATE:
		{
			if(passtrough)
				 break;
				 
			if(state != STATE_GAME)
				break;
				
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _pid = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			if(!instance_exists(obj_pf_lift))
				break;
					
			var inst = noone;
			with(obj_pf_lift)
			{
				if(nid != _id)
					continue;
					
				if(!activated)
					return;
					
				y = _y;
				pid = _pid;
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_VVLCOLUMN_STATE:
		{
			if(passtrough)
				 break;
				 
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _y = buffer_read_s(rbuff, buffer_f32);
			
			if(!instance_exists(obj_vv_lavacolumn))
				break;
				
			with(obj_vv_lavacolumn)
			{
				if(nid != _id)
					continue;
				
				state = _state;
				if(prevState != _state)		
					prevState = _state;
				
				y = _y;
				
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_DTTAILSDOLL_STATE:
		{
			if(passtrough)
				 break;
				 
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			var _tar = buffer_read_s(rbuff, buffer_u8);
			
			if(!instance_exists(obj_darktower_tailsdoll))
				instance_create_depth(_x, _y, 0, obj_darktower_tailsdoll);
				
			obj_darktower_tailsdoll.pX = obj_darktower_tailsdoll.x;
			obj_darktower_tailsdoll.pY = obj_darktower_tailsdoll.y;
			obj_darktower_tailsdoll.x = _x;
			obj_darktower_tailsdoll.y = _y;
			obj_darktower_tailsdoll.image_index = _tar;
			break;
		}
		
		case PacketType.SERVER_DTBALL_STATE:
		{
			if(passtrough)
				 break;
				 
			var _state = buffer_read_s(rbuff, buffer_f32);
			
			if(!instance_exists(obj_darktower_ball))
				break;
			
			with(obj_darktower_ball)
				y = sY + (_state * dir * dist);
			
			break;
		}
		
		case PacketType.SERVER_DTASS_STATE:
		{
			if(passtrough)
				 break;
				 
			var _id = buffer_read_s(rbuff, buffer_u8);
			var _x = buffer_read_s(rbuff, buffer_u16);
			var _y = buffer_read_s(rbuff, buffer_u16);
			
			if(!instance_exists(obj_darktower_sisi))
				break;
				
			with(obj_darktower_sisi)
			{
				if(nid != _id)
					continue;
				
				damage = true;
				x = _x;
				y = _y;
				break;
			}
			break;
		}
		
		case PacketType.SERVER_MJLAVA_STATE:
		{				 
			if(passtrough)
				 break;
				 
			var _state = buffer_read_s(rbuff, buffer_u8);
			var _y = buffer_read_s(rbuff, buffer_f32);
			
			if(!instance_exists(obj_marijuna_lavaplatform))
				break;
				
			with(obj_marijuna_lavaplatform)
			{
				state = _state;
				if(prevState != _state)
					prevState = _state;
				
				if((_state == 2 || _state == 4) && instance_exists(obj_player_sensorBL))
				{
					if(place_meeting(x, y, obj_player_sensorBL) || place_meeting(x, y, obj_player_sensorBR))
					{
						global.player.y = _y - 17;
					}
				}
				
				y = _y;
				break;
			}
			
			break;
		}
		
		case PacketType.SERVER_PONG:
		{
			if(state != STATE_GAME)
				break;
				
			ping = buffer_read(rbuff, buffer_u16);
			break;
		}
	}
}