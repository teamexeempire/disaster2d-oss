function scr_collision_check_top(_near)
{
	var sens1 = obj_player_sensorTL;
	var sens2 = obj_player_sensorTR;
	
	sens1.x = ceil(x) - 7;
	sens1.y = ceil(y) - 18;
	
	sens2.x = ceil(x) + 7;
	sens2.y = ceil(y) - 18;
	
	var dist1 = 0;
	while(!position_meeting(sens1.x, sens1.y, _near) && dist1 < maxYSpeed+1)
	{
		sens1.y--;
		dist1++;
	}
	
	var dist2 = 0;
	while(!position_meeting(sens2.x, sens2.y, _near) && dist2 < maxYSpeed+1)
	{
		sens2.y--;
		dist2++;
	}
	
	if(dist1 != maxYSpeed+1 && dist2 != maxYSpeed+1)
	{
		if(sens1.y >= sens2.y)
		{
			if(-dist1 >= yspd)
			{
				if(yspd < 0)
				{
					if(!position_meeting(sens1.x, sens1.y, obj_platform_jumptrough))
					{
						y = ceil(sens1.y) + 18;
						yspd = 0;
					}
				}
			}
		}
		else if(sens1.y < sens2.y)
		{
			if(-dist2 >= yspd)
			{
				if(yspd < 0)
				{
					if(!position_meeting(sens2.x, sens2.y, obj_platform_jumptrough))
					{
						y = ceil(sens2.y) + 18;
						yspd = 0;
					}
				}
			}
		}
	}
	else if(dist1 != maxYSpeed+1)
	{
		if(-dist1 >= yspd)
		{
			if(yspd < 0)
			{
				if(!position_meeting(sens1.x, sens1.y, obj_platform_jumptrough))
				{
					y = ceil(sens1.y) + 18;
					yspd = 0;
				}
			}
		}
	}
	else if(dist2 != maxYSpeed+1)
	{
		if(-dist2 >= yspd)
		{
			if(yspd < 0)
			{
				if(!position_meeting(sens2.x, sens2.y, obj_platform_jumptrough))
				{
					y = ceil(sens2.y) + 18;
					yspd = 0;
				}
			}
		}
	}
}

function scr_collision_check(_near)
{
	var sens1 = obj_player_sensorL;
	var sens2 = obj_player_sensorR;
	
	sens1.coll = false;
	sens2.coll = false;
	
	for(var yy = -16; yy < (isGrounded ? 0 : (15-abs(xspd))); yy ++)
	{
		sens1.x = ceil(x) - 8;
		sens1.y = ceil(y+yy);
		sens2.x = ceil(x) + 8;
		sens2.y = ceil(y+yy);
		
		var dist1 = 0;
		var inst1 = instance_position(sens1.x, sens1.y, _near);
		while(inst1 == noone && dist1 < maxHSpeed+1)
		{
			sens1.x--;
			dist1++;
			inst1 = instance_position(sens1.x, sens1.y, _near);
		}
		
		var dist2 = 0;
		var inst2 = instance_position(sens2.x, sens2.y, _near);
		while(inst2 == noone && dist2 < maxHSpeed+1)
		{
			sens2.x++;
			dist2++;
			inst2 = instance_position(sens2.x, sens2.y, _near);
		}
		
		sens1.dist = dist1;
		sens2.dist = dist2;
		
		if(-dist1 >= min(xspd, -1))
		{
			if(!position_meeting(sens1.x, sens1.y, obj_platform_jumptrough))
			{
				sens1.coll = true;
				
				if(xspd < 0)
				{
					x = ceil(sens1.x) + 8;
					xspd = 0;
					gspd = 0;
					isBoosting = false;
					
					if(global.character == CHARACTER_SALLY)
						isSliding = false;
					
					if(global.character == CHARACTER_EXE && global.exeCharacter == 1)
					{
						if(stuckDashTimer <= 0)
						{
							if(attackTimer > 150-15)
								attackTimer = 150-15;
						}
					
						if(inst1.canStuck && stuckTimer <= 0 && state == CHAOS_AIR_ATTACK && dashedIntoPussy > 0)
						{
							canSpin = false;
							stuckTimer = 30;
							dashedIntoPussy = 0;
							stuckDir = -image_xscale;
							
							leftPressed = false;
							rightPressed = false;
							upPressed = false;
							
							if(stuckDir > 0 && keyboard_check(global.KeyRight))
								rightPressed = true;
								
							if(stuckDir < 0 && keyboard_check(global.KeyLeft))
								leftPressed = true;
								
							if(keyboard_check(global.KeyUp))
								upPressed = true;
								
							audio_play_sound(snd_chaos_land, 0, false);
							net_sound_emit(snd_chaos_land);
						}
					}
					
					if(global.character == CHARACTER_KNUX && isGliding && glideTimer > 0)
					{
						if(inst1.canStuck && !isStuck && !isHurt)
						{
							audio_play_sound(snd_snap, 0, false);
							net_sound_emit(snd_snap);
							isStuck = true;
						}
						
						if(isStuck && !isHurt)
						{
							image_xscale = -1;
							yspd = 0;
						}
					}
					
					break;
				}
			}
		}
		
		if(dist2 <= max(xspd, 1))
		{
			if(!position_meeting(sens2.x, sens2.y, obj_platform_jumptrough))
			{
				sens2.coll = true;
				
				if(xspd > 0)
				{
					x = ceil(sens2.x) - 8;
					xspd = 0;
					gspd = 0;
					isBoosting = false;
					
					if(global.character == CHARACTER_SALLY)
						isSliding = false;
						
					if(global.character == CHARACTER_EXE && global.exeCharacter == 1)
					{
						if(stuckDashTimer <= 0)
						{
							if(attackTimer > 150-15)
								attackTimer = 150-15;
						}
					
						if(inst2.canStuck &&  stuckTimer <= 0 && state == CHAOS_AIR_ATTACK && dashedIntoPussy > 0)
						{
							canSpin = false;
							stuckTimer = 30;
							dashedIntoPussy = 0;
							stuckDir = -image_xscale;
							
							leftPressed = false;
							rightPressed = false;
							upPressed = false;
							
							if(stuckDir > 0 && keyboard_check(global.KeyRight))
								rightPressed = true;
								
							if(stuckDir < 0 && keyboard_check(global.KeyLeft))
								leftPressed = true;
							
							if(keyboard_check(global.KeyUp))
								upPressed = true;
								
							audio_play_sound(snd_chaos_land, 0, false);
							net_sound_emit(snd_chaos_land);
						}
					}
					
					if(global.character == CHARACTER_KNUX && isGliding && glideTimer > 0)
					{
						if(inst2.canStuck && !isStuck && !isHurt)
						{
							audio_play_sound(snd_snap, 0, false);
							net_sound_emit(snd_snap);
							isStuck = true;
						}
						
						if(isStuck && !isHurt)
						{
							image_xscale = 1;
							yspd = 0;
						}
					}
					
					break;
				}
			}
		}
	}
}

