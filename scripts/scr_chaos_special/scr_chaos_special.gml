function scr_chaos_special()
{	
	if(global.playerControls && canMove && isJumping && keyboard_check_pressed(global.KeyA) && !isZipline  && slimeTimer <= 0)
		isJumping = false;
	
	if(global.playerControls && canMove && keyboard_check_pressed(global.KeyB) && !isZipline && stuckDashTimer <= 0 && attackTimer <= 0 && slimeTimer <= 0)
	{
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		if(!isGrounded)
		{
			dashDirX = image_xscale;
			dashDirY = 0;
			isJumping = false;
			
			if(keyboard_check(global.KeyLeft))
				dashDirX = -1;
			else if(keyboard_check(global.KeyRight))
				dashDirX = 1;
				
			if(keyboard_check(global.KeyUp))
				dashDirY = -1;
			else if(keyboard_check(global.KeyDown))
				dashDirY = 1;
			
			dashedIntoPussy = 24;
			effectTime = 20;
			obj_achivements.alarm[5] = 60;
			
			audio_play_sound(snd_chaos_dash, 0, false);
			net_sound_emit(snd_chaos_dash);
		}
		else
		{
			audio_play_sound(snd_chaos_attack, 0, false);
			net_sound_emit(snd_chaos_attack);
		}
		
		image_index = 0;
		attackSpeed = xspd;
		attackTimer = isGrounded ? 90 : 150;
		isAttacking = true;
		isJumping = false;
		isSpinning = false;
	}
	
	if(global.playerControls && canMove && keyboard_check_pressed(global.KeyC) && !isZipline && slimeTimer <= -CHAOS_INVIS_RECHARGE)
	{
		audio_play_sound(snd_chaos_sturn, 0, false);
		net_sound_emit(snd_chaos_sturn);
		
		slimeAnim = false;
		slimeTimer = CHAOS_INVIS_DURATION;
		acc = CHAOS_ACC * 1.5;
		maxHSpeed = CHAOS_MAXSPEED * 1.2;
		
		canLookDown = false;
		canLookUp = false;
		canSpinDash = false;
		canSpin = false;
	}
	
	if(keyboard_check_released(global.KeyRight))
		rightPressed = false;
		
	if(keyboard_check_released(global.KeyLeft))
		leftPressed = false;
		
	if(keyboard_check_released(global.KeyUp))
		upPressed = false;
	
	if(slimeTimer > 0)
	{
		if(slimeTimer <= CHAOS_INVIS_DURATION - 10)
		{
			if(global.playerControls && keyboard_check_pressed(global.KeyC))
				slimeTimer = 0;
		}
		
		if(!isGrounded && effectTime <= 0)
			effectTime = 6;
		
		if(shockedTimer > 0 || won || lost || isZipline)
			slimeTimer = 0;
	}
	
	if(slimeTimer == 0)
	{
		audio_play_sound(snd_chaos_sturn, 0, false);
		net_sound_emit(snd_chaos_sturn);
		
		acc = CHAOS_ACC;
		maxHSpeed = CHAOS_MAXSPEED;
		canLookDown = true;
		canLookUp = true;
		canSpinDash = true;
		canSpin = true;
	}
	
	if(attackTimer > 0 && stuckTimer <= 0)
		attackTimer--;
		
	if(slimeTimer > -CHAOS_INVIS_RECHARGE)
		slimeTimer--;
		
	if(isAttacking)
	{
		if(!isGrounded || stuckDashTimer > 0)
		{
			xspd = dashDirX * 12;
			yspd = dashDirY * 8;
			
			if(attackTimer <= 150-15)
			{
				xspd = dashDirX * 2;
				yspd = dashDirY * 2;
				isAttacking = false;
				effectTime = 0;
			}
			return;
		}
		
		if(yspd > 0)
			yspd = isGrounded ? 0 : 2.5;
		
		if(isGrounded && abs(xspd) > 0 && floor(x) mod 4 == 0)
			net_quick_effect(x - 8 * sign(image_xscale), y + 20, spr_dust);
	}
	
	if(dashedIntoPussy > 0)
		dashedIntoPussy--;
	
	if(stuckTimer > 0)
	{
		if((prevGrounded && !isGrounded) || (!isGrounded && abs(xspd) > 0) || isBoosting || isZipline || isHurt || shockedTimer > 0 || won || lost)
		{
			stuckTimer = 0;
			canMove = true;
			canSpin = true;
			return;
		}
		
		if(isGrounded && abs(xspd) > 0 && floor(x) mod 4 == 0)
			net_quick_effect(x - 8 * sign(image_xscale), y + 20, spr_dust);
			
		canSpin = false;
		canMove = false;
		isJumping = false;
		isAttacking = false;
		isSpinning = false;
		image_xscale = stuckDir;
		
		if(isGrounded)
		{
			gspd -= min(abs(gspd), acc * 8) * sign(gspd); 
			xspd -= min(abs(xspd), acc * 8) * sign(xspd);
			xspd -= 0.225 * sin(angle);
		}
		else
			yspd = 0;
		
		var check = keyboard_check_pressed(global.KeyB);
		var check2 = false;
		var check3 = true;
		
		if(isGrounded && stuckDir > 0 && keyboard_check(global.KeyRight))
			check2 = true;
			
		if(isGrounded && stuckDir < 0 && keyboard_check(global.KeyLeft))
			check2 = true;
			
		if(!isGrounded && keyboard_check(global.KeyUp))
			check2 = true;
		
		if(isGrounded && stuckDir > 0 && rightPressed)
			check3 = false;
			
		if(isGrounded && stuckDir < 0 && leftPressed)
			check3 = false;
			
		if(!isGrounded && upPressed)
			check3 = false;
		
		if(stuckTimer-- >= 30/2 && check && check2 && check3)
		{
			canSpin = true;
			canMove = true;
			dashedIntoPussy = 0;
			stuckDashTimer = 8;
			stuckTimer = 0;
			dashDirX = isGrounded ? image_xscale : 0;
			dashDirY = isGrounded ? 0 : -1.4;
			isJumping = false;
			
			if(!isGrounded)
			{
				image_xscale = -stuckDir;
				attackTimer = 150;
				isAttacking = true;
			}
			
			image_index = 0;
			attackSpeed = xspd;
			isJumping = false;
			isSpinning = false;
			
			effectTime = 20;
			obj_achivements.alarm[5] = 60;
			
			audio_play_sound(snd_chaos_dash, 0, false);
			net_sound_emit(snd_chaos_dash);
		}
		
		if(stuckTimer == 0)
		{
			canMove = true;
			canSpin = true;
		}
	}
	
	if(stuckDashTimer > 0)
	{
		if((prevGrounded && !isGrounded) || isBoosting || isZipline || isHurt || shockedTimer > 0 || won || lost)
		{
			isAttacking = false;
			stuckDashTimer = 0;
			canMove = true;
			return;
		}
		
		if(isGrounded)
		{
			gspd = image_xscale * 12;
			isSpinning = true;
		}
		else
			image_xscale = -stuckDir;
		
		stuckDashTimer--;
		if(stuckDashTimer == 0)
			isAttacking = false;
	}
}