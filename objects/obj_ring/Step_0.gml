if(image_alpha < 1)
	image_alpha += 1 / 30.0;

image_index = global.ringFrame;
	
if(used)
	return;
	
if(visible && image_alpha >= 1 && instance_exists(global.player) && place_meeting(x, y, global.player))
{
	if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
	{
		if(global.character != CHARACTER_TAILS && global.character != CHARACTER_CREAM && global.player.isAttacking)
			ringBreak();
		return;
	}
	
	if(global.player.hp <= 0)
		return;
			
	var packet = cpacket_tcp(PacketType.CLIENT_RING_COLLECTED);
	buffer_write(packet, buffer_u8, iid);
	buffer_write(packet, buffer_u16, nid);
	send_server_tcp(packet);
	used = true;
}

var _inst = instance_place(x, y, obj_tails_projectile);
if(visible && image_alpha >= 1 && _inst != noone && _inst.isOwner && _inst.isExe)
	ringBreak();
	