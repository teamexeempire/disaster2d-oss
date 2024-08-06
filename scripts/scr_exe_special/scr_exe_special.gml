function scr_exe_special()
{
	if(won || lost)
	{
		invisTimer = EXE_INVIS_RECHARGE;
		isAttacking = false;
		attackTimer = 0;
	}
	
	if(global.playerControls && isJumping && keyboard_check_pressed(global.KeyA))
		isJumping = false;
	
	if(global.playerControls && keyboard_check_pressed(global.KeyC))
	{
		var play = true;
		for(var i = 46; i < array_length(global.net_snds); i++)
		{
			if(audio_is_playing(global.net_snds[i]))
			{
				play = false;
				break;
			}
		}
			
		if(invisTimer <= EXE_INVIS_RECHARGE)
		{
			if(play)
			{
				var snd = choose(snd_exe_invisenter, snd_exe_invisenter2);
				audio_play_sound(snd, 0, false);
			}
			
			audio_play_sound(snd_exe_appear, 0, false);
			net_sound_emit(snd_exe_appear);
			
			obj_achivements.rExeInvis = true;
			obj_achivements.alarm[6] = 80;
			
			invisTimer = EXE_INVIS_DURATION;
		}
		else if(invisTimer > 0)
			invisTimer = 0;
	}
	
	if(invisTimer == 0)
	{
		audio_play_sound(snd_exe_appear, 0, false);
		net_sound_emit(snd_exe_appear);
		
		obj_achivements.rExeInvis = true;
		obj_achivements.alarm[6] = 80;
	
		var play = true;
		for(var i = 46; i < array_length(global.net_snds); i++)
		{
			if(audio_is_playing(global.net_snds[i]))
			{
				play = false;
				break;
			}
		}
	
		if(play)
		{
			var numb = irandom_range(0, 100);
			if(numb >= 50)
			{
				audio_play_sound(snd_exe_appear2, 0, false);
				net_sound_emit(snd_exe_appear2);
			}
			else
			{
				audio_play_sound(snd_exe_appear3, 0, false);
				net_sound_emit(snd_exe_appear3);
			}
		}
	}
	
	if(invisTimer > EXE_INVIS_RECHARGE)
		invisTimer--;
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && attackTimer <= 0 && invisTimer <= 0)
	{
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		image_index = 0;
		attackSpeed = xspd;
		attackTimer = isGrounded ?  60 : 120;
		isAttacking = true;
		isJumping = false;
		isSpinning = false;
		audio_play_sound(snd_dash, 0, false);
		net_sound_emit(snd_dash);
	}
		
	if(invisTimer > 0)
	{
		isAttacking = false;
		return;
	}
	
	if(isAttacking)
	{
		if(yspd > 0)
			yspd = isGrounded ? 0 : 2.5;
		
		if(isGrounded && abs(xspd) > 0 && floor(x) mod 4 == 0)
			net_quick_effect(x - 8 * sign(image_xscale), y + 20, spr_dust);
	}
	
	if(attackTimer > 0)
		attackTimer--;
}