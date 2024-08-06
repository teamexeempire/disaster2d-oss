#macro IDLE 0
#macro WALK 1
#macro RUN 2
#macro JUMP 3
#macro FALL 4
#macro HURT 5
#macro DEAD 6
#macro LOOKUP 7
#macro LOOKDOWN 8
#macro EMOTION1 9
#macro EMOTION2 10
#macro EMOTION3 11
#macro SPIN 12
#macro BALANCING 13

#macro CHARACTER_TAILS 1
#macro CHARACTER_KNUX (CHARACTER_TAILS+1)
#macro CHARACTER_EGGMAN (CHARACTER_TAILS+2)
#macro CHARACTER_AMY (CHARACTER_TAILS+3)
#macro CHARACTER_CREAM (CHARACTER_TAILS+4)
#macro CHARACTER_SALLY (CHARACTER_TAILS+5)

global.player_anims = ds_map_create();

//Tails
global.player_anims[? CHARACTER_TAILS] = 
[
	spr_tails_idle, //0
	spr_tails_walk, //1
	spr_tails_run, //2
	spr_tails_jump, //3
	spr_tails_fall, //4
	spr_tails_hurt, //5
	spr_tails_dead, //6
	spr_tails_lookup, //7
	spr_tails_lookdown, //8
	spr_tails_emotion1, //9
	spr_tails_emotion2, //10
	spr_tails_emotion3, //11
	spr_tails_jump, //12
	spr_tails_balancing, //13
	spr_tails_fly, //14
	spr_tails_attack1, //15
	spr_tails_zipline, //16
];

//Knux
global.player_anims[? CHARACTER_KNUX] = 
[
	spr_knux_idle, //0
	spr_knux_walk, //1
	spr_knux_run, //2
	spr_knux_jump, //3
	spr_knux_fall, //4
	spr_knux_hurt, //5
	spr_knux_dead, //6
	spr_knux_lookup, //7
	spr_knux_lookdown, //8
	spr_knux_emotion1, //9
	spr_knux_emotion2, //10
	spr_knux_emotion3, //11
	spr_knux_jump, //12
	spr_knux_balancing, //13
	spr_knux_attack2, //14
	spr_knux_attack1, //15
	spr_knux_glide, //16
	spr_knux_zipline, //17
	spr_knux_stuck //18
];

//Egg
global.player_anims[? CHARACTER_EGGMAN] = 
[
	spr_egg_idle, //0
	spr_egg_walk, //1
	spr_egg_run, //2
	spr_egg_jump, //3
	spr_egg_fall, //4
	spr_egg_hurt, //5
	spr_egg_dead, //6
	spr_egg_lookup, //7
	spr_egg_lookdown, //8
	spr_egg_emotion1, //9
	spr_egg_emotion2, //10
	spr_egg_emotion3, //11
	spr_egg_jump, //12
	spr_egg_balancing, //13
	spr_egg_djump, //14
	spr_egg_zipline //15
];

//Amy
global.player_anims[? CHARACTER_AMY] = 
[
	spr_amy_idle, //0
	spr_amy_walk, //1
	spr_amy_run, //2
	spr_amy_jump, //3
	spr_amy_fall, //4
	spr_amy_hurt, //5
	spr_amy_dead, //6
	spr_amy_lookup, //7
	spr_amy_lookdown, //8
	spr_amy_emotion1, //9
	spr_amy_emotion2, //10
	spr_amy_emotion3, //11
	spr_amy_jump, //12
	spr_amy_balancing, //13
	spr_amy_attack1, //14
	spr_amy_attack2, //15
	spr_none, //16
	spr_amy_zipline //17
];

//Cream
global.player_anims[? CHARACTER_CREAM] = 
[
	spr_cream_idle, //0
	spr_cream_walk, //1
	spr_cream_run, //2
	spr_cream_jump, //3
	spr_cream_fall, //4
	spr_cream_hurt, //5
	spr_cream_dead, //6
	spr_cream_lookup, //7
	spr_cream_lookdown, //8
	spr_cream_emotion1, //9
	spr_cream_emotion2, //10
	spr_cream_emotion3, //11
	spr_cream_jump, //12
	spr_cream_balancing, //13
	spr_cream_fly, //14
	spr_cream_srings, //15
	spr_cream_zipline //16
];

//Sally
global.player_anims[? CHARACTER_SALLY] = 
[
	spr_sally_idle, //0
	spr_sally_walk, //1
	spr_sally_run, //2
	spr_sally_jump, //3
	spr_sally_fall, //4
	spr_sally_hurt, //5
	spr_sally_dead, //6
	spr_sally_lookup, //7
	spr_sally_lookdown, //8
	spr_sally_emotion1, //9
	spr_sally_emotion2, //10
	spr_sally_emotion3, //11
	spr_sally_jump, //12
	spr_sally_balancing, //13
	spr_sally_attack, //14
	spr_sally_slide, //15
	spr_none, // 16
	spr_sally_zipline // 17
];

