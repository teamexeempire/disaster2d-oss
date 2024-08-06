//Level setup code
scr_play_music(mus_pricelessfreedom);

global.parallax = [
	[ layer_get_id("Background"), 0.7, 0.7 ]
] 

scr_level_split(spr_pf_tiles, 100);