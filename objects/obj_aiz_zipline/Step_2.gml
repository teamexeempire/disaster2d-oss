if(timeout > 0)
	timeout--;

if(zstart == noone)
{
	var _inst = self;
	with(obj_aiz_zipline_start)
	{
		if(gid != _inst.gid)
			continue;
			
		_inst.zstart = self;
	}
}

if(zend == noone)
{
	var _inst = self;
	with(obj_aiz_zipline_end)
	{
		if(gid != _inst.gid)
			continue;
			
		_inst.zend = self;
	}
}

if(zstart == noone || zend == noone)
	return;

if(instance_exists(global.player) && global.player.hp > 0)
{
	if(place_meeting(x, y, global.player) && !global.player.isGrounded && !hasPlayer && progress <= 0 && timeout <= 0)
	{
		if(global.character == CHARACTER_EXE && global.exeCharacter == EXE_ORIGINAL && global.player.state == EXE_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_EXE && global.exeCharacter == EXE_CHAOS && global.player.state == CHAOS_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_EXE && global.exeCharacter == EXE_EXETIOR && global.player.state == EXETIOR_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_EXE && global.exeCharacter == EXE_EXELLER && global.player.state == EXELLER_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_TAILS && global.player.state == TAILS_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_KNUX && global.player.state == KNUX_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_EGGMAN && global.player.state == EGG_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_AMY && global.player.state == AMY_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_CREAM && global.player.state == CREAM_ZIPLINE)
			return;
			
		if(global.character == CHARACTER_SALLY && global.player.state == SALLY_ZIPLINE)
			return;
			
		audio_play_sound(snd_snap, 0, false);
		net_sound_emit(snd_snap);
		hasPlayer = true;
		progress = 0;
		zspeed = 0.001;
		zvspeed = 0;
		
		global.player.x = x + 12;
		global.player.y = y + 16;
		
		with(obj_camera)
		{
			x = floor(global.player.x) - 240;
			y = floor(global.player.y) - 135;
			dist = 0;
		}
	}
}

if(hasPlayer && progress < 1)
{
	x = zstart.x + floor((zend.x - zstart.x) * progress);
	y = zstart.y + floor((zend.y - zstart.y) * progress);
	
	global.player.x = x + 12;
	switch(global.character)
	{
		case CHARACTER_EXE:
			global.player.y = y + 22;
			break;
			
		case CHARACTER_TAILS:
			global.player.y = y + 11;
			global.player.isFlying = false;
			break;
			
		case CHARACTER_KNUX:
			global.player.y = y + 22;
			global.player.isGliding = false;
			
			if(global.player.isStuck)
			{
				global.player.canMove = true;
				global.player.isStuck = false;
			}
			break;
			
		case CHARACTER_EGGMAN:
			global.player.y = y + 25;
			break;
			
		case CHARACTER_AMY:
			global.player.y = y + 21;
			global.player.isHJ = false;
			break;
			
		case CHARACTER_CREAM:
			global.player.y = y + 8;
			global.player.isFlying = false;
			break;
			
		case CHARACTER_SALLY:
			global.player.y = y + 18;
			break;
			
	}
	
	global.player.y += sprite_height;
	
	if(global.player.isDead || global.player.hp <= 0 || (progress >= 0.1 && keyboard_check_pressed(global.KeyA)) || !instance_exists(global.player))
	{
		keyboard_key_release(global.KeyA);
		global.player.isZipline = false;
		progress = 1;
	}
	else
		_holdPlayer();
	
	if(zspeed < 0.016)
		zspeed += 0.0001;
		
	progress += zspeed;
	if(progress >= 1)
	{
		camY = obj_camera.y;
		global.player.xspd = sign(zend.x - zstart.x) * zspeed * 150;
	}
}

if(progress >= 1)
{
	zvspeed += 0.32;
	timeout = 60 * 3;
	y += zvspeed;
	
	if(y >= camY + 480)
	{
		x = zstart.x;
		y = zstart.y;
		progress = 0;
		zspeed = 0.001;
		zvspeed = 0;
	}
	
	if(!obj_netclient.gameEnds)
		global.playerControls = true;
	
	hasPlayer = false;
}