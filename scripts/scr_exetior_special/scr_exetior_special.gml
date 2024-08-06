function scr_exetior_special()
{
	if(global.playerControls && isJumping && keyboard_check_pressed(global.KeyA))
		isJumping = false;
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && !isZipline && attackTimer <= 0)
	{
		if(keyboard_check(global.KeyLeft))
			image_xscale = -1;
		else if(keyboard_check(global.KeyRight))
			image_xscale = 1;
			
		if(!isGrounded)
		{
			if(keyboard_check(global.KeyDown))
			{
				image_index = 0;
				isAttacking = true;
				isJumping = false;
				isSpinning = false;
				isStomping = true;
				justLanded = false;
				
				audio_play_sound(snd_exetior_stomp, 0, false);
				net_sound_emit(snd_exetior_stomp);
			}
			else
			{
				image_index = 0;
				attackSpeed = xspd;
				attackTimer = 180;
				isAttacking = true;
				isJumping = false;
				isSpinning = false;
				
				audio_play_sound(snd_dash, 0, false);
				net_sound_emit(snd_dash);
			}
		}
		else
		{	
			image_index = 0;
			attackSpeed = xspd;
			attackTimer =  60;
			isAttacking = true;
			isJumping = false;
			isSpinning = false;
			
			audio_play_sound(snd_dash, 0, false);
			net_sound_emit(snd_dash);
		}
	}
	
	canSpawnRings = !instance_exists(obj_blackring) || distance_to_object(obj_blackring) >= 100;
	if(global.playerControls && keyboard_check_pressed(global.KeyC) && bringTimer <= 0 && canSpawnRings)
	{
		var packet = cpacket_tcp(PacketType.CLIENT_ERECTOR_BRING_SPAWN);
		buffer_write(packet, buffer_u16, x-15);
		buffer_write(packet, buffer_u16, y-15);
		send_server_tcp(packet);
		
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
			var _snd = choose(snd_exetior_ring1, snd_exetior_ring2, snd_exetior_ring3, snd_exetior_ring4);
			audio_play_sound(_snd, 0, false);
			net_sound_emit(_snd);
		}
		
		audio_play_sound(snd_blackring, 0, false);
		net_sound_emit(snd_blackring);
				
		obj_exetior_indicator.showTimer = 7 * 60;
		
		bringTimer = EXETIOR_BRING_RECHARGE;
	}
	
	if(bringTimer > 0)
		bringTimer--;
	
	if(isAttacking)
	{		
		if(isGrounded && abs(xspd) > 0 && floor(x) mod 4 == 0)
			net_quick_effect(x - 8 * sign(image_xscale), y + 20, spr_dust);
			
		if(yspd > 0)
			yspd = isGrounded ? 0 : 2.5;
	}
	
	if(attackTimer > 0)
		attackTimer--;
	
	if(isStomping)
	{
		attackTimer = 240;
		
		if(isZipline || isHurt || shockedTimer > 0 || won || lost)
		{
			isAttacking = false;
			isStomping = false;
			canMove = true;
			return;
		}
			
		if(!isGrounded)
		{
			if(effectTime <= 0)
				effectTime = 6;
				
			scr_camera_shake(10, 0.2, 0.01);
			
			isAttacking = true;
			xspd = 0;
			yspd = 12;
			canMove = false;
		}
		else
		{
			if(!justLanded)
			{
				audio_play_sound(snd_exetior_stompland, 0, false);
				net_sound_emit(snd_exetior_stompland);
				
				var packet = cpacket_tcp(PacketType.CLIENT_ERECTOR_BALLS, false);
				buffer_write(packet, buffer_f32, x);
				buffer_write(packet, buffer_f32, y);
				send_server_tcp(packet);
				
				justLanded = true;
			}
			
			scr_camera_shake(25, 1, 0.2);
			
			isAttacking = false;
			xspd = 0;			
			yspd = 0;
			canMove = false;
		}
	}
}