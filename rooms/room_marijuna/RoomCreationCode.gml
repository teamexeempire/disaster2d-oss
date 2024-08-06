//Level setup code
scr_play_music(mus_marijuna);

global.parallax = [
	[ layer_get_id("Background"), 0.98, 0.98, 0 ],
	[ layer_get_id("Backgrounds_2"), 0.8, 0.96, 160 ],
	[ layer_get_id("Backgrounds_3"), 0.7, 0.96, 180 ],
	[ layer_get_id("Backgrounds_4"), 0.6, 0.94, 214+20 ],
	[ layer_get_id("Backgrounds_5"), 0.5, 0.93, 220+20 ],
];

scr_level_split(spr_marijuna_tiles, 100);
scr_level_split(spr_marijuna_tiles2, 220);