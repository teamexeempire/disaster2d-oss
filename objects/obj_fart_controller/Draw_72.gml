if(!instance_exists(global.player))
	return;

if(potater)
{
	potatoTimer--;
	
	global.player.sprite_index = spr_merfurmu;
	
	if(potatoTimer % 60 == 0)
	{
		var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_POTATER, true);
		buffer_write(pak, buffer_u8, 0);
		buffer_write(pak, buffer_u16, obj_netclient.nid);
		buffer_write(pak, buffer_u8, (potatoTimer / 60) - 1);
		send_server_tcp(pak);
		
		audio_play_sound(snd_roar, 0, false);
		net_sound_emit(snd_roar);
	}
	
	if(potatoTimer <= 0)
		instance_create_depth(0, 0, 0, obj_fart_ass);
}