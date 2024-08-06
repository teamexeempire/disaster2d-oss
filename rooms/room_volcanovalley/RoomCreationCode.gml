//Level setup code
scr_play_music(mus_volcanovalley);

global.parallax = [
	[ layer_get_id("Background"), 0.9, 1, 0 ],
	[ layer_get_id("Background2"), 0.8, 0.99,  60 ],
	[ layer_get_id("Background3"), 0.7, 0.989, 92 ],
	[ layer_get_id("Background4"), 0.6, 0.988, 132 ],
	[ layer_get_id("Background5"), 0.5, 0.989, 188 ],
] 

scr_level_splitl(spr_vv_tiles, "Tiles");
scr_level_splitl(spr_vv_tiles2, "Tiles2");
scr_level_splitl(spr_vv_tiles3, "TilesFore");

if(os_type == os_android)
{
	layer_clear_fx("Assets_2");
	layer_clear_fx("TilesFore");
	layer_clear_fx("Instances");
	layer_clear_fx("Bochki");
	layer_clear_fx("Tiles");
	layer_clear_fx("Assets_1");
	layer_clear_fx("Tiles2");
	layer_clear_fx("Background5");
	layer_clear_fx("Background4");
	layer_clear_fx("Background3");
	layer_clear_fx("Background2");
}