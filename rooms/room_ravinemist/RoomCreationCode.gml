//Level setup code
scr_play_music(mus_ravimemist);

global.parallax = [
	[ layer_get_id("Background"),  0.3, 0.4 ],
	[ layer_get_id("Background2"), 0.1, 1 ],
	[ layer_get_id("Background3"), 0.4, 1 ]
];

scr_level_split(spr_ravinemist, 90);
scr_level_split(spr_ravinemist2, 90, true, 1247);