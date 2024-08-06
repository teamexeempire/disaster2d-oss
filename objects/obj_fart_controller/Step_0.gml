if(!instance_exists(global.player))
	return;
	
if(potater)
{
	if(!instance_exists(obj_player_puppet))
		return;
		
	global.player.sprite_index = spr_merfurmu;
	with(obj_player_puppet)
	{
		if(place_meeting(x, y, global.player) && obj_fart_controller.potatoTimer <= 3.5 * 60)
		{
			var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_POTATER, true);
			buffer_write(pak, buffer_u8, 0);
			buffer_write(pak, buffer_u16, master_id);
			buffer_write(pak, buffer_u8, 4);
			send_server_tcp(pak);
			
			var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_POTATER, true);
			buffer_write(pak, buffer_u8, 1);
			buffer_write(pak, buffer_u16, obj_netclient.nid);
			send_server_tcp(pak);
			
			obj_fart_controller.potater = false;
			obj_fart_controller.potatoTimer = 0;
		}
	}
}