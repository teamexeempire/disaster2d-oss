nid = 0;
iid = 0;
image_alpha = 0;
depth = 2;
used = false;

if(room == room_act9)
	image_blend = c_dkgray;
	
ringBreak = function()
{
	audio_play_sound(snd_exe_ringshutter, 0, false);
	net_sound_emit(snd_exe_ringshutter);
	
	for(var i = 0; i < 4; i++)
	{		
		switch(i)
		{
			case 0:
				var _part = instance_create_depth(x+16-4, y+4, depth - 1, obj_ringpart);
				_part.xspd = 1 + global.player.xspd;
				_part.yspd = irandom_range(-4, -2);
				_part.sprite_index = spr_ringpart;
				break;
		
			case 1:
				var _part = instance_create_depth(x, y+16-4, depth - 1, obj_ringpart);
				_part.xspd = -1 + global.player.xspd;
				_part.yspd = irandom_range(1, 2);
				_part.sprite_index = spr_ringpart2;
				break;
		
			case 2:
				var _part = instance_create_depth(x+4, y+4, depth - 1, obj_ringpart);
				_part.xspd = -1 + global.player.xspd;
				_part.yspd = irandom_range(-4, -2);
				_part.sprite_index = spr_ringpart3;
				break;
		
			case 3:
				var _part = instance_create_depth(x+16-4, y+16-4, depth - 1, obj_ringpart);
				_part.xspd = 1 + global.player.xspd;
				_part.yspd = irandom_range(1, 2);
				_part.sprite_index = spr_ringpart4;
				break;
		}
	}
	
	var packet = cpacket_tcp(PacketType.CLIENT_RING_BROKE, true);
	buffer_write(packet, buffer_u16, x);
	buffer_write(packet, buffer_u16, y);
	buffer_write(packet, buffer_f16, global.player.xspd);
	send_server_tcp(packet);
	
	packet = cpacket_tcp(PacketType.CLIENT_RING_COLLECTED);
	buffer_write(packet, buffer_u8, iid);
	buffer_write(packet, buffer_u16, nid);
	send_server_tcp(packet);
	used = true;
}