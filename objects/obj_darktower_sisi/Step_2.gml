var gain = 1.0 - (min(distance_to_point(obj_camera.x + 240, obj_camera.y + 135), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(image_alpha < 1)
	image_alpha += 0.016;

if(current_time % 8 == 0)
	instance_create_depth(x+40 + irandom_range(-14, 14), y+40 + irandom_range(-10, 10), depth, obj_darktower_kapla);

if(collision_rectangle(x + 19, y + 18, x + 59, y + 20, obj_floor_parent, false, false))
{
	if(distance_to_object(global.player) < 150)
	{
		var factor = 1.0 - (distance_to_object(global.player) / 500.0);
		scr_camera_shake(25, factor, 0.2);
	}

	var pak = cpacket_tcp(PacketType.CLIENT_DTASS_ACTIVATE, false);
	buffer_write(pak, buffer_u8, nid);
	send_server_tcp(pak);
	
	_destroy();
}

if(damage)
{
	if(!instance_exists(global.player))
		return;
	
	if(!visible)
		return;
	
	if(place_meeting(x, y, global.player))
		scr_player_hurt(20, -global.player.image_xscale * 4);
}