function net_reset()
{
	// Create again
	if(instance_exists(obj_netclient))
		instance_destroy(obj_netclient);
	
	disnet_reset();
	game_restart();
}