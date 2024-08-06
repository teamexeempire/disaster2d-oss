if(!isConnected)
	return;

if(!instance_exists(obj_level) || gameEnds || !isServerReady)
{
	udp_timeout = 60 * 5;
	return;
}

if(udp_timeout-- <= 0)
{
	if(gameEnds)
		return;
	
	global.errorCode = 4;
	room_goto(room_message);
}