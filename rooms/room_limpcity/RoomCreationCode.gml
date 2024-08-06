//Level setup code
scr_play_music(mus_limpcity);

global.parallax = [
	[ layer_get_id("Background1"), 1, 1, 0 ],
	[ layer_get_id("Background2"), 0.7, 1, 64 ],
	[ layer_get_id("Background3"), 0.5, 1, 185 ],
];

scr_level_split(spr_limpcity_tiles, 90);
instance_create_depth(0, 0, -500, obj_redring_screen2);