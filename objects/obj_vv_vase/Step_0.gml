var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!instance_exists(global.player))
	return;

if(!visible)
{
	if(!audio_is_playing(sndid))
		instance_destroy();
	return;
}

if(place_meeting(x, y, global.player))
{
	var ch = global.character;
	var isAttacking = false;
	
	if(global.player.isAttacking && (ch == CHARACTER_AMY || ch == CHARACTER_KNUX || ch == CHARACTER_EGGMAN || ch == CHARACTER_SALLY))
		isAttacking = true;	
		
	if(ch == CHARACTER_AMY && global.player.state == AMY_HJUMP)
		isAttacking = true;
	
	if(global.player.isSpinning)
		 isAttacking = true;
		 
	if(!global.player.isGrounded && global.player.yspd > 0)
		 isAttacking = true;
		
	if(global.player.state == SALLY_SLIDE && ch == CHARACTER_SALLY)
		 isAttacking = true;
	
	if(global.player.revivalTimes >= 2 || ch == CHARACTER_EXE)
		isAttacking = false;
	
	if(isAttacking)
	{
		scr_camera_shake(25, 1, 0.2);
		
		var packet = cpacket_tcp(PacketType.CLIENT_VVVASE_BREAK, false);
		buffer_write(packet, buffer_u8, nid);
		send_server_tcp(packet);
	}
}