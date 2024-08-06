//Level setup code
scr_play_music(mus_hill);

global.parallax = [
	[ layer_get_id("Background2"), 0.6, 1, 14 ],
	[ layer_get_id("Background3"), 0.7, 1, 14 ],
	[ layer_get_id("Background4"), 0.8, 1, 14 ],
	[ layer_get_id("Background5"), 0.5, 1, 0 ],
	[ layer_get_id("Background6"), 0.9, 1, 0 ],
] 

scr_level_split(spr_ghz_tiles2, -10);
scr_level_split(spr_ghz_tiles, 100);