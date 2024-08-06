if(voteKick || obj_minigame.ingame)
	return;

chatMode = !chatMode;

if(chatMode)
{
	keyboard_string = chatMsg;
	keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_none, true);
}
else
{
	keyboard_virtual_hide();
	
	if(chatMsg == "")
		return;
		
	chatMsg = string_lower(chatMsg);
	
	switch(chatMsg)
	{			
		case ".mute":
		case ".m":
			
			if(global.muteChat)
			{
				global.muteChat = false;
				lobby_add_message("(mute)", "@chat is now unmuted.~");
			}
			else
			{
				lobby_add_message("(mute)", "\\chat is now muted.~");
				global.muteChat = true;
			}	
			break;
			
		default:
			var packet = cpacket_tcp(PacketType.CLIENT_CHAT_MESSAGE, true);
			buffer_write(packet, buffer_u16, obj_netclient.nid);
			buffer_write(packet, buffer_string, scr_chat_filter(chatMsg));
			send_server_tcp(packet);
			lobby_add_message(global.nickname, chatMsg);
			break;
	}
	
	chatMsg = "";
	keyboard_string = "";
}