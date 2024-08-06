#macro TAILS_FLY BALANCING+1
#macro TAILS_ATTACK1 BALANCING+2
#macro TAILS_ZIPLINE BALANCING+3

if(!emotion)
	state = IDLE;

if(!isFlying && audio_is_playing(snd_tails_fly))
	audio_stop_sound(snd_tails_fly);

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

if(attackCharge > 0 || attackAfter > 0)
{
	state = TAILS_ATTACK1;
	return;
}

if(isHurt)
{
	state = HURT;
	return;
}

if(isFlying)
{
	state = TAILS_FLY;
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	else
	{
		state = TAILS_ZIPLINE;
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