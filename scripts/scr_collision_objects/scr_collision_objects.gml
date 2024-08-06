function scr_collision_objects_before()
{
	if(isDead)
		return;
		
	if(instance_exists(obj_nap_iceblock))
	{
		with(obj_nap_iceblock)
		{
			if(global.player.y + 19 > bbox_top && (position_meeting(obj_player_sensorBL.x, obj_player_sensorBL.y+2+global.player.yspd, self) || position_meeting(obj_player_sensorBR.x, obj_player_sensorBR.y+2+global.player.yspd, self)))
			{
				global.player.yspd = -5;
				global.player.isJumping = true;
				global.player.isGrounded = false;
				
				var pack = cpacket_tcp(PacketType.CLIENT_NAPICE_ACTIVATE);
				buffer_write(pack, buffer_u8, nid);
				send_server_tcp(pack);
			}
			
			if(global.player.isAttacking && place_meeting(x, y, global.player))
			{
				var pack = cpacket_tcp(PacketType.CLIENT_NAPICE_ACTIVATE);
				buffer_write(pack, buffer_u8, nid);
				send_server_tcp(pack);
			}
		}
	}
}

function scr_collision_objects_after()
{
	if(isDead)
		return;
	
	{
		var spring = instance_position(obj_player_sensorBL.x, obj_player_sensorBL.y, obj_spring_parent);
		
		if(spring == noone)
			spring = instance_position(obj_player_sensorBR.x, obj_player_sensorBR.y, obj_spring_parent);
		
		if(spring != noone && spring.image_blend == c_white && global.player.yspd > 0 && global.player.shockedTimer <= 0)
		{
			if(isHurt)
				isHurt = false;
			
			switch(global.character)
			{
				case CHARACTER_EXE:
					if(isAttacking)
					{
						attackTimer = isGrounded ?  60 : 120;
						isAttacking = false;
					}
					
					if(global.exeCharacter == EXE_CHAOS)
					{
						if(stuckTimer > 0)
						{
							canSpin = true;
							canMove = true;
							stuckTimer = 0;
						}
					}
					break;
					
				case CHARACTER_TAILS:
					if(isFlying)
					{
						flyTimer = 0;
						isFlying = false;
					}
					break;
					
				case CHARACTER_CREAM:
					if(isFlying)
					{
						flyTimer = CREAM_FLY_RECHARGE;
						isFlying = false;
					}
					break;
					
				case CHARACTER_KNUX:
					if(isGliding)
					{
						glideTimer = KNUX_GLIDE_RECHARGE;
						isGliding = false;
						
						if(isStuck)
						{
							canMove = true;
							isStuck = false;
						}
					}
					
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? KNUX_EXEATTACK_RECHARGE : KNUX_ATTACK_RECHARGE;
						isAttacking = false;
					}
					break;
					
				case CHARACTER_AMY:
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? AMY_EXEATTACK_RECHARGE : AMY_ATTACK_RECHARGE;
						isAttacking = false;
					}
					isJumping = true;
					break;
					
					
				case CHARACTER_SALLY:
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? SALLY_EATTACK_RECHARGE : SALLY_ATTACK_RECHARGE;
						isAttacking = false;
					}
					
					if(isSliding)
					{
						slideSpeed = 0;
						isSliding = false;
					}
					isJumping = true;
					break;
					
				case CHARACTER_EGGMAN:
					isJumping = true;
					break;
			}
			
			xspd = spring.xdir;
			yspd = spring.ydir;
			isBoosting = false;
			isSpinning = false;
			isGrounded = false;
			isJumping = false;
			spring.image_index = 1;
			spring.image_blend = c_grey;
			spring.alarm[0] = 60 * .5;
			spring.alarm[1] = 60 * 4;
			audio_play_sound(snd_spring, 0, false);
			net_sound_emit(snd_spring);
			
			if(room == room_hideandseek2 && global.player.revivalTimes < 2)
			{
				var pak = cpacket_tcp(PacketType.CLIENT_SPRING_USE, true);
				buffer_write(pak, buffer_u16, obj_netclient.nid);
				buffer_write(pak, buffer_u16, global.player.x);
				buffer_write(pak, buffer_u16, global.player.y);
				send_server_tcp(pak);
			}
		}
	}
	
	{
		var spring = instance_position(obj_player_sensorBL.x, obj_player_sensorBL.y, obj_hd_spring);
		
		if(spring == noone)
			spring = instance_position(obj_player_sensorBR.x, obj_player_sensorBR.y, obj_hd_spring);
		
		if(spring != noone && spring.image_blend == c_white && global.player.yspd > 0 && global.player.shockedTimer <= 0)
		{
			if(isHurt)
				isHurt = false;
			
			switch(global.character)
			{
				case CHARACTER_EXE:
					if(isAttacking)
					{
						attackTimer = isGrounded ?  60 : 120;
						isAttacking = false;
					}
					
					if(global.exeCharacter == EXE_CHAOS)
					{
						if(stuckTimer > 0)
						{
							canSpin = true;
							canMove = true;
							stuckTimer = 0;
						}
					}
					break;
					
				case CHARACTER_TAILS:
					if(isFlying)
					{
						flyTimer = 0;
						isFlying = false;
					}
					break;
					
				case CHARACTER_CREAM:
					if(isFlying)
					{
						flyTimer = CREAM_FLY_RECHARGE;
						isFlying = false;
					}
					break;
					
				case CHARACTER_KNUX:
					if(isGliding)
					{
						glideTimer = KNUX_GLIDE_RECHARGE;
						isGliding = false;
						
						if(isStuck)
						{
							canMove = true;
							isStuck = false;
						}
					}
					
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? KNUX_EXEATTACK_RECHARGE : KNUX_ATTACK_RECHARGE;
						isAttacking = false;
					}
					break;
					
				case CHARACTER_AMY:
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? AMY_EXEATTACK_RECHARGE : AMY_ATTACK_RECHARGE;
						isAttacking = false;
					}
					isJumping = true;
					break;
					
					
				case CHARACTER_SALLY:
					if(isAttacking)
					{
						attackTimer = revivalTimes >= 2 ? SALLY_EATTACK_RECHARGE : SALLY_ATTACK_RECHARGE;
						isAttacking = false;
					}
					
					if(isSliding)
					{
						slideSpeed = 0;
						isSliding = false;
					}
					isJumping = true;
					break;
					
				case CHARACTER_EGGMAN:
					isJumping = true;
					break;
			}
			
			xspd = 0;
			yspd = (keyboard_check(global.KeyA) || keyboard_check(global.KeyUp)) ? -12 : -10;
			isBoosting = false;
			isSpinning = false;
			isGrounded = false;
			isJumping = false;
			spring.image_index = 1;
			spring.image_blend = c_grey;
			spring.alarm[0] = 60 * .5;
			spring.alarm[1] = 60 * 4;
			audio_play_sound(snd_spring, 0, false);
			net_sound_emit(snd_spring);
		}
	}
	
	// Damage
	if(collision_rectangle(x - 12, y + yspd, x + 12, y + 20, obj_damage, false, true))
	{
		angle = 0;
		scr_player_hurt(20, -global.player.image_xscale * 4, -6, snd_spike, spr_blood1);
	}
	
	// Spikes
	if(collision_rectangle(x - 6, y + 19, x + 6, y + 20, obj_spike, false, true))
	{
		angle = 0;
		scr_player_hurt(20, -global.player.image_xscale * 4, -6, snd_spike, spr_blood1);
	}
	
	// Boob box
	var inst = collision_rectangle(x - 6, y - 20, x + 6, y + 20, obj_kaf_speedboobster, false, true);
	if(inst != noone && !inst.isBroken && inst.image_index == 0)
	{
		var _isAttacking = false;
		var ch = global.character;
	
		if(global.player.isAttacking && (ch == CHARACTER_EXE || ch == CHARACTER_AMY || ch == CHARACTER_KNUX || ch == CHARACTER_EGGMAN || ch == CHARACTER_SALLY))
			_isAttacking = true;
				
		if(ch == CHARACTER_AMY && global.player.state == AMY_HJUMP)
			_isAttacking = true;
		
		if(global.player.isJumping || global.player.state == FALL && ch == CHARACTER_AMY)
			 _isAttacking = true;
		
		if(global.player.isSpinning)
			 _isAttacking = true;
			
		if(global.player.state == SALLY_SLIDE && ch == CHARACTER_SALLY)
			 _isAttacking = true;
			 
		if(global.character == CHARACTER_EXE && global.player.invisTimer > 0)
			_isAttacking = false;
		
		if(_isAttacking || isBoosting)
		{
			inst.isBroken = true;
			
			var pack = cpacket_tcp(PacketType.CLIENT_KAFMONITOR_ACTIVATE);
			buffer_write(pack, buffer_u8, inst.nid);
			buffer_write(pack, buffer_bool, false);
			send_server_tcp(pack);
		}
	}
	
	if(instance_exists(obj_movingspike))
	{
		if(obj_movingspike.image_index > 0 && obj_movingspike.image_index < 5 && collision_rectangle(x - 6, y + 19, x + 6, y + 20, obj_movingspike, false, true))
		{
			angle = 0;
			scr_player_hurt(20, -global.player.image_xscale * 4, -6, snd_spike, spr_blood1);
		}
	}
	
	if(position_meeting(obj_player_sensorL.x, obj_player_sensorL.y, obj_angleanuller) || place_meeting(obj_player_sensorL.x, obj_player_sensorL.y, obj_angleanuller_eggsafe))
		angle = 0;
	
	if(position_meeting(obj_player_sensorR.x, obj_player_sensorR.y, obj_angleanuller) || place_meeting(obj_player_sensorR.x, obj_player_sensorR.y, obj_angleanuller_eggsafe))
		angle = 0;
	
	// Hide
	{
		isHiding = place_meeting(x, y, obj_hiding_parent) && isLookingDown && !isLookingUp;
		
		if(global.character == CHARACTER_SALLY && global.player.isSliding)
			isHiding = false;
		
		if(isHiding)
			obj_camera.look_timer = 0;
	}
	
	var inst = instance_place(x, y, obj_quickeffect);
	if(inst != noone)
	{
		if(global.character == CHARACTER_EXE || global.character == CHARACTER_SALLY)
			return;
			
		if(instance_exists(global.player) && global.player.revivalTimes >= 2)
			return;
			
		if(global.player.hurttime > 0)
			return;
			
		if(inst.sprite_index == spr_shieldbreak2)
		{
			scr_player_hurt(20, -global.player.image_xscale * 3);
			
			if(instance_exists(obj_player_puppet))
			{
				with(obj_player_puppet)
				{
					if(character != CHARACTER_SALLY)
						continue;
										
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 5);
					send_server_tcp(pak);
					
					var buffer = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
					buffer_write(buffer, buffer_u8, 2);
					buffer_write(buffer, buffer_u16, master_id);
					buffer_write(buffer, buffer_u16, 20);
					buffer_write(buffer, buffer_u16, global.player.hp);
					send_server_tcp(buffer);
					break;
				}
			}
		}
	}
}