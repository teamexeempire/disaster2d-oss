if(instance_exists(global.player))
{
	if(global.player.isDead)
	{
		while(place_meeting(x, y, global.player))
			global.player.x++;
	}
}