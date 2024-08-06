function scr_move_basic()
{
	if(!obj_netclient.isServerReady || obj_netclient.sendTimeout > 0)
	{
		scr_collision_basic();
		return;
	}
	
	if(room == room_act9)
		image_blend = c_black;
		
	// fucking hack
	if(room != room_fartzone && !obj_achivements.achivements[21] && rings >= 25)
	{
		obj_achivements.mercoins += 25;
		obj_achivements.save();
		
		obj_achivements.achivements[21] = true;
		obj_achivements.save();
		obj_achivements.show();
	}
	
	//unset just jumped flag
	justJumped = false;
	isLookingDown = false;
	isLookingUp = false;
	
	// If is dead, play dead animation
	if(isDead)
	{
		obj_level.hideFade = 0;
		
		if(redRingTimer > 0)
		{
			audio_stop_sound(mus_mindfuck);
			instance_destroy(obj_redring_screen);
			redRingTimer = 0;
		}
		
		emotion = false;
		isZipline = false;
		isAttacking = false;
		isBoosting = false;
		isHiding = false;
		
		if(global.character == CHARACTER_SALLY)
		{
			isAttacking = false;
			isSliding = false;
			
			if(shieldTimer > 0)
				shieldTimer = 0;
		}
		
		if(global.character == CHARACTER_CREAM)
		{
			dashing = 0;
			ringsSpawn = 0;
		}
		
		gspd -= min(abs(gspd), acc) * sign(gspd); 
		xspd -= min(abs(xspd), acc) * sign(xspd);
		xspd -= 0.225 * sin(angle);
		return;
	}
	
	
	bounceTimer--;
	if(bounceTimer > 0)
	{
		if(isGrounded)
			bounceTimer = -1;
	}
	
	if(bounceTimer == 0)
	{
		if(global.character != CHARACTER_EXE)
		{ 
			isJumping = false;
			isSpinning = false;
		}
		
		if(isGrounded)
		{
			bounceTimer = -1;
		}
	}
	
	// If hurt, play animation
	if(isHurt)
	{
		switch(global.character)
		{
			case CHARACTER_EXE:
				switch(global.exeCharacter)
				{
					case EXE_ORIGINAL:
						isAttacking = false;
						break;
						
					case EXE_CHAOS:
						isAttacking = false;
						if(slimeTimer > 0)
							slimeTimer = 0;
		
						if(stuckTimer > 0)
						{
							canMove = true;
							stuckTimer = 0;
						}
			
						stuckDashTimer = 0;
						break;
						
					case EXE_EXETIOR:
						isAttacking = false;
						isStomping = false;
						break;
						
					case EXE_EXELLER:
						isAttacking = false;
						break;
				}
				break;
				
			case CHARACTER_TAILS:
				attackAfter = 0;
				break;
				
			case CHARACTER_CREAM:
				dashing = 0;
				ringsSpawn = 0;
				break;
			
			case CHARACTER_SALLY:
				isAttacking = false;
				isSliding = false;
				break;
		}
		
		gspd = 0;
		
		if(xspd > -1 && xspd < 1 && isGrounded)
			isHurt = false;
		
		if(xspd > 0)
			xspd -= 0.06;
		else
			xspd += 0.06;
			
		yspd += 0.08;
		isBoosting = false;
		emotion = false;
		return;
	}
	
	if(isBoosting)
	{
		if(effectTime <= 0)
			effectTime = 16;
			
		if(global.character == CHARACTER_KNUX)
		{
			isGliding = false;
			
			if(isStuck)
			{
				canMove = true;
				isStuck = false;
			}
		}
		else if(global.character == CHARACTER_SALLY)
		{
			if(shieldTimer > 0)
				shieldTimer = 0;
		}
		else if(global.character == CHARACTER_EGGMAN)
		{
			if(shieldRechrage < 0)
				shieldRechrage = -(60 * 1.5);
				
			isAttacking = false;
		}
		
		if(global.character == CHARACTER_EXE && global.exeCharacter == EXE_CHAOS)
		{
			stuckTimer = 0;
			stuckDashTimer = 0;
		}
		
		if(isGrounded)
		{
			gspd = 12 * image_xscale;
			gspd -= 0.125 * sin(angle);
			xspd = gspd * cos(angle);
			yspd = gspd * -sin(angle);
		}
		return;
	}
	
	if(global.character > CHARACTER_EXE)
	{
		if(obj_netclient.lvlId != 8 && !isDead && revivalTimes < 2 && global.timeMinutes >= 1)
		{
			if(++chunkTimer % 60 == 0)
			{
				var _newX = x-480/2;
				var _newY = y-270/2;
			
				if(rectangle_in_rectangle(_newX, _newY, _newX + 480, _newY + 270, chunkX, chunkY, chunkX + 480, chunkY + 270) == 0)
				{
					if(instance_exists(obj_player_warning))
						obj_player_warning.moved = true;
				
					chunkX = _newX;
					chunkY = _newY;
					chunkTimer = 0;
				}
			}
		
			if(chunkTimer == 20 * 60)
				instance_create_depth(0, 0, 0, obj_player_warning);
		}
	}
	
	// Balancing
	if(isGrounded && abs(xspd) <= 0 && !(obj_player_sensorBL.coll && obj_player_sensorBR.coll))
	{
		var sensor = obj_player_sensorBL.coll ? obj_player_sensorBL : (obj_player_sensorBR.coll ? obj_player_sensorBR : undefined);
		if(sensor != undefined)
		{
			var _result = false;
			var _dir = 1;
			
			with(sensor)
			{
				if(sensor == obj_player_sensorBR)
				{
					for(var i = -8; i < 8; i++)
					{
						var _met = false;
						for(var j = 0; j < 16; j++)
						{
							if(place_meeting(x + i, y + j, obj_floor_parent))
							{
								_met = true;
								break;
							}
						}
					
						if(_met)
							continue;
					
						_result = true;
						_dir = sign(i);
						break;
					}
				}
				else
				{
					for(var i = 8; i > -8; i--)
					{
						var _met = false;
						for(var j = 0; j < 16; j++)
						{
							if(place_meeting(x + i, y + j, obj_floor_parent))
							{
								_met = true;
								break;
							}
						}
					
						if(_met)
							continue;
					
						_result = true;
						_dir = sign(i);
						break;
					}
				}
			}
			
			isOnEdge = _result;
			edgeDir = _dir >= 0 ? 1 : -1;
		}
	}
	else
		isOnEdge = false;
	
	// Emotions
	if((state != IDLE && state != EMOTION1 && state != EMOTION2 && state != EMOTION3 && ((global.character != CHARACTER_AMY && global.character != CHARACTER_SALLY) || state != 15)) && emotion)
		emotion = false;
		
	if(state == IDLE && keyboard_check_pressed(global.KeyIdle))
	{
		if(global.character == CHARACTER_AMY)
			image_index = 53;
		else
			image_index = 48;
	}
	
	if(global.playerControls && !emotion && !isOnEdge)
	{
		if(keyboard_check_pressed(global.KeyEm1))
		{
			if(state == IDLE)
			{
				if(global.character != CHARACTER_EXE || taunt1)
				{
					image_index = 0;
					state = EMOTION1;
					emotion = true;
				}
			}
			
			var play = true;
			for(var i = 46; i < array_length(global.net_snds); i++)
			{
				if(audio_is_playing(global.net_snds[i]))
				{
					play = false;
					break;
				}
			}
			
			if(global.character == CHARACTER_EXE && play && taunt1)
			{
				switch(global.exeCharacter)
				{
					case EXE_ORIGINAL:
						emotionSnd = audio_play_sound(snd_exe_taunt, 0, false);
						net_sound_emit(snd_exe_taunt);
						break;
						
					case EXE_CHAOS:
						var snd = choose(snd_chaos_pizza, snd_chaos_vineboom);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
						
					case EXE_EXETIOR:
						var snd = choose(snd_exetior_taunt1, snd_exetior_taunt2, snd_exetior_taunt3);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
						
					case EXE_EXELLER:
						emotionSnd = audio_play_sound(snd_exeller_taunt3, 0, false);
						net_sound_emit(snd_exeller_taunt3);
						break;
				}
			}
		}
		else if(keyboard_check_pressed(global.KeyEm2))
		{
			if(state == IDLE)
			{
				if(global.character != CHARACTER_EXE || taunt2)
				{
					image_index = 0;
					state = EMOTION2;
					emotion = true;
				}
			}
			
			var play = true;
			for(var i = 46; i < array_length(global.net_snds); i++)
			{
				if(audio_is_playing(global.net_snds[i]))
				{
					play = false;
					break;
				}
			}
			
			if(global.character == CHARACTER_EXE && play && taunt2)
			{
				switch(global.exeCharacter)
				{
					case EXE_ORIGINAL:
						var snd = choose(snd_exe_taunt, snd_exe_taunt1);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd_exe_taunt);
						break;
						
					case EXE_CHAOS:
						var snd = choose(snd_chaos_taunt, snd_chaos_taunt2);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
						
					case EXE_EXETIOR:
						var snd = choose(snd_exetior_taunt1, snd_exetior_taunt2, snd_exetior_taunt3);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
						
					case EXE_EXELLER:
						var snd = choose(snd_exeller_taunt1, snd_exeller_taunt2);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
				}
			}
		}
		else if(keyboard_check_pressed(global.KeyEm3))
		{
			if(state == IDLE)
			{
				image_index = 0;
				state = EMOTION3;
				emotion = true;
			}
			
			var play = true;
			for(var i = 46; i < array_length(global.net_snds); i++)
			{
				if(audio_is_playing(global.net_snds[i]))
				{
					play = false;
					break;
				}
			}
			
			if(global.character == CHARACTER_EXE && play)
			{		
				switch(global.exeCharacter)
				{
					case EXE_ORIGINAL:
						emotionSnd = audio_play_sound(snd_exe_laugh, 0, false);
						net_sound_emit(snd_exe_laugh);
						break;
												
					case EXE_EXETIOR:
						emotionSnd = audio_play_sound(snd_exetior_laugh, 0, false);
						net_sound_emit(snd_exetior_laugh);
						break;
						
					case EXE_CHAOS:
						var snd = choose(snd_chaos_taunt, snd_chaos_taunt2);
						emotionSnd = audio_play_sound(snd, 0, false);
						net_sound_emit(snd);
						break;
						
					case EXE_EXELLER:
						emotionSnd = audio_play_sound(snd_exeller_laugh, 0, false);
						net_sound_emit(snd_exeller_laugh);
						break;
				}
			}
		}
	}
	
	// Move on ground
	if(isGrounded)
    {			
		isJumping = false //Disable jumping flag
		
		if(global.playerControls && canLookDown && keyboard_check(global.KeyDown))
		{
			if(gspd == 0) //Crouch down
			{
				isLookingDown = true;
				gspd = 0;
			}
			else if(abs(gspd) >= 2 && !isSpinning && canSpin) //Activate spinning
			{
				audio_play_sound(snd_spin, 0, false);
				net_sound_emit(snd_spin);
				isSpinning = true;
			}
		}
	
		//Look up
		if(global.playerControls && canLookUp && keyboard_check(global.KeyUp) && gspd == 0)
		{
			isLookingUp = true;
			gspd = 0;
		}
		
		// Actual movement
		if(!isSpinning)
		{
			if(!isLookingDown && !isLookingUp)
			{
				if(global.playerControls && keyboard_check(global.KeyLeft))
				{
					if(gspd < 0)
						image_xscale = -1;
						
				    if (gspd > 0)
				    {
				        gspd -= 0.5;
				        if (gspd <= 0)
				            gspd = -0.5;
				    }
				    else if (gspd > -maxHSpeed)
				    {
				        gspd -= acc;
				        if (gspd <= -maxHSpeed)
				            gspd = -maxHSpeed;
				    }
				}
				else if (global.playerControls && keyboard_check(global.KeyRight))
				{
					if(gspd > 0)
						image_xscale = 1;
						
				    if (gspd < 0)
				    {
				        gspd += 0.5;
				        if (gspd >= 0)
				            gspd = 0.5;
				    }
				    else if (gspd < maxHSpeed)
				    {
				        gspd += acc;
				        if (gspd >= maxHSpeed)
				            gspd = maxHSpeed;
				    }
				}
				else
				{
					// Deceleration
					gspd -= min(abs(gspd), acc) * sign(gspd); 
				}
			}
		}
		else //Spinning (rolling)
		{
			if(global.playerControls && keyboard_check(global.KeyLeft) && gspd > 0)
			{
				gspd -= 0.125;
				
				if(gspd <= 0)
					isSpinning = false;
			}
			else if(global.playerControls && keyboard_check(global.KeyRight) && gspd < 0)
			{
				gspd += 0.125;
				
				if(gspd >= 0)
					isSpinning = false;
			}
			
			gspd -= min(abs(gspd), 0.0234375) * sign(gspd);
		}
		
		// So some shit when spinnin
		if(!isSpinning)
		{			
			// so that player couldnt go up big slopes
			gspd -= 0.125 * sin(angle);
			xspd = gspd * cos(angle);
			yspd = gspd * -sin(angle);
		}
		else
		{
			// when spinning its smaller so that player could go up slopes easier and gain speed downhill
			gspd -= 0.225 * sin(angle);
			xspd = gspd * cos(angle);
			yspd = gspd * -sin(angle);
		}
		
		if(gspd == 0)
			isSpinning = false;
	}
	
	specialFunc(); //Call special function so that character can do custom abilities
	
	// In Air
	if(!isGrounded)
	{
		angle = 0; //Always reset angle in air
		
		if(global.playerControls) // Deccelerate when in air
		{
			if(keyboard_check(global.KeyLeft))
			{
				image_xscale = -1;
				xspd -= acc * 2;
			}
			else if(keyboard_check(global.KeyRight))
			{
				image_xscale = 1;
				xspd += acc * 2;
			}
		}	
		
		if (yspd < 0 && yspd > -4) // Apply friction
		{
			if(abs(xspd) > 0)
			{
				var d = ceil(xspd / 0.125);
				xspd -= (d / 256);
			}
		}
	}
	else
	{
		// Jump
		if(global.playerControls && keyboard_check_pressed(global.KeyA) && !isJumping)
		{
			if(global.character == CHARACTER_EXE || global.character == CHARACTER_KNUX || global.character == CHARACTER_AMY)
			{
				if(isAttacking)
					return;
			}
			
			if(global.character == CHARACTER_CREAM && ringsSpawn > 0)
				return;
			
			audio_play_sound(snd_jump, 0, false);
			net_sound_emit(snd_jump);
			isGrounded = false;
			isSpinning = false;
			isJumping = true;
			justJumped = true;
			image_index = 0;
			xspd -= jumpForce * sin(angle);
			yspd = -jumpForce * cos(angle);
		}
	}
}