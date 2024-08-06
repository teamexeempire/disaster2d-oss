var gain = 1.0 - (min(distance_to_point(obj_camera.x+213, obj_camera.y + 120), 400) / 400.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(image_alpha < 1)
	image_alpha += 1 / 30.0;

image_index = global.ringFrame;
	
if(used)
	return;
		
if(visible && image_alpha >= 1 && instance_exists(global.player) && place_meeting(x, y, global.player))
{
	if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
		return;
	
	if(global.player.hp <= 0)
		return;
	
	obj_achivements.rBlackRings++;
	
	var packet = cpacket_tcp(PacketType.CLIENT_BRING_COLLECTED);
	buffer_write(packet, buffer_u16, nid);
	send_server_tcp(packet);
	used = true;
}