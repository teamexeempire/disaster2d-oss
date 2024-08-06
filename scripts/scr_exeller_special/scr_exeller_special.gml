function scr_exeller_special()
{
	if(won || lost)
	{
		isAttacking = false;
		attackTimer = 0;
	}
	
	if(global.playerControls && isJumping && keyboard_check_pressed(global.KeyA))
		isJumping = false;
	
	if(cloneTimer > 0)
		cloneTimer--;
	
	if(global.playerControls && keyboard_check_pressed(global.KeyC))
	{
		if(keyboard_check(global.KeyUp) && clones[0] != -1)
		{
			if(!instance_exists(obj_exeller_clone))
				return;
			
			with(obj_exeller_clone)
			{
				if(nid != global.player.clones[0])
					continue;
					
				var packet = cpacket_tcp(PacketType.CLIENT_EXELLER_TELEPORT_CLONE, false);
				buffer_write(packet, buffer_u16, nid);
				send_server_tcp(packet);
			}
			
			return;
		}
		
		if(keyboard_check(global.KeyDown) && clones[1] != -1)
		{
			if(!instance_exists(obj_exeller_clone))
				return;
			
			with(obj_exeller_clone)
			{
				if(nid != global.player.clones[1])
					continue;
					
				var packet = cpacket_tcp(PacketType.CLIENT_EXELLER_TELEPORT_CLONE, false);
				buffer_write(packet, buffer_u16, nid);
				send_server_tcp(packet);
			}
			return;
		}
		
		if(!keyboard_check(global.KeyDown) && !keyboard_check(global.KeyUp) && cloneCount < 2 && cloneTimer <= 0)
		{
			var packet = cpacket_tcp(PacketType.CLIENT_EXELLER_SPAWN_CLONE, false);
			buffer_write(packet, buffer_u16, x);
			buffer_write(packet, buffer_u16, y);
			buffer_write(packet, buffer_s8, image_xscale);
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
				var _snd = choose(snd_exeller_cloneline, snd_none, snd_none, snd_none);
				audio_play_sound(_snd, 0, false);
				net_sound_emit(_snd);
			}
			
			cloneTimer = 3 * 60;
		}
	}
	
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