if(slimeTimer > 0)
{
	acc = CHAOS_ACC * 1.5;
	maxHSpeed = CHAOS_MAXSPEED * 1.2;
	isSlow = false;
	return;
}

maxHSpeed = CHAOS_MAXSPEED;
acc = CHAOS_ACC;
isSlow = false;