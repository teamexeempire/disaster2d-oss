//Level setup code
scr_play_music(mus_hauntdream);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 1, 0 ],
	[ layer_get_id("Background2"), 0.89, 0.96, - 60 ],
	[ layer_get_id("Background3"), 0.87, 0.96, - 60 ],
	[ layer_get_id("Background4"), 0.86, 0.96, - 60 ],
];

scr_level_split(spr_hd_tiles, -10);
scr_level_split(spr_hd_tiles2, 200);