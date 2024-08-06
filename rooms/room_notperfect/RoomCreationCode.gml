//Level setup code
scr_play_music(mus_notperfect);

scr_level_splitl(spr_notperfect2, "ShadowTiles");
scr_level_splitl(spr_notperfect, "Tiles");

scr_level_splitl(spr_notperfect2_p2, "ShadowTiles", true, 1368);
scr_level_splitl(spr_notperfect_p2, "Tiles", true, 1368);

with(obj_tile)
{
	if(depth == 90)
	{
		isVis = false;
		image_alpha = 0;
	}
}