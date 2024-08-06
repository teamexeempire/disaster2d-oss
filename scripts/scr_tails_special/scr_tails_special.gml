function scr_tails_special()
{
	if(redRingTimer > 0)
	{
		if(attackTimer <= 2)
			attackTimer = 2;
		
		if(flyTimer <= -420 + 2)
			flyTimer = -420 + 2;
	}
	
	if(isHiding)
	{
		if(attackTimer <= 2 * 60)
			attackTimer = 2 * 60;
		
		if(flyTimer <= -420 + 2 * 60)
			flyTimer = -420 + 2 * 60;
	}
	
	if(global.playerControls && !isGrounded && keyboard_check_pressed(global.KeyA) && (attackCharge <= 0 && attackAfter <= 0))
	{
		if(!isFlying && flyTimer <= -420)
		{
			audio_play_sound(snd_tails_fly, 0, false);
			net_sound_emit(snd_tails_fly);
			
			flyTimer = 160;
			isFlying = true;
		}
		
		if(isFlying)
		{
			if(flyTimer > 0)
				flyGrv = -1;
			else
				isFlying = false;
				
			isJumping = false;
			if(abs(xspd) > 0)
				image_xscale = sign(xspd);
		}
	}
	
	if(isFlying)
	{
		isSpinning = false;
			
		if(flyGrv < 2)
		{
			flyGrv += 0.035;
		}
		
		if(flyTimer <= 0)
			isFlying = false;
			
		yspd = flyGrv;
	}
	
	if(flyTimer > 0 && flyTimer mod 18 == 0)
	{
		audio_play_sound(snd_tails_fly, 0, false);
		net_sound_emit(snd_tails_fly);
	}
		
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && attackTimer == 0 && attackCharge == 0)
	{
		audio_play_sound(snd_tails_charge, 0, false);
		net_sound_emit(snd_tails_charge);
		
		var pack = cpacket_tcp(PacketType.CLIENT_TPROJECTILE_STARTCHARGE);
		send_server_tcp(pack);
		
		attackTimer = revivalTimes >= 2 ? ETAILS_ATTACK_RECHARGE : TAILS_ATTACK_RECHARGE;
		attackCharge = 1;
	}
	
	if(attackCharge > 0)
	{
		emotion = false;
		attackTimer = revivalTimes >= 2 ? ETAILS_ATTACK_RECHARGE : TAILS_ATTACK_RECHARGE;
		attackCharge++;
		isJumping = false;
		isFlying = false;
		xspd = 0;
		gspd = 0;
		canMove = false;
		isFlying = false;
		
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		attackKDir = image_xscale;
		
		if(attackCharge >= 60 * 3.5 || !global.playerControls || isZipline || isHurt || isDead || shockedTimer > 0 || !keyboard_check(global.KeyB))
		{
			audio_stop_sound(snd_tails_charge);
			
			var val = floor((((attackCharge / 60)) / 3.5) * 100);
			if(revivalTimes >= 2)
			{
				var dmg = 20;
				
				if(attackCharge >= 84 && attackCharge < 126)
					dmg = 40;
						
				if(attackCharge >= 126)
					dmg =  60;
				
				net_tails_spawn_projectile(x, y, image_xscale, dmg, true, ceil(val / 20.0));
			}
			else
				net_tails_spawn_projectile(x, y, image_xscale, 1 + floor(attackCharge / 42), false, ceil(val / 20.0));
			
			scr_camera_shake(25, 1.2, 0.1);
			audio_play_sound(snd_tails_shoot, 0, false);
			net_sound_emit(snd_tails_shoot);
			
			if(attackCharge < 84)
			{
				attackAfter = 60 * 0.4;
				recoil = -attackKDir * 2;
			}
			else if(attackCharge >= 84 && attackCharge < 126)
			{
				attackAfter = 60 * 0.5;
				recoil = -attackKDir * 4;
			}
			else if(attackCharge >= 126)
			{
				attackAfter = 60 * 0.6;
				recoil = -attackKDir * 6;
			}
		}
		
		if(isHurt || hp <= 0 || isDead || shockedTimer > 0 || isZipline)
		{
			isJumping = false;
			isFlying = false;
			isSpinning = false;
			canMove = true;
			attackCharge = 0;
			attackAfter = 0;
		}
	}
	
	if(attackAfter > 0)
	{
		if(isHurt || hp <= 0 || isDead || shockedTimer > 0 || isZipline)
		{
			isJumping = false;
			isFlying = false;
			isSpinning = false;
			canMove = true;
			attackAfter = 0;
			attackCharge = 0;
		}
		canSpin = false;
		
		attackAfter--;
		attackCharge = 0;
		isJumping = false;
		isFlying = false;
		isSpinning = false;
		canMove = true;
		
		xspd = recoil;
		gspd = recoil;
		recoil -= min(abs(recoil), acc * 3) * sign(recoil);
	}
	else
		canSpin = true;
	
	if(attackTimer > 0)
		attackTimer--;
	
	if(isGrounded)
	{
		if(isFlying)
		{
			isFlying = false;
			flyTimer = 0;
		}
		
		if(flyTimer > -420)
			flyTimer --;
	}
	else 
		if(flyTimer > 0)
			flyTimer --;
}