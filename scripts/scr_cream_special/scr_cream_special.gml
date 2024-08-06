function scr_cream_special()
{
	if(redRingTimer > 0)
	{
		if(flyTimer <= 2)
			flyTimer = 2;
		
		if(dashTimer <= 2)
			dashTimer = 2;
			
		if(ringsTimer <= 2)
			ringsTimer = 2;
			
		ringsSpawn = 0;
	}
	
	if(isHiding)
	{
		if(flyTimer <= 60 * 2)
			flyTimer = 60 * 2;
		
		if(dashTimer <= 60 * 2)
			dashTimer = 60 * 2;
			
		if(ringsTimer <= 60 * 2)
			ringsTimer = 60 * 2;
			
		ringsSpawn = 0;
	}
	
	if(global.playerControls && isJumping && !justJumped && keyboard_check_pressed(global.KeyA) && flyTimer <= 0)
	{
		flyTimeout = 0;
		isFlying = true;
		isJumping = false;
		isSpinning = false;
		flyTimer = CREAM_FLY_RECHARGE;
	}
	
	if(global.playerControls && keyboard_check_pressed(global.KeyB) && dashTimer <= 0 && abs(xspd) > 0 && ringsSpawn <= 0)
	{
		dashing = .5 * 60;
		effectTime = .5 * 60;
		dashTimer = CREAM_DASH_RECHARGE;
		maxHSpeed = 13;
				
		audio_play_sound(snd_creamdash, 0, false);
		net_sound_emit(snd_creamdash);
	}
	
	isColliding = place_meeting(x, y, obj_angleanuller) || collision_circle(x - 12 + (image_xscale < 0 ? 7 : 0), y-16, 32, obj_floor_parent, true, true);
	
	if(revivalTimes >= 2 && instance_exists(obj_redring) && distance_to_object(obj_redring) < 130)
		isColliding = true;
	
	if(global.playerControls && keyboard_check_pressed(global.KeyC) && ringsTimer <= 0 && isGrounded)
	{
		if(!isColliding)
		{
			ringsTimer = revivalTimes >= 2 ? ECREAM_RINGS_RECHARGE : CREAM_RINGS_RECHARGE;
			ringsSpawn = 60;
		}	
	}
	
	if(ringsSpawn > 1)
	{
		if(!isGrounded || !global.playerControls)
		{
			ringsTimer = global.player.revivalTimes >= 2 ? ECREAM_RINGS_RECHARGE : CREAM_RINGS_RECHARGE;
			ringsSpawn = 0;
		}
		
		gspd = 0;
		xspd = 0;
		yspd = 0;
		ringsSpawn--;
	}
	else if(ringsSpawn == 1)
	{
		if(!collision_circle(x - 12 + (image_xscale < 0 ? 7 : 0), y-16, 32, obj_floor_parent, true, true))
		{
			audio_play_sound(snd_creamring, 0, false);
			net_sound_emit(snd_creamring);
		
			var pk = cpacket_tcp(PacketType.CLIENT_CREAM_SPAWN_RINGS, false);
			buffer_write(pk, buffer_u16, x - 12 + (image_xscale < 0 ? 7 : 0));
			buffer_write(pk, buffer_u16, y - 16);
			buffer_write(pk, buffer_bool, revivalTimes >= 2);
			send_server_tcp(pk);
		}
		
		ringsSpawn = 0;
	}
	
	if(isFlying)
	{
		yspd = 1;
		
		flyTimeout++;
		if(flyTimeout > 60 * 2)
			isFlying = false;
		
		if(isGrounded)
			isFlying = false;
	}
	
	if(dashing > 0)
	{
		if(isJumping)
			isJumping = false;
			
		acc = .8;
		dashing--;
	} 
	else 
	{
		if(isSlow)
		{ 
			maxHSpeed = (CREAM_MAXSPEED * (100-30)) / 100;
			acc = (CREAM_ACC * (100-30)) / 100;
		}
		else
		{
			maxHSpeed = CREAM_MAXSPEED;
			acc = CREAM_ACC;
		}
	}
	
	if(!isFlying && flyTimer > 0)
		flyTimer--;
		
	if(ringsTimer > 0)
		ringsTimer--;
	
	if(dashTimer > 0)
		dashTimer--;
}