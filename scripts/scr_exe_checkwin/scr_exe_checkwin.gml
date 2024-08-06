function scr_exe_checkwin()
{
	if(global.player.hp > 0)
		return;
	
	if(!instance_exists(obj_player_puppet))
		return;
	
	for(var i = 46; i < array_length(global.net_snds); i++)
	{
		if(audio_is_playing(global.net_snds[i]))
			return;
	}
	
	with(obj_player_puppet)
	{
		if(master_id != obj_netclient.exeId)
			continue;
			
		if(character == CHARACTER_EXE)
		{						
			switch(exeCharacter)
			{
				case EXE_ORIGINAL:
				{
					var _snd = choose(snd_exe_kill1, snd_exe_kill2, snd_exe_kill3, snd_exe_kill4);
					
					net_sound_emit_at(_snd, master_id);
					scr_audio_play_3d(emitter, _snd, 0, false);
					break;
				}
				
				case EXE_CHAOS:
				{
					var _snd = choose(snd_chaos_kill, snd_chaos_kill2, snd_chaos_kill3, snd_chaos_kill4, snd_chaos_kill5, snd_chaos_kill6, snd_chaos_kill7, snd_chaos_kill8);
					
					net_sound_emit_at(_snd, master_id);
					scr_audio_play_3d(emitter, _snd, 0, false);
					break;
				}
				
				case EXE_EXETIOR:
				{
					var _snd = choose(snd_exetior_kill1, snd_exetior_kill2, snd_exetior_kill3, snd_exetior_kill4, snd_exetior_kill5, snd_exetior_kill6);
					
					net_sound_emit_at(_snd, master_id);
					scr_audio_play_3d(emitter, _snd, 0, false);
					break;
				}
				
				case EXE_EXELLER:
				{
					var _snd = choose(snd_exeller_kill1, snd_exeller_kill2, snd_exeller_kill3, snd_exeller_kill4, snd_exeller_kill5, snd_exeller_kill6, snd_exeller_kill7);
					
					net_sound_emit_at(_snd, master_id);
					scr_audio_play_3d(emitter, _snd, 0, false);
					break;
				}
			}
			
			var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
			buffer_write(pak, buffer_u16, master_id);
			buffer_write(pak, buffer_u8, 0);
			send_server_tcp(pak);
		}
			
		break;
	}
}