//Level setup code
scr_play_music(mus_hideandseek2);

global.parallax = [
	[ layer_get_id("Background"), 0.3, 1 ],
	[ layer_get_id("Background2"), 0.2, 1 ],
] 

scr_level_split(spr_hs2_tiles, 90);