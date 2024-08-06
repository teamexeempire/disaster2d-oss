//Level setup code
scr_play_music(mus_angelisland);

global.parallax = [
	[ layer_get_id("Background"), 0.5, 0.8, 0 ],
	[ layer_get_id("Background2"), 0.6, 0.8, 67 ],
	[ layer_get_id("Background3"), 0.7, 0.8, 135 ],
	[ layer_get_id("Background38"), 0.766, 0.8, 186 ],
	[ layer_get_id("Background4"), 0.8, 0.8, 202 ],
	[ layer_get_id("Background5"), 0.9, 0.8, 226 ],
	[ layer_get_id("Background6"), 0.9, 0.8, 370 ],
	[ layer_get_id("Background7"), 0.8, 0.8, 442 ],
	[ layer_get_id("Background8"), 0.7, 0.8, 458 ],
	[ layer_get_id("Background9"), 0.6, 0.8, 482 ],
	[ layer_get_id("Background10"), 0.5, 0.8, 522 ],
] 

scr_level_splitl(spr_aiz_tiles, "Tiles");
scr_level_splitl(spr_aiz_tiles2, "TilesFore");

if(os_type == os_android)
{
	layer_clear_fx("Assets_2");
	layer_clear_fx("TilesFore");
	layer_clear_fx("Instances2");
	layer_clear_fx("Instances");
	layer_clear_fx("Tiles");
	layer_clear_fx("Assets_1");
	layer_clear_fx("Background10");
	layer_clear_fx("Background9");
	layer_clear_fx("Background8");
	layer_clear_fx("Background7");
	layer_clear_fx("Background6");
	layer_clear_fx("Background5");
	layer_clear_fx("Background4");
	layer_clear_fx("Background3");
	layer_clear_fx("Background2");
	layer_clear_fx("Background");
}