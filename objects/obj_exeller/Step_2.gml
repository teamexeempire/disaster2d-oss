#macro EXELLER_ATTACK BALANCING+1
#macro EXELLER_AIR_ATTACK BALANCING+2
#macro EXELLER_SHOCKED BALANCING+3
#macro EXELLER_WON BALANCING+4
#macro EXELLER_LOST BALANCING+5
#macro EXELLER_ZIPLINE BALANCING+6
#macro EXELLER_LOST2 BALANCING+7

if(!emotion)
	state = IDLE;

if(won)
{
	if(isGrounded)
	{
		state = EXELLER_WON;
		return;
	}
}

if(lost)
{
	if(isGrounded)
	{
		state = lostState;
		return;
	}
}

if(isHurt)
{
	state = HURT;
	return;
}

if(shockedTimer > 0)
{
	if(!isGrounded)
		state = HURT;
	else
		state = EXELLER_SHOCKED;
	
	return;
}

if(isAttacking)
{
	if(isGrounded)
	{
		if(state == EXELLER_AIR_ATTACK)
		{
			isAttacking = false;
			return;
		}
		state = EXELLER_ATTACK;
	}
	else
	{
		if(state == EXELLER_ATTACK)
		{
			isAttacking = false;
			return;
		}
		state = EXELLER_AIR_ATTACK;
	}
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	
	state = EXELLER_ZIPLINE;
	return;
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
	if(abs(xspd) < 8)
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
		state = FALL;
}