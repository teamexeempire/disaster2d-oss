#macro EGG_DJUMP BALANCING+1
#macro EGG_ZIPLINE BALANCING+2

if(!emotion)
	state = IDLE;

if(isDead)
{
	state = DEAD;
	return;
}

if(shockedTimer > 0)
{
	state = DEAD;
	return;
}

if(isHurt)
{
	state = HURT;
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	else
	{
		state = EGG_ZIPLINE;
		return;
	}
}

if(isLookingUp)
{
	state = LOOKUP;
	return;
}

if(isLookingDown)
{
	state = LOOKDOWN;
	return;
}

if(isSpinning)
{
	state = SPIN;
	return;
}

if(abs(xspd) > 0 && isGrounded)
{
	if(abs(xspd) < 6)
		state = WALK;
	else
		state = RUN;
}

if(isOnEdge)
{
	state = BALANCING;
	return;
}

if (!isGrounded) //in air
{
	if(isJumping)
		state = JUMP;
	else
	{
		if(djumpRecharge < 0)
		{
			if(floor(y) % 10 == 0)
				net_quick_effect(global.player.x, global.player.y, spr_eggpack, false, 1, 0, -1);
				
			state = EGG_DJUMP;
		}
		else
			state = FALL;
	}
}