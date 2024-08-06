function scr_exe_stunsound()
{
	switch(global.exeCharacter)
	{
		case EXE_ORIGINAL:
			audio_play_sound(snd_exe_stun2, 0, false);
			net_sound_emit(snd_exe_stun2);
			break;
			
		case EXE_CHAOS:
			audio_play_sound(snd_chaos_stun, 0, false);
			net_sound_emit(snd_chaos_stun);
			break;
			
		case EXE_EXELLER:
			audio_play_sound(snd_exeller_stun, 0, false);
			net_sound_emit(snd_exeller_stun);
			break;
			
		case EXE_EXETIOR:
			audio_play_sound(snd_exetior_stun, 0, false);
			net_sound_emit(snd_exetior_stun);
			break;
	}
}