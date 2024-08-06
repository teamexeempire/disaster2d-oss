if(instance_exists(global.player))
{
	if(place_meeting(x, y, global.player))
	{
		if(canUse)
			draw_sprite(spr_limpcity_eye_hint, current_time / 400, x, y);
		
		if(global.player.isLookingDown || global.player.isLookingUp)
		{
			if(keyboard_check_pressed(global.KeyDown) || keyboard_check_pressed(global.KeyUp))
			{
				var pak = cpacket_tcp(PacketType.CLIENT_HDDOOR_TOGGLE);
				send_server_tcp(pak);
			}
		}
	}
}

image_index = state;
draw_self();