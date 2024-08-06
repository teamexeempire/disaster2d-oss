//Level setup code
scr_play_music(mus_majinforest);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 1, 0 ],
	[ layer_get_id("Background2"), 0.8, 1, 0 ],
	[ layer_get_id("Background3"), 0.7, 1, 0 ],
];

scr_level_split(spr_majong_tiles, 200);