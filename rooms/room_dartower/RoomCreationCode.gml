//Level setup code
scr_play_music(mus_darktower);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 0.88, 0 ],
];

scr_level_split(spr_darktower_tiles, 100);