if(image_alpha < 1)
	image_alpha += 1 / 180.0;
	
image_index = global.ringFrame;

if(used)
	return;

if(visible && image_alpha >= 1 && instance_exists(global.player) && place_meeting(x, y, global.player) && global.character != CHARACTER_EXE)
{	
	if(global.player.redRingTimer > 0)
		return;
		
	if(global.player.hp <= 0 || global.player.revivalTimes >= 2)
		return;
		
	var packet = cpacket_tcp(PacketType.CLIENT_RING_COLLECTED);
	buffer_write(packet, buffer_u8, iid);
	buffer_write(packet, buffer_u16, nid);
	send_server_tcp(packet);
	used = true;
}