enum DisnetEvent
{
	NONE = 0,
	CONNECTED = 1,
	DISCONNECTED = 2,
	RELIABLE = 3,
	UNRELIABLE = 4
}

function net_join(host, selected_lobby=-1)
{
	with(obj_netclient)
	{ 
		ip = host;
		port = selected_lobby == -1 ? 8606 : selected_lobby;
		want_lobby = selected_lobby;
	
		if(isConnected)
			return;
		
		room_goto(room_connecting);
	}
	
	return true;
}

function net_poll()
{
	var event = DisnetEvent.NONE;
	do
	{
		event = disnet_poll(buffer_get_address(buffer));
		switch(event)
		{
			case DisnetEvent.CONNECTED:
				show_debug_message("connected!");
				if(room != room_connecting)
				{
					net_reset();
					return;
				}
	
				ds_map_clear(pings);
				ds_map_clear(players);
				isReady = false;
				state = STATE_PENDING;
				udp_timeout = 60 * 5;
				sendTimeout = 60;
				isInit = false;
				exeId = 0;
				chance = 0;
				lvlId = -1;
				avCharacters = 
				[ 
					false, //0 (exe) (cannot)
					true,  //1 (tails)
					true,
					true,
					true,
					true,
					true
				];
		
				isConnected = true;
				room_goto(room_waiting);
				return;
		
			case DisnetEvent.DISCONNECTED:
				if(global.errorCode == -1)
				{
					show_debug_message("disconnected!");
					
					buffer_seek(buffer, buffer_seek_start, 0);
					global.errorCode = buffer_read(buffer, buffer_u32);
					room_goto(room_message);
				}
				return;
			
			case DisnetEvent.RELIABLE:
				buffer_seek(buffer, buffer_seek_start, 0);
			
				if(net_tcpprocess(buffer))
					return;
				
				break;
		
			case DisnetEvent.UNRELIABLE:
				if(state != STATE_GAME)
					break;
					
				buffer_seek(buffer, buffer_seek_start, 0);
				net_udpprocess(buffer);
				break;
		}
	
	}
	until(event == 0);
}