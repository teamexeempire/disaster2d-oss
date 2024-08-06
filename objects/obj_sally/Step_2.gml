#macro SALLY_ATTACK BALANCING+1
#macro SALLY_SLIDE BALANCING+2
#macro SALLY_SEX BALANCING+3
#macro SALLY_ZIPLINE BALANCING+4

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

if(isSliding)
{
	state = SALLY_SLIDE;
	return;
}

if(isAttacking)
{
	state = SALLY_ATTACK;
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	else
	{
		state = SALLY_ZIPLINE;
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
		state = FALL;
	}
}