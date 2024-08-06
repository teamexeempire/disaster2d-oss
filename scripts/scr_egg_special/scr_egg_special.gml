function scr_egg_special()
{
	if(redRingTimer > 0)
	{
		if(djumpRecharge <= 2)
			djumpRecharge = 2;
		
		if(shieldRechrage >= 0 && shieldRechrage <= 2)
			shieldRechrage = 2;
			
		if(trackerRecharge <= 2)
			trackerRecharge = 2;
			
		isAttacking = false;
	}
	
	if(isHiding)
	{
		if(djumpRecharge <= 60 * 2)
			djumpRecharge = 60 * 2;
		
		if(shieldRechrage >= 0 && shieldRechrage <= 60 * 2)
			shieldRechrage = 60 * 2;
			
		if(trackerRecharge <= 60 * 2)
			trackerRecharge = 60 * 2;
			
		isAttacking = false;
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyA) && isJumping && djumpRecharge == 0)
	{
		isJumping = false;
		yspd = -8;
		
		audio_play_sound(snd_egg_djump, 0, false);
		net_sound_emit(snd_egg_djump);
		
		djumpRecharge = -1;
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && shieldRechrage == 0)
	{
		isAttacking = true;
		
		audio_play_sound(snd_egg_shield, 0, false);
		net_sound_emit(snd_egg_shield);
		
		shieldRechrage = -1;
	}
	
	var xx = image_xscale > 0 ? 12 : -12;
	isColliding = isGrounded && !place_meeting(x, y, obj_angleanuller) && position_meeting(x + xx, y+18, obj_floor_parent);
	if(global.playerControls && keyboard_check_pressed(global.KeyC) && trackerRecharge <= 0 && isLookingDown && isColliding)
	{
		audio_play_sound(snd_egg_tracker, 0, false);
		net_sound_emit(snd_egg_tracker);
	
		var pack = cpacket_tcp(PacketType.CLIENT_ETRACKER);
		buffer_write(pack, buffer_u16, x);
		buffer_write(pack, buffer_u16, y + 18);
		send_server_tcp(pack);
		
		trackerRecharge = EGGMAN_TRACKER_RECHARGE;
	}
	
	if(shieldRechrage < 0)
	{
		shieldRechrage--;
		
		if(shieldRechrage <= -(60 * 1.5))
		{
			isAttacking = false;
			shieldRechrage = revivalTimes >= 2 ? EEGGMAN_SHIELD_RECHARGE : EGGMAN_SHIELD_RECHARGE;
		}
	}
	
	if(djumpRecharge < 0)
	{
		djumpRecharge--;
		
		if(djumpRecharge <= -30)
			djumpRecharge = EGGMAN_DJUMP_RECHARGE;
	}
	
	if(djumpRecharge > 0)
		djumpRecharge--;
		
	if(shieldRechrage > 0)
		shieldRechrage--;
		
	if(trackerRecharge > 0)
		trackerRecharge--;
}