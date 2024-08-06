var gain = 1.0 - (min(distance_to_point(obj_camera.x + 240, obj_camera.y + 135), 700) / 700.0);
audio_emitter_position(emitter, x, y-16, 0);
audio_emitter_gain(emitter, gain);

if(!instance_exists(obj_tails_projectile))
	return;
	
if(place_meeting(x, y, obj_tails_projectile))
{
	isBroken = true;
	
	var pack = cpacket_tcp(PacketType.CLIENT_KAFMONITOR_ACTIVATE);
	buffer_write(pack, buffer_u8, nid);
	buffer_write(pack, buffer_bool, true);
	send_server_tcp(pack);
}