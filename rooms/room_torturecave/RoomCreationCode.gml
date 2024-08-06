//Level setup code
scr_play_music(mus_torturecave);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 0.99, 0 ],
	[ layer_get_id("Background2"), 0.8, 0.99, 0 ],
	[ layer_get_id("Background3"), 0.7, 0.99, -60 ]
] 

scr_level_split(spr_am_tiles2, -200);
scr_level_split(spr_am_tiles, -199);
scr_level_split(spr_am_tiles3, 102);

with(obj_tile)
{
	if(depth != -200)
		continue;
		
	image_alpha = 0.8;
}