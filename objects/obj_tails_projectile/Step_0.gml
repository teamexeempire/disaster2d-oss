if(isBreaking && image_index >= image_number - 1)
{
	instance_destroy();
	return;
}

if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player))
{
	if(isBreaking)
		return;
		
	if(global.player.isDead)
		return;
		
	if(isExe && global.character != CHARACTER_EXE && global.player.revivalTimes < 2)
	{
		if(global.player.hurttime > 0)
			return;
			
		scr_player_hurt(dmg, -sign(x - global.player.x) * 4, 2);
		
		var _dmg = dmg;
		if(instance_exists(obj_player_puppet))
		{
			with(obj_player_puppet)
			{
				if(character != CHARACTER_TAILS)
					continue;
					
				var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
				buffer_write(pak, buffer_u16, master_id);
				buffer_write(pak, buffer_u8, 2);
				buffer_write(pak, buffer_u8, _dmg);
				send_server_tcp(pak);
				
				var buffer = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(buffer, buffer_u8, 2);
				buffer_write(buffer, buffer_u16, master_id);
				buffer_write(buffer, buffer_u16, _dmg);
				buffer_write(buffer, buffer_u16, global.player.hp);
				send_server_tcp(buffer);
				
				break;
			}
		}
		
		if(global.player.hp <= 0)
		{
			if(instance_exists(obj_player_puppet))
			{
				with(obj_player_puppet)
				{
					if(character != CHARACTER_TAILS)
						continue;
						
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 4);
					send_server_tcp(pak);
				}
			}
		}
		
		_destroy();
		return;
	}
		
	if(!isExe && (global.character == CHARACTER_EXE || global.player.revivalTimes >= 2))
	{
		if(global.character == CHARACTER_EXE && global.player.invisTimer > 0)
			return;
			
		if(global.player.hurttime > 0)
			return;
			
		if(global.character == CHARACTER_SALLY)
		{			
			if(global.player.shieldTimer > 0)
			{
				global.player.isHurt = true;
				global.player.hurttime = 60;
				global.player.shieldTimer = 0;
				
				audio_play_sound(snd_sally_shieldbreak, 0, false);
				net_quick_effect(global.player.x, global.player.y, global.player.revivalTimes >= 2 ? spr_shieldbreak2 : spr_shieldbreak, false, 1, 0, 0, 1);
				net_sound_emit(snd_sally_shieldbreak);
				
				_destroy();
				return;
			}
			
			global.player.isSliding = false;
		}
		
		var _dmg = dmg;
		global.player.shockedTimer = 60 * _dmg;
		global.player.xspd = -sign(x - global.player.x) * 4;
		global.player.yspd = -2;
		global.player.isGrounded = false;
		
		audio_play_sound(snd_exe_stun, 0, false);
		net_sound_emit(snd_exe_stun);
		
		if(instance_exists(obj_player_puppet))
		{
			if(global.character == CHARACTER_EXE)
				scr_exe_stunsound();
					
			with(obj_player_puppet)
			{
				if(character != CHARACTER_TAILS)
					continue;
				
				if(global.character == CHARACTER_EXE)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 2);
					buffer_write(pak, buffer_u8, _dmg);
					send_server_tcp(pak);
				}
					
				var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(pak, buffer_u8, 1);
				buffer_write(pak, buffer_u16, obj_netclient.nid);
				buffer_write(pak, buffer_u16, master_id);
				buffer_write(pak, buffer_u8, _dmg);
				send_server_tcp(pak);
				break;
			}
		}
		
		_destroy();
		return;
	}
}