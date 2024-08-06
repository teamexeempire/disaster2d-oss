function scr_sally_special()
{	
	if(redRingTimer > 0)
	{
		if(shieldRechrage <= 2)
			shieldRechrage = 2;
			
		if(attackTimer <= 2)
			attackTimer = 2;
			
		isAttacking = false;
	}
	
	if(isHiding)
	{
		if(attackTimer <= 60 * 2)
			attackTimer = 60 * 2;
			
		if(shieldRechrage <= 60 * 2)
			shieldRechrage = 60 * 2;
			
		isAttacking = false;
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && !isGrounded && attackTimer <= 0)
	{
		audio_play_sound(snd_dash, 0, false);
		net_sound_emit(snd_dash);
		
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		image_index = 0;
		image_speed = 0;
		isJumping = false;
		isAttacking = true;
		attackTimer = revivalTimes >= 2 ? SALLY_EATTACK_RECHARGE : SALLY_ATTACK_RECHARGE;		
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyC) && shieldRechrage <= 0)
	{
		audio_play_sound(snd_sally_shield, 0, false);
		net_sound_emit(snd_sally_shield);
		
		shieldTimer = 5 * 60;
		shieldRechrage = revivalTimes >= 2 ? SALLY_ESHIELD_RECHARGE : SALLY_SHIELD_RECHARGE;
	}
	
	if(global.playerControls && abs(xspd) >= 2.5 && keyboard_check_pressed(global.KeyDown) && isGrounded && !isSliding)
	{
		audio_play_sound(snd_sally_slide, 0, false);
		net_sound_emit(snd_sally_slide);
		
		isAttacking = false;
		isSliding = true;
		slideSpeed = xspd + 2 * sign(xspd);
	}
	
	if(shieldRechrage > 0)
		shieldRechrage--;
		
	if(attackTimer > 0)
		attackTimer--;
		
	if(shieldTimer > 0)
	{
		shieldTimer--;
		if(shieldTimer <= 0 && revivalTimes >= 2)
		{
			audio_play_sound(snd_sally_shieldbreak, 0, false);
			net_quick_effect(global.player.x, global.player.y, global.player.revivalTimes >= 2 ? spr_shieldbreak2 : spr_shieldbreak, false, 1, 0, 0, 1);
			net_sound_emit(snd_sally_shieldbreak);
		}
		
		shieldRechrage = revivalTimes >= 2 ? SALLY_ESHIELD_RECHARGE : SALLY_SHIELD_RECHARGE;
	}
	
	if(isSliding)
	{
		if(shockedTimer > 0)
		{
			isSliding = false;
			return;
		}
		
		if(!isGrounded)
		{
			isSliding = false;
			return;
		}
		
		if(x <= 1 || x >= room_width - 1)
		{
			isSliding = false;
			return;
		}
		
		if(abs(slideSpeed) > 0)
		{
			slideSpeed -= min(abs(slideSpeed), acc * 2.5) * sign(slideSpeed) * cos(angle);
		}
		else
		{
			isSliding = false;
			return;
		}
		
		if(floor(x) % 5 == 0)
		{
			net_quick_effect(global.player.x - 8 * sign(slideSpeed), global.player.y + 20, spr_dust);
			audio_play_sound(snd_sally_slide, 0, false);
		}
		
		gspd = 0;
		xspd = slideSpeed * cos(angle);
		yspd = slideSpeed * -sin(angle);
	}
}