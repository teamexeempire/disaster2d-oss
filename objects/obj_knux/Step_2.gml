#macro KNUX_ATTACK BALANCING+1
#macro KNUX_AIR_ATTACK BALANCING+2
#macro KNUX_GLIDE BALANCING+3
#macro KNUX_ZIPLINE BALANCING+4
#macro KNUX_STUCK BALANCING+5

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

if(isAttacking)
{
	if(isGrounded)
		state = KNUX_AIR_ATTACK;
	else
		state = KNUX_ATTACK;
		
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	else
	{
		state = KNUX_ZIPLINE;
		return;
	}
}

if(isHurt)
{
	state = HURT;
	return;
}

if(isStuck)
{
	state = KNUX_STUCK;
	return;
}

if(isGliding)
{
	state = KNUX_GLIDE;	
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