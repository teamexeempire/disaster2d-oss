//Level setup code
scr_play_music(mus_deserttown);

global.parallax = [
	[ layer_get_id("Background"),  0.8, 1, 0 ],
	[ layer_get_id("Background2"), 0.9, 1, 0 ],
	[ layer_get_id("Background3"), 0.7, 1, 136 ],
	[ layer_get_id("Background4"), 0.6, 1, 151 ],
	[ layer_get_id("Background5"), 0.5, 1, 182 ],
	[ layer_get_id("Background6"), 0.4, 1, 216 ],
];

scr_level_split(spr_deserttown_tiles, 90);
scr_level_split(spr_deserttown_tiles2, -400);
scr_level_split(spr_deserttown_tiles3, -300);