if(sprite_index == spr_eggtrack_destroy && image_index >= image_number - 1)
{
	instance_destroy();
	return;
}

if(!instance_exists(global.player))
	return;
	
depth = global.player.depth - 2;

if(place_meeting(x, y, global.player) && !activated)
{
	if(global.character == CHARACTER_EGGMAN)
		return;
		
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
	
	if(global.player.isDead)
		return;
	
	if(isDemon && (global.player.revivalTimes >= 2 || global.character == CHARACTER_EXE))
		return;
		
	if(!isDemon && (global.player.revivalTimes < 2 && global.character != CHARACTER_EXE))
		return;
		
	switch(global.character)
	{
		case CHARACTER_EXE:
			
			switch(global.exeCharacter)
			{
				case EXE_ORIGINAL:
					global.player.isSlow = true;
					global.player.acc = (EXE_ACC * (100-30)) / 100;
					global.player.maxHSpeed = (EXE_MAXSPEED * (100-30)) / 100;
					global.player.alarm[4] = 60 * 3;
					break;
					
				case EXE_CHAOS:
					global.player.isSlow = true;
					global.player.acc = (CHAOS_ACC * (100-30)) / 100;
					global.player.maxHSpeed = (CHAOS_MAXSPEED * (100-30)) / 100;
					global.player.alarm[4] = 60 * 3;
					break;
					
				case EXE_EXETIOR:
					global.player.isSlow = true;
					global.player.acc = (EXETIOR_ACC * (100-30)) / 100;
					global.player.maxHSpeed = (EXETIOR_MAXSPEED * (100-30)) / 100;
					global.player.alarm[4] = 60 * 3;
					break;
					
					
				case EXE_EXELLER:
					global.player.isSlow = true;
					global.player.acc = (EXELLER_ACC * (100-30)) / 100;
					global.player.maxHSpeed = (EXELLER_MAXSPEED * (100-30)) / 100;
					global.player.alarm[4] = 60 * 3;
					break;
			}
			
			break;
			
		default:
			scr_player_slow(3);
			break;
	}
	 
	audio_play_sound(snd_egg_tracker_activate, 0, false);
	net_sound_emit(snd_egg_tracker_activate);
	
	var packet = cpacket_tcp(PacketType.CLIENT_ETRACKER_ACTIVATED);
	buffer_write(packet, buffer_u16, nid);
	send_server_tcp(packet);
	
	activated = true;
}