function scr_collision_check_angle(_near)
{
	var sens1 = obj_player_sensorAL;
	var sens2 = obj_player_sensorAR;
	
	sens1.x = x - 7;
	sens2.x = x + 7;
	sens1.y = y - 16;
	sens2.y = y - 16;
	
	var maxDist = 66;
	var _dist1 = 0;
	var _dist2 = 0;
	
	while(!position_meeting(sens1.x, sens1.y, _near) && _dist1 < maxDist)
	{
		sens1.y++;
		_dist1++;
	}
	
	while(!position_meeting(sens2.x, sens2.y, _near) && _dist2 < maxDist)
	{
		sens2.y++;
		_dist2++;
	}
	
	if(_dist1 != maxDist && _dist2 != maxDist)
	{
		if(global.character == CHARACTER_EXE && (global.player.state == EXE_WON || global.player.state == EXE_LOST))
			angle = 0;
		else
			angle = degtorad(point_direction(-8, _dist1, 8, _dist2));
	}
	else
	{
		angle = 0;
	}
}

function scr_collision_check_bottom(_near)
{
	var sens1 = obj_player_sensorBL;
	var sens2 = obj_player_sensorBR;
	
	sens1.x = ceil(x) - 7;
	sens2.x = ceil(x) + 7;
	sens1.coll = false;
	sens2.coll = false;
	
	// Non-grounded mode
	if(!isGrounded)
	{
		angle = 0;
		sens1.y = ceil(y) - 16;
		sens2.y = ceil(y) - 16;
		
		var dist1 = 0;
		while(!position_meeting(sens1.x, sens1.y, _near) && dist1 < 35)
		{
			sens1.y++;
			dist1++;
		}
		
		var dist2 = 0;
		while(!position_meeting(sens2.x, sens2.y, _near) && dist2 < 35)
		{
			sens2.y++;
			dist2++;
		}
		
		if(dist1 != 35 && dist2 != 35)
		{
			var winner = 0;
			if(sens1.y < sens2.y)
			{
				winner = sens2.y - 18;
				
				if(place_meeting(sens2.x, sens2.y, obj_platform_jumptrough))
				{
					if(yspd > 0 && dist2 >= 15)
					{					
						y = winner;
						isGrounded = true;
						yspd = 0;
						gspd = xspd;
					}
				}
				else
				{
					if(yspd > 0)
					{					
						y = winner;
						isGrounded = true;
						yspd = 0;
						gspd = xspd;
					}
				}
			}
			else if(sens1.y >= sens2.y)
			{
				winner = sens1.y - 18;
				
				if(place_meeting(sens1.x, sens1.y, obj_platform_jumptrough))
				{
					if(yspd > 0 && dist1 >= 15)
					{					
						y = winner;
						isGrounded = true;
						yspd = 0;
						gspd = xspd;
					}
				}
				else
				{
					if(yspd > 0)
					{					
						y = winner;
						isGrounded = true;
						yspd = 0;
						gspd = xspd;
					}
				}
			}
		}
		else if(dist1 != 35)
		{
			winner = sens1.y - 18;
			
			if(place_meeting(sens1.x, sens1.y, obj_platform_jumptrough))
			{
				if(yspd > 0 && dist2 >= 15)
				{					
					y = winner;
					isGrounded = true;
					yspd = 0;
					gspd = xspd;
				}
			}
			else
			{
				if(yspd > 0)
				{					
					y = winner;
					isGrounded = true;
					yspd = 0;
					gspd = xspd;
				}
			}
		}
		else if(dist2 != 35)
		{
			winner = sens2.y - 18;
				
			if(place_meeting(sens2.x, sens2.y, obj_platform_jumptrough))
			{
				if(yspd > 0 && dist2 >= 15)
				{					
					y = winner;
					isGrounded = true;
					yspd = 0;
					gspd = xspd;
				}
			}
			else
			{
				if(yspd > 0)
				{					
					y = winner;
					isGrounded = true;
					yspd = 0;
					gspd = xspd;
				}
			}
		}
	}
	
	if(isGrounded)
	{		
		if(global.character == CHARACTER_EXE && global.exeCharacter == 1 && stuckTimer <= 0 && state == CHAOS_AIR_ATTACK && dashedIntoPussy > 0)
		{	
			canSpin = false;
			stuckTimer = 30;
			dashedIntoPussy = 0;
			stuckDir = image_xscale;
			
			leftPressed = false;
			rightPressed = false;
			upPressed = false;
			
			if(stuckDir > 0 && keyboard_check(global.KeyRight))
				rightPressed = true;
				
			if(stuckDir < 0 && keyboard_check(global.KeyLeft))
				leftPressed = true;
				
			if(keyboard_check(global.KeyUp))
				upPressed = true;
				
			audio_play_sound(snd_chaos_land, 0, false);
			net_sound_emit(snd_chaos_land);
		}
			
		// Reposition
		sens1.y = ceil(y) - 16;
		sens2.y = ceil(y) - 16;
		var maxDist = 48;
		
		if(position_meeting(obj_player_sensorL.x, obj_player_sensorL.y, obj_angleallower))
			maxDist = 38;
			
		if(position_meeting(obj_player_sensorR.x, obj_player_sensorR.y, obj_angleallower))
			maxDist = 38;
		
		var _dist1 = 0;
		while(!position_meeting(sens1.x, sens1.y, _near) && _dist1 < maxDist)
		{
			sens1.y++;
			_dist1++;
		}
		
		var _dist2 = 0;
		while(!position_meeting(sens2.x, sens2.y, _near) && _dist2 < maxDist)
		{
			sens2.y++;
			_dist2++;
		}
		
		if(_dist1 != maxDist || _dist2 != maxDist)
		{			
			var winner = 0;
			
			// Now compare distances
			if(sens1.y == sens2.y)
			{
				sens1.coll = true;
				sens2.coll = true;
			}
			
			if(sens1.y > sens2.y)
			{
				sens2.coll = true;
				winner = sens2.y - 18;
			}
			else
			{
				sens1.coll = true;
				winner = sens1.y - 18;
			}
			
			y = winner;
			scr_collision_check_angle(_near);
			
			if(global.character == CHARACTER_AMY)
				isHJ = false;
		}
		else
		{
			angle = 0;
			isGrounded = false;
		}
	}
}

function scr_collision_basic()
{				
	// Clamp speed and apply Y Velocity
	xspd = clamp(xspd, -maxHSpeed, maxHSpeed);
	yspd = clamp(yspd, -maxYSpeed, maxYSpeed);
	
	if(y - 30 >= room_height)
	{
		var near = instance_nearest(x, y, obj_abyss_target);
		if(near != noone)
		{
			x = near.x;
			y = near.y;
			global.player.xspd = 0;
			global.player.gspd = 0;
			global.player.yspd = 0;
	
			if(global.character == CHARACTER_SALLY)
				global.player.isSliding = false;
	
			if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
				global.player.shockedTimer += 60 * 0.5;
	
			scr_player_hurt(20, 0, 0);
		}
		else
		{
			near = instance_nearest(x, y, obj_deathtp_point);
			if(near != noone)
			{
				x = near.x;
				y = near.y;	
				global.player.xspd = 0;
				global.player.gspd = 0;
				global.player.yspd = 0;
	
				if(global.character == CHARACTER_SALLY)
					global.player.isSliding = false;
	
				if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
					global.player.shockedTimer += 60 * 0.5;
	
				scr_player_hurt(20, 0, 0);
			}
		}
	}
	
    // Apply gravity
	if(!isGrounded)
	{
		if(room == room_torturecave && !obj_netclient.isServerReady)
			return;
			
		yspd += yAccel;
	}
	scr_collision_objects_before();	
	
	var _near = [];
	var _nearbyColl = ds_list_create();
	var _numColl = collision_circle_list(x, y, 80, obj_floor_parent, false, true, _nearbyColl, true);
	
	for(var i = 0; i < _numColl; i++)
		_near[i] = _nearbyColl[| i];
	
	scr_collision_check(_near);
	x += xspd;
	
	scr_collision_check_top(_near);
	y += yspd;
	
	scr_collision_check_bottom(_near);
	
	scr_collision_objects_after();
}