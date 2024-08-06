function scr_amy_special()
{
	if(redRingTimer > 0)
	{
		if(attackTimer <= 2)
			attackTimer = 2;
		
		if(hjumpTimer <= 2)
			hjumpTimer = 2;
			
		isAttacking = false;
	}
	
	if(isHiding)
	{
		if(attackTimer <= 60 * 2)
			attackTimer = 60 * 2;
		
		if(hjumpTimer <= 60 * 2)
			hjumpTimer = 60 * 2;
			
		isAttacking = false;
	}
	
	if(global.playerControls && isLookingDown && keyboard_check_pressed(global.KeyA) && hjumpTimer <= 0)
	{			
		isGrounded = false;
		isSpinning = false;
		isJumping = true;
		justJumped = true;
		xspd -= 10 * sin(angle);
		yspd = -10 * cos(angle);
			
		isHJ = true;
		hjumpTimer = AMY_BIGJUMP_RECHARGE;
		audio_play_sound(snd_jump, 0, false);
		net_sound_emit(snd_jump);
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && attackTimer <= 0)
	{
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		for(var i = 0; i < 4; i++)
			net_quick_effect(global.player.x + 2 + (i * 10) * image_xscale, global.player.y - 4 + irandom_range(-3, 3), global.player.revivalTimes >= 2 ? spr_eroseheart : spr_roseheart, false, 1, 0, -1);
		
		image_index = 0;
		attackTimer = revivalTimes >= 2 ? AMY_EXEATTACK_RECHARGE : AMY_ATTACK_RECHARGE;
		isAttacking = true;
		audio_play_sound(snd_dash, 0, false);
		net_sound_emit(snd_dash);
	}
	
	if(isAttacking)
		gspd = 0;
		
	if(state == AMY_HJUMP && isGrounded)
	{
		state = IDLE;
		isAttacking = false;
	}
	
	if(hjumpTimer > 0 && isGrounded)
		hjumpTimer--;
	
	if(attackTimer > 0)
		attackTimer--;
}