global.player_eanims = ds_map_create();

//Tails
global.player_eanims[? CHARACTER_TAILS] = 
[
	spr_etails_idle, //0
	spr_etails_walk, //1
	spr_etails_run, //2
	spr_etails_jump, //3
	spr_etails_fall, //4
	spr_etails_hurt, //5
	spr_etails_stun, //6
	spr_etails_lookup, //7
	spr_etails_lookdown, //8
	spr_etails_emotion1, //9
	spr_etails_emotion2, //10
	spr_etails_emotion3, //11
	spr_etails_jump, //12
	spr_etails_balancing, //13
	spr_etails_fly, //14
	spr_etails_attack1, //15
	spr_etails_zipline //16
];

//Knux
global.player_eanims[? CHARACTER_KNUX] = 
[
	spr_eknux_idle, //0
	spr_eknux_walk, //1
	spr_eknux_run, //2
	spr_eknux_jump, //3
	spr_eknux_fall, //4
	spr_eknux_hurt, //5
	spr_eknux_stun, //6
	spr_eknux_lookup, //7
	spr_eknux_lookdown, //8
	spr_eknux_emotion1, //9
	spr_eknux_emotion2, //10
	spr_eknux_emotion3, //11
	spr_eknux_jump, //12
	spr_eknux_balancing, //13
	spr_eknux_attack2, //14
	spr_eknux_attack1, //15
	spr_eknux_glide, //16
	spr_eknux_zipline, //17
	spr_eknux_stuck //18
];

//Egg
global.player_eanims[? CHARACTER_EGGMAN] = 
[
	spr_eegg_idle, //0
	spr_eegg_walk, //1
	spr_eegg_run, //2
	spr_eegg_jump, //3
	spr_eegg_fall, //4
	spr_eegg_hurt, //5
	spr_eegg_stun, //6
	spr_eegg_lookup, //7
	spr_eegg_lookdown, //8
	spr_eegg_emotion1, //9
	spr_eegg_emotion2, //10
	spr_eegg_emotion3, //11
	spr_eegg_jump, //12
	spr_eegg_balancing, //13
	spr_eegg_djump, //14
	spr_eegg_zipline //15
];

//Amy
global.player_eanims[? CHARACTER_AMY] = 
[
	spr_eamy_idle, //0
	spr_eamy_walk, //1
	spr_eamy_run, //2
	spr_eamy_jump, //3
	spr_eamy_fall, //4
	spr_eamy_hurt, //5
	spr_eamy_stun, //6
	spr_eamy_lookup, //7
	spr_eamy_lookdown, //8
	spr_eamy_emotion1, //9
	spr_eamy_emotion2, //10
	spr_eamy_emotion3, //11
	spr_eamy_jump, //12
	spr_eamy_balancing, //13
	spr_eamy_attack1, //14
	spr_eamy_attack2, //15
	spr_none, // 16
	spr_eamy_zipline //17
];

//Cream
global.player_eanims[? CHARACTER_CREAM] = 
[
	spr_ecream_idle, //0
	spr_ecream_walk, //1
	spr_ecream_run, //2
	spr_ecream_jump, //3
	spr_ecream_fall, //4
	spr_ecream_hurt, //5
	spr_ecream_stun, //6
	spr_ecream_lookup, //7
	spr_ecream_lookdown, //8
	spr_ecream_emotion1, //9
	spr_ecream_emotion2, //10
	spr_ecream_emotion3, //11
	spr_ecream_jump, //12
	spr_ecream_balancing, //13
	spr_ecream_fly, //14
	spr_ecream_srings, //15
	spr_ecream_zipline //16
];

//Sally
global.player_eanims[? CHARACTER_SALLY] = 
[
	spr_esally_idle, //0
	spr_esally_walk, //1
	spr_esally_run, //2
	spr_esally_jump, //3
	spr_esally_fall, //4
	spr_esally_hurt, //5
	spr_esally_stun, //6
	spr_esally_lookup, //7
	spr_esally_lookdown, //8
	spr_esally_emotion1, //9
	spr_esally_emotion2, //10
	spr_esally_emotion3, //11
	spr_esally_jump, //12
	spr_esally_balancing, //13
	spr_esally_attack, //14
	spr_esally_slide, //15
	spr_none, // 16
	spr_esally_zipline // 17
];

function player_get(ind)
{
	switch(ind)
	{
		case CHARACTER_EXE:
			return obj_exe;
		
		case CHARACTER_TAILS:
			return obj_tails;
			
		case CHARACTER_KNUX:
			return obj_knux;
			
		case CHARACTER_EGGMAN:
			return obj_egg;
			
		case CHARACTER_AMY:
			return obj_amy;
			
		case CHARACTER_CREAM:
			return obj_cream;
			
		case CHARACTER_SALLY:
			return obj_sally;
	}
}