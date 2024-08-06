if(place_meeting(x, y, global.player) && sprite_index == spr_bigring_ready)
{
	if(global.player.isDead)
		return;
		
	if(global.character == CHARACTER_EXE)
		return;
		
	if(global.player.revivalTimes >= 2)
		return;
		
	if(global.player.redRingTimer > 0)
		return;
	
	var packet = cpacket_tcp(PacketType.CLIENT_PLAYER_ESCAPED);
	send_server_tcp(packet);
}

if(image_alpha < 1)
	image_alpha += 0.01;