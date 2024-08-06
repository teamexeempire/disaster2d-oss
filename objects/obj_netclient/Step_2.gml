net_poll();

if(!isConnected)
	return;
	
if(!isInit)
	return;
	
if(!isServerReady)
{
	global.playerControls = false;
}
else
{
	if(sendTimeout > 0)
	{
		sendTimeout--;
		global.playerControls = false;
	}
	else
	{
		if(sendTimeout == 0 && isServerReady)
			global.playerControls = true;
			
		if(sendTimeout-- %  60 == 0)
		{
			var packet = cpacket_udp(PacketType.CLIENT_PING);
			send_server_udp(packet);
		}
	}
}

if(!instance_exists(global.player))
	return;

//Send player packet
with(global.player)
{
	if(obj_netclient.isReady)
	{
		var buffer = cpacket_udp(PacketType.CLIENT_PLAYER_DATA);
		buffer_write(buffer, buffer_u16, x);
		buffer_write(buffer, buffer_u16, y);
		buffer_write(buffer, buffer_f16, xspd);
		buffer_write(buffer, buffer_f16, yspd);
		
		buffer_write(buffer, buffer_u8, state);
		buffer_write(buffer, buffer_s16, radtodeg(angle));
		buffer_write(buffer, buffer_u8, image_index);
		buffer_write(buffer, buffer_s8, image_xscale);
	
		var bitflags = 0;
	
		if(effectTime > 0)
			bitflags |= PLAYER_EFFECT;
	
		if(global.character != CHARACTER_EXE)
		{
			buffer_write(buffer, buffer_s8, hp);
			buffer_write(buffer, buffer_u8, revivalTimes);
			buffer_write(buffer, buffer_s16, rings);
		
			if(hurttime > 0)
				bitflags |= PLAYER_HURT;
			
			if(redRingTimer > 0)
				bitflags |= PLAYER_REDRING;
		
			if(global.character == CHARACTER_KNUX || global.character == CHARACTER_AMY || global.character == CHARACTER_SALLY || global.character == CHARACTER_EGGMAN)
			{
				if(isAttacking)
					bitflags |= PLAYER_ATTACKING;
			}
		
			if(global.character == CHARACTER_SALLY)
			{
				if(shieldTimer > 0)
					bitflags |= PLAYER_SALLYSHIELD;
			}
		
			buffer_write(buffer, buffer_u8, bitflags);
			if(global.character == CHARACTER_TAILS)
			{
				buffer_write(buffer, buffer_u8, attackCharge);
				buffer_write(buffer, buffer_s16, -radtodeg(arctan2(obj_tails.yspd, obj_tails.isGrounded ? obj_tails.gspd : obj_tails.xspd)));
			}
		}
		else
		{
			var attacking = isAttacking;
		
			switch(global.exeCharacter)
			{
				case 0:
					if(!((state == EXE_ATTACK && image_index > 0)	|| (state == EXE_AIR_ATTACK && image_index >= 3)))
						attacking = false;
					break;
			}
		
			if(attacking)
				bitflags |= PLAYER_ATTACKING;
			
			if(hurttime > 0)
				bitflags |= PLAYER_HURT;
		
			switch(global.exeCharacter)
			{
				case 0:
					if(invisTimer > 0)
						bitflags |= PLAYER_INVIS;
					break;
				case 1:
					if(slimeTimer > 0 && (state != CHAOS_TRANSFORM && state != CHAOS_AIRTRANSFORM))
						bitflags |= PLAYER_SLIME;
					break;
			}
		
			buffer_write(buffer, buffer_u8, bitflags);
		}
	
		send_server_udp(buffer);
	}
}