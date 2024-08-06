if(chatMode)
{
	if(keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
		keyboard_string = clipboard_get_text();
		
	chatMsg = string_copy(string_lower(keyboard_string), 0, 48);
	if(string_length(keyboard_string) > 48)
		keyboard_string = chatMsg;
}

if(keyboard_check_pressed(global.KeyLeft))
{
	if(!canUse)
		return;
	
	if(state != 1 || mapChose || mapFade < 1)
		return;

	mapChosen--;
	if(mapChosen < 0)
		mapChosen = 2;
	
	mapOff = 4;
	audio_play_sound(snd_menu_select, 0, false);
}
else if(keyboard_check_pressed(global.KeyRight))
{
	if(!canUse)
		return;
	
	if(state != 1 || mapChose || mapFade < 1)
		return;
	
	mapChosen++;
	if(mapChosen > 2)
		mapChosen = 0;
	
	mapOff = 4;
	audio_play_sound(snd_menu_select, 0, false);
}
else if(keyboard_check_pressed(global.KeyA))
{
	if(!canUse)
		return;

	if(state == 1 && !mapChose && mapFade >= 1)
	{
		var packet = cpacket_tcp(PacketType.CLIENT_VOTE_REQUEST, false);
		buffer_write(packet, buffer_u8, mapChosen);
		send_server_tcp(packet);
	
		audio_play_sound(snd_menu_press, 0, false);
		mapChose = true;
		return;
	}

	if(chatMode || voteKick)
		return;
	
	if(!obj_netclient.isReady)
		return;

	if(obj_netclient.state == STATE_LOBBY)
	{
		isReady = !isReady;
	
		var packet = cpacket_tcp(PacketType.CLIENT_LOBBY_READY_STATE);
		buffer_write(packet, buffer_bool, isReady);
		send_server_tcp(packet);
		audio_play_sound(snd_ready, 0, false);
	}
}
else if(keyboard_check_pressed(global.KeyB))
{
	if(!canUse || voteKick)
		return;

	if(chatMode)
		return;

	if(!obj_netclient.isReady)
		return;
	
	if(state == 0)
		net_reset();
}