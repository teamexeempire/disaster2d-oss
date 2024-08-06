//Level setup code
scr_play_music(mus_kindandfair);

global.parallax = [
	[ layer_get_id("Background"), 1, 1, 0 ],
	[ layer_get_id("Background2"), 0.99, 1, 0 ],
	[ layer_get_id("Background3"), 0.8, 1, 0 ],
	[ layer_get_id("Background4"), 0.75, 1, 0 ],
	[ layer_get_id("Background5"), 0.7, 1, 0 ],
	[ layer_get_id("Background6"), 0.65, 1, 0 ],
];

scr_level_split(spr_kindnfair_tiles, 92);