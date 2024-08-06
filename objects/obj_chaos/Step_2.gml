#macro CHAOS_ATTACK BALANCING+1
#macro CHAOS_AIR_ATTACK BALANCING+2
#macro CHAOS_SHOCKED BALANCING+3
#macro CHAOS_WON BALANCING+4
#macro CHAOS_LOST BALANCING+5
#macro CHAOS_LOST2 BALANCING+6
#macro CHAOS_ZIPLINE BALANCING+7
#macro CHAOS_STUCKBALLS BALANCING+8
#macro CHAOS_STUCKDICKS BALANCING+9
#macro CHAOS_TRANSFORM BALANCING+10
#macro CHAOS_AIRTRANSFORM BALANCING+11

if(!emotion)
	state = IDLE;

if(won)
{
	if(isGrounded)
	{
		state = CHAOS_WON;
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

if(stuckTimer > 0)
{
	if(isGrounded)
		state = CHAOS_STUCKBALLS;
	else
		state = CHAOS_STUCKDICKS;
		
	return;
}

if(isHurt)
{
	state = HURT;
	return;
}

if(slimeTimer > 0)
{
	if(!slimeAnim)
	{
		if(!isGrounded)
			state = CHAOS_AIRTRANSFORM;
		else
			state = CHAOS_TRANSFORM;
			
		return;
	}
}

if(shockedTimer > 0)
{
	if(!isGrounded)
		state = HURT;
	else
		state = CHAOS_SHOCKED;
	
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
		
		state = CHAOS_ATTACK;
	}
	else
	{
		if(prevGrounded)
		{
			isAttacking = false;
			return;
		}
		
		state = CHAOS_AIR_ATTACK;
	}
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	
	state = CHAOS_ZIPLINE;
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