var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!shouldFade && image_alpha < 1)
	image_alpha += 0.016;

if(shouldFade && image_alpha > 0)
	image_alpha -= 0.016;
	
if(image_alpha < 1)
	return;
	
if(!instance_exists(global.player))
	return;
	
if(global.player.hp <= 0)
	return;
		
if(place_meeting(x, y, global.player) && !activated)
{
	var pack = cpacket_tcp(PacketType.CLIENT_PFLIT_ACTIVATE, false);
	buffer_write(pack, buffer_u8, nid);
	send_server_tcp(pack);
	
	activated = true;
}

if(obj_netclient.nid == pid)
{
	global.player.x = x;
	global.player.y = y-16;
	global.player.xspd = 0;
	global.player.yspd = 0;
	global.player.state = HURT;
	global.player.isHurt = false;
	global.player.isFlying = false;
	global.player.isSpinning = false;
	global.player.isJumping = false;
	global.player.isGrounded = false;
	global.player.isStomping = false;
	global.player.isAttacking = false;
	global.player.canMove = true;
}