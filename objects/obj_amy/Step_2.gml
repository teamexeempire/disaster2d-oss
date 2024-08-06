#macro AMY_ATTACK BALANCING+1
#macro AMY_HJUMP BALANCING+2
#macro AMY_SEX BALANCING+3
#macro AMY_ZIPLINE BALANCING+4

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

if(isHJ)
{
	state = AMY_HJUMP;
	return;
}

if(isAttacking)
{
	state = AMY_ATTACK;		
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	else
	{
		state = AMY_ZIPLINE;
		return;
	}
}

if(isHurt)
{
	state = HURT;
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