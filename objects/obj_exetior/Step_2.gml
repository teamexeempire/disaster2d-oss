#macro EXETIOR_ATTACK BALANCING+1
#macro EXETIOR_AIR_ATTACK BALANCING+2
#macro EXETIOR_SHOCKED BALANCING+3
#macro EXETIOR_WON BALANCING+4
#macro EXETIOR_LOST BALANCING+5
#macro EXETIOR_ZIPLINE BALANCING+6
#macro EXETIOR_STOMP BALANCING+7
#macro EXETIOR_STOMP_LAND BALANCING+8

if(!emotion)
	state = IDLE;

if(won)
{
	if(isGrounded)
	{
		state = EXETIOR_WON;
		return;
	}
}

if(lost)
{
	if(isGrounded)
	{
		state = EXETIOR_LOST;
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
		state = EXETIOR_SHOCKED;
	
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	
	state = EXETIOR_ZIPLINE;
	return;
}

if(isStomping)
{
	if(isGrounded)
		state = EXETIOR_STOMP_LAND;
	else
		state = EXETIOR_STOMP;
	return;
}

if(isAttacking)
{
	if(isGrounded)
	{
		if(!prevGrounded)
		{
			isAttacking = false;
			return;
		}
		
		state = EXETIOR_ATTACK;
	}
	else
	{
		if(prevGrounded)
		{
			isAttacking = false;
			return;
		}
		
		state = EXETIOR_AIR_ATTACK;
	}
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