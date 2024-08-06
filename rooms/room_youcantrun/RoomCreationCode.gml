//Level setup code
scr_play_music(mus_youcantrun);

global.parallax = [
	[ layer_get_id("Background"),  0.5, 1, 0 ],
	[ layer_get_id("Background2"), 0.6, 1, 80 ],
	[ layer_get_id("Background3"), 0.7, 1, 176 ],
	[ layer_get_id("Background4"), 0.8, 1, 256 ],
];

scr_level_split(spr_ycr_tiles, 90);
scr_level_split(spr_ycr_tiles2, 90, true, 1152);