//Level setup code
scr_play_music(mus_weedzone);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 1, 0 ],
	[ layer_get_id("Background1"), 0.8, 1, 0 ],
	[ layer_get_id("Background2"), 0.7, 1, 0 ],
];

scr_level_split(spr_weed_tiles, 90);
scr_level_split(spr_weed_tiles2, 100);
scr_level_split(spr_weed_tiles3, -100);