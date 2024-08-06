#macro CHARACTER_EXE 0
#macro EXE_ORIGINAL 0
#macro EXE_CHAOS 1
#macro EXE_EXETIOR 2
#macro EXE_EXELLER 3

global.player_exesanims = ds_map_create();
global.player_exesanims[? EXE_ORIGINAL] = 
[
	//Visible
	spr_exe_idle, //0
	spr_exe_walk, //1
	spr_exe_run, //2
	spr_exe_jump, //3
	spr_exe_fall, //4
	spr_exe_hurt, //5
	spr_exe_jump, //6
	spr_exe_lookup, //7
	spr_exe_lookdown, //8
	spr_exe_emotion2, // 9
	spr_exe_emotion3, //10
	spr_exe_emotion, // 11
	spr_exe_jump, //12
	spr_exe_balancing, //13
	spr_exe_attack1, //14
	spr_exe_attack2, //15
	spr_exe_shocked, //16
	spr_exe_emotion, //17
	spr_exe_lost, //18
	spr_exe_zipline, //19
	
	// Invisible
	spr_exe_invis_idle, //0
	spr_exe_invis_walk, //1
	spr_exe_invis_run,  //2
	spr_exe_invis_jump, //3
	spr_exe_invis_fall, //4
	spr_exe_invis_walk, //5
	spr_exe_invis_jump, //6
	spr_exe_invis_lookup, //7
	spr_exe_invis_lookdown, //8
	spr_exe_invis_emotion, //9
	spr_exe_invis_emotion, //10
	spr_exe_invis_emotion, //11
	spr_exe_invis_jump, //12
	spr_exe_invis_balancing, //13
	spr_exe_invis_walk, //14
	spr_exe_invis_walk, //15
	spr_exe_invis_lookdown, //16
	spr_exe_invis_walk, //17
	spr_exe_invis_walk, //18
	spr_exe_invis_zipline //19
];

global.player_exesanims[? EXE_CHAOS] = 
[
	//Visible
	spr_chaos_idle, //0
	spr_chaos_walk, //1
	spr_chaos_run, //2
	spr_chaos_jump, //3
	spr_chaos_fall, //4
	spr_chaos_hurt, //5
	spr_chaos_jump, //6
	spr_chaos_lookup, //7
	spr_chaos_lookdown, //8
	spr_chaos_emotion1, //9
	spr_chaos_emotion2, //10
	spr_chaos_emotion3, //11
	spr_chaos_jump, //12
	spr_chaos_balancing, //13
	spr_chaos_attack1, //14
	spr_chaos_attack2, //15
	spr_chaos_stun, //16
	spr_chaos_won, //17
	spr_chaos_lost, //18
	spr_chaos_lost2, //19
	spr_chaos_zipline, //20
	spr_chaos_stuck, //21
	spr_chaos_stuck2, //22
	spr_chaos_stransform, //23
	spr_chaos_stransformair, //24
	
	// Invisible
	spr_chaos_sidle, //0
	spr_chaos_swalk, //1
	spr_chaos_swalk,  //2
	spr_chaos_sjump, //3
	spr_chaos_sfall, //4
	spr_chaos_swalk, //5
	spr_chaos_sjump, //6
	spr_chaos_sidle, //7
	spr_chaos_sidle, //8
	spr_chaos_sidle, //9
	spr_chaos_sidle, //10
	spr_chaos_sidle, //11
	spr_chaos_sidle, //12
	spr_chaos_sidle, //13
	spr_chaos_sidle, //14
	spr_chaos_sidle, //15
	spr_chaos_sidle, //16
	spr_chaos_sidle, //17
	spr_chaos_sidle, //18
	spr_chaos_sidle, //19
	spr_chaos_sidle, //20
	spr_chaos_sidle, //21
	spr_chaos_sidle, //22
	spr_chaos_sidle, //23
	spr_chaos_sidle, //24
];

global.player_exesanims[? EXE_EXETIOR] = 
[
	//Visible
	spr_exetior_idle, //0
	spr_exetior_walk, //1
	spr_exetior_run, //2
	spr_exetior_jump, //3
	spr_exetior_fall, //4
	spr_exetior_hurt, //5
	spr_exetior_jump, //6
	spr_exetior_lookup, //7
	spr_exetior_lookdown, //8
	spr_exetior_emotion3, // 9
	spr_exetior_emotion2, //10
	spr_exetior_emotion, // 11
	spr_exetior_jump, //12
	spr_exetior_balancing, //13
	spr_exetior_attack1, //14
	spr_exetior_attack2, //15
	spr_exetior_shocked, //16
	spr_exetior_won, //17
	spr_exetior_lost, //18
	spr_exetior_zipline, //19
	spr_exetior_stomp, //20
	spr_exetior_stompland //21
];

global.player_exesanims[? EXE_EXELLER] = 
[
	//Visible
	spr_exeller_idle, //0
	spr_exeller_walk, //1
	spr_exeller_run, //2
	spr_exeller_jump, //3
	spr_exeller_fall, //4
	spr_exeller_hurt, //5
	spr_exeller_jump, //6
	spr_exeller_lookup, //7
	spr_exeller_lookdown, //8
	spr_exeller_emotion3, // 9
	spr_exeller_emotion2, //10
	spr_exeller_emotion, // 11
	spr_exeller_jump, //12
	spr_exeller_balancing, //13
	spr_exeller_attack1, //14
	spr_exeller_attack2, //15
	spr_exeller_shocked, //16
	spr_exeller_won, //17
	spr_exeller_lost, //18
	spr_exeller_zipline, //19
	spr_exeller_lost2, //20
];


function player_getexe(ind)
{
	switch(ind)
	{
		case 0:
			return obj_exe;
			
		case 1:
			return obj_chaos;
			
		case 2:
			return obj_exetior;
			
		case 3:
			return obj_exeller;
	}
}