var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!audio_is_playing(expsid))
{
	instance_destroy();
	visible = false;
	return;
}

if(!place_meeting(x, y, obj_floor_parent) || cnt > 1)
{
	instance_destroy();
	visible = false;
	return;
}

if(image_index >= image_number - 1)
{
	if(cnt <= 1)
	{
		if(dir > 0)
		{
			var inst = instance_create_depth(x + 25, y, depth, obj_exetior_stompballs); 
			inst.cnt = ++cnt;
			inst.dir = dir;
		}
		else
		{
			var inst = instance_create_depth(x - 25, y, depth, obj_exetior_stompballs); 
			inst.cnt = ++cnt;
			inst.dir = dir;
		}
	}
	
	visible = false;
	return;
}

if(!visible)
	return;

image_xscale = -dir;

if(place_meeting(x, y, global.player))
{
	if(global.character == CHARACTER_EXE)
		return;
		
	if(global.player.revivalTimes >= 2)
		return;
	
	if(global.player.hp <= 0)
		return;
		
	if(global.player.hurttime > 0)
		return;
		
	scr_player_hurt(20, dir * 3);
	scr_exe_checkwin();
	
	if(instance_exists(obj_player_puppet))
	{
		with(obj_player_puppet)
		{
			if(character != CHARACTER_EXE)
				continue;
			
			var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
			buffer_write(pak, buffer_u16, master_id);
			buffer_write(pak, buffer_u8, 7);
			send_server_tcp(pak);
			
			var buffer = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
			buffer_write(buffer, buffer_u8, 2);
			buffer_write(buffer, buffer_u16, master_id);
			buffer_write(buffer, buffer_u16, 20);
			buffer_write(buffer, buffer_u16, global.player.hp);
			send_server_tcp(buffer);
			
			var buffer = cpacket_tcp(PacketType.CLIENT_PLAYER_HURT, true);
			buffer_write(buffer, buffer_u16, master_id);
			buffer_write(buffer, buffer_u16, x);
			buffer_write(buffer, buffer_u16, y);
			buffer_write(buffer, buffer_u16, 0);
			send_server_tcp(buffer);
			
			break;
		}
	}
}