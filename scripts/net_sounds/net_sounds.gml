global.net_snds = 
[
	snd_none,
	snd_dash, // 0
	snd_dead, // 1
	snd_expweak, // 2
	snd_jump, // 3
	snd_ring, // 4
	snd_ringlose, // 5
	snd_spin, // 6
	snd_spring, // 7
	snd_hurt, // 8
	snd_spike, // 9
	snd_buble, // 10
	snd_exe_stun, // 11
	snd_exe_appear, // 12 
	snd_tails_shoot,// 13
	snd_tails_fly, // 14
	snd_tails_charge, // 15
	snd_teleport, // 16
	snd_egg_djump, // 17
	snd_egg_shield, // 18
	snd_electroshock, // 19
	snd_creamdash, // 20
	snd_sally_shield, // 21
	snd_sally_slide, // 22
	snd_sally_shieldbreak, // 23
	snd_slime, // 24
	snd_creamring, //25
	snd_exe_ringshutter, //26
	snd_redring, // 27
	snd_egg_tracker, // 28
	snd_egg_tracker_activate,  // 29
	snd_exe_laugh, //30
	snd_ringabsorb, //31
	snd_blackring, //32
	snd_lift, //33
	snd_lavahit, //34
	
	snd_watersplash, // 35
	snd_snap, //36
	snd_heal, //37
	snd_exetior_stomp, //38
	snd_exetior_stompland, //39
	snd_chaos_stun, //40
	snd_chaos_sturn, //41
	snd_chaos_attack, //42
	snd_chaos_dash, //43
	snd_exetior_stun,//44
	snd_exeller_stun, //45
	
	snd_exe_kill1, //46
	snd_exe_kill2,
	snd_exe_kill3,
	snd_exe_kill4,
	snd_exe_laugh,
	snd_exe_taunt,
	snd_exe_taunt1,
	snd_exe_taunt2,
	snd_exe_stun2,
	snd_exe_appear2,
	snd_exe_appear3,
	snd_exe_invisenter,
	snd_exe_invisenter2,
	
	snd_chaos_kill,
	snd_chaos_kill2,
	snd_chaos_kill3,
	snd_chaos_kill4,
	snd_chaos_kill5,
	snd_chaos_kill6,
	snd_chaos_kill7,
	snd_chaos_kill8,
	snd_chaos_taunt,
	snd_chaos_taunt2,
	snd_chaos_pizza,
	snd_chaos_vineboom,
	snd_chaos_laugh,
	
	snd_exetior_kill1,
	snd_exetior_kill2,
	snd_exetior_kill3,
	snd_exetior_kill4,
	snd_exetior_kill5,
	snd_exetior_kill6,
	snd_exetior_taunt1,
	snd_exetior_taunt2,
	snd_exetior_taunt3,
	snd_exetior_ring1,
	snd_exetior_ring2,
	snd_exetior_ring3,
	snd_exetior_ring4,
	snd_exetior_laugh,
	
	snd_exeller_clone,
	snd_exeller_cloneline,
	snd_exeller_kill1,
	snd_exeller_kill2,
	snd_exeller_kill3,
	snd_exeller_kill4,
	snd_exeller_kill5,
	snd_exeller_kill6,
	snd_exeller_kill7,
	snd_exeller_taunt1,
	snd_exeller_taunt2,
	snd_exeller_taunt3,
	snd_exeller_laugh,
	snd_chaos_land,
	
	snd_tailsball_jumpscare2,
	snd_roar,
	snd_boohoo
];
global.tmp_sndid = 0;

function net_sound_emit(sndid)
{
	if(global.character == CHARACTER_EXE && global.player.invisTimer > 0)
	{
		if(sndid != snd_spring)
			return;
	}
	
	var buffer = cpacket_tcp(PacketType.CLIENT_SOUND_EMIT, true);
	
	global.tmp_sndid = sndid;
	buffer_write(buffer, buffer_u16, obj_netclient.nid);
	buffer_write(buffer, buffer_u8, array_find_index(global.net_snds, function(_element, _index)
	{
	    return _element == global.tmp_sndid;
	}));
	buffer_write(buffer, buffer_bool, false);
	send_server_tcp(buffer);
}

function net_sound_emit_at(sndid, nid)
{
	if(global.character == CHARACTER_EXE && global.player.invisTimer > 0)
	{
		if(sndid != snd_spring)
			return;
	}
	
	var buffer = cpacket_tcp(PacketType.CLIENT_SOUND_EMIT, true);
	
	global.tmp_sndid = sndid;
	buffer_write(buffer, buffer_u16, nid);
	buffer_write(buffer, buffer_u8, array_find_index(global.net_snds, function(_element, _index)
	{
	    return _element == global.tmp_sndid;
	}));
	buffer_write(buffer, buffer_bool, true);
	send_server_tcp(buffer);
}