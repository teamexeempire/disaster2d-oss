global.palettes = ds_map_create();
#macro PALETTE_DEMON 20
#macro PALETTE_EXE 40
#macro PALLETE_DEFAULT [ 0, 0, 0, 0 ]

palette_list_push
(
	CHARACTER_TAILS,
	[ #e0a000, #e08000, #a06040, #c0c0e0, #a0a0c0, #606080, #202020 ], 
	[ #e09600, #bf6900, #8f0e00, #a5a5a5, #848484, #424242, #000000 ]
);

palette_list_push
(
	CHARACTER_TAILS,
	[ #e0a000, #e08000, #a06040, #e0e0e0, #c0c0e0, #a0a0c0, #606080, #800000 ],
	[ #f89c00, #fa6000, #b80c00, #fcfcfc, #d8d8fc, #b4b4d8, #6c6c90, #800020 ]
);

palette_list_push
(
	CHARACTER_TAILS + PALETTE_DEMON, 
	[ #2d273b, #181421, #b3b3b3, #828282, #424242 ],
	[ #282848, #101430, #c0c0e0, #a0a0c0, #606080 ]
);

palette_list_push
(
	CHARACTER_TAILS + PALETTE_DEMON, 
	[ #2d273b, #181421, #d6d6d6, #b3b3b3, #828282, #424242 ],
	[ #482928, #301013, #ddd0d0, #c1abaa, #83766d, #53524a ]
);


palette_list_push
(
	CHARACTER_KNUX, 
	[ #f84468, #d00020, #680020, #f8f8f8, #d0d4f8, #b0b0d0, #686888, #f80000, #880000, #202020 ],
	[ #f02c28, #982020, #570000, #e0e0e0, #a5a5a5, #848484, #424242, #982020, #570000, #000000 ]
);

palette_list_push
(
	CHARACTER_KNUX, 
	[ #f84468, #d00020, #680020, #f8f8f8, #d0d4f8, #b0b0d0, #686888, #880000 ],
	[ #fc0000, #ac0000, #570000, #fcfcfc, #d8d8fc, #b4b4d8, #6c6c90, #800020 ]
);

palette_list_push
(
	CHARACTER_KNUX + PALETTE_DEMON, 
	[ #771515, #470013, #1f000b, #d6d6d6, #b3b3b3, #828282, #424242, #d58f6e, #944b3d, #d6d6d6 ],
	[ #900005, #59000f, #210009, #ddd0d0, #c1abaa, #83766d, #53524a, #fcb490, #b46c48, #ddd0d0 ] 
);

palette_list_push
(
	CHARACTER_KNUX + PALETTE_DEMON, 
	[ #771515, #470013, #1f000b, #d6d6d6, #b3b3b3, #828282, #424242, #d58f6e, #944b3d ],
	[ #9f002d, #68002c, #300019, #f8f8f8, #d0d4f8, #b0b0d0, #686888, #fcb490, #b46c48 ]
);


palette_list_push
(
	CHARACTER_EGGMAN, 
	[ #800000, #e0a000, #e0e0e0, #c0c0e0, #a0a0c0, #606080, #202020 ],
	[ #570000, #ffda00, #e0e0e0, #a5a5a5, #848484, #424242, #000000 ]
);

palette_list_push
(
	CHARACTER_EGGMAN, 
	[ #e00000, #800000, #e0a000, #e0e0e0, #c0c0e0, #a0a0c0, #606080, #e0a080, #a06040 ],
	[ #b42448, #800020, #f89c00, #fcfcfc, #d8d8fc, #b4b4d8, #6c6c90, #f29a6e, #ba5726 ]
);

palette_list_push
(
	CHARACTER_EGGMAN + PALETTE_DEMON,
	[ #470013, #1f000b, #976e2b, #64372b, #d6d6d6, #b3b3b3, #828282, #424242, #363636, #636363, #470000, #383838, #616161 ],
	[ #6e1717, #420f0f, #b19a27, #92791e, #ddd0d0, #c1abaa, #83766d, #53524a, #6b5f5f, #afa3a3, #800000, #6b5f5f, #afa3a3 ] 
);

palette_list_push
(
	CHARACTER_EGGMAN + PALETTE_DEMON,
	[ #470013, #1f000b, #976e2b, #64372b, #d6d6d6, #b3b3b3, #828282, #424242 ],
	[ #610000, #380000, #b39502, #8c6e00, #f8f8f8, #d0d4f8, #b0b0d0, #686888 ]
);


palette_list_push
(
	CHARACTER_AMY, 
	[ #f19dbb, #e65b8c, #a93559, #bb7655, #fcb037, #dc7605, #ff7575, #e0e0e0, #c0c0e0, #a0a0c0, #606080, #202020 ],
	[ #e1a1cc, #d45a99, #802e42, #aa6644, #e08e00, #a06040, #e74200, #e0e0e0, #a5a5a5, #848484, #424242, #000000 ]
);

palette_list_push
(
	CHARACTER_AMY, 
	[ #f19dbb, #e65b8c, #a93559, #bb7655, #800000, #e0e0e0, #c0c0e0, #a0a0c0, #606080 ],
	[ #ff9cbe, #ff3b65, #a61738, #ba5726, #800020, #fcfcfc, #d8d8fc, #b4b4d8, #6c6c90 ]
);

palette_list_push
(
	CHARACTER_AMY + PALETTE_DEMON,
	[ #884440, #582c28, #301818, #d6d6d6, #b3b3b3, #828282, #424242, #9e4127, #d58f6e ],
	[ #c97f7b, #8c4b48, #4d2626, #e0e0e0, #c0c0e0, #a0a0c0, #606080, #7f6948, #dab273 ]
);

palette_list_push
(
	CHARACTER_AMY + PALETTE_DEMON,
	[ #884440, #582c28, #301818, #431a20, #260a0f, #632d33, #d6d6d6, #b3b3b3, #828282, #424242 ],
	[ #b35658, #882a3b, #4c101b, #97091c, #5b070a, #bf364a, #ddd0d0, #c1abaa, #83766d, #53524a ]
);


palette_list_push
(
	CHARACTER_CREAM,
	[ #eecba8, #e39c79, #c16b53, #fc8c04, #d5560b, #e00000, #800000, #e4e0e4, #c0c0e0, #a0a0c0, #606080, #202020, ],
	[ #f8e0b8, #e8c080, #987840, #f89000, #e05800, #f85800, #980000, #e4e0e4, #a5a5a5, #848484, #424242, #000000, ]
);

palette_list_push
(
	CHARACTER_CREAM,
	[ #eecba8, #e39c79, #c16b53, #fc8c04, #d5560b, #a3330e, #e00000, #800000, #f3bb10, #c46a09, #e4e0e4, #c0c0e0, #a0a0c0, #606080 ],
	[ #facb9c, #f69566, #dd5b37, #f89c00, #fa6000, #b80c00, #e70000, #800020, #f89c00, #dd5b37, #fcfcfc, #d8d8fc, #b4b4d8, #6c6c90 ]
);

palette_list_push
(
	CHARACTER_CREAM + PALETTE_DEMON,
	[ #793379, #4b214b, #341634, #771515, #470013, #1f000b, #431a20, #260a0f, #e4e0e4, #b3b3b3, #828282, #424242 ],
	[ #61315e, #3f2040, #291329, #960d19, #690000, #400000, #6e4435, #4d2d25, #ddd0d0, #c1abaa, #83766d, #53524a ]
);

palette_list_push
(
	CHARACTER_CREAM + PALETTE_DEMON,
	[ #793379, #4b214b, #341634, #771515, #470013, #1f000b, #431a20, #260a0f, #b3b3b3, #828282, #424242, #000000 ],
	[ #bb1a81, #7d1055, #520e40, #b91107, #97091c, #5b070a, #97091c, #5b070a, #c0c0e0, #a0a0c0, #606080, #212121 ]
);


palette_list_push
(
	CHARACTER_SALLY,
	[ #df7f22, #af631b, #7f4712, #f1be5f, #c3994c, #8b6c34, #6060e0, #3600ff, #2d008f, #c22313, #a21a0b, #721307 ],
	[ #c56b36, #985329, #71371c, #e0c080, #b09256, #695128, #60a0e0, #2060e0, #2040a0, #c43612, #a02000, #800000 ]
);

palette_list_push
(
	CHARACTER_SALLY,
	[ #df7f22, #af631b, #7f4712, #f1be5f, #c3994c, #8b6c34, #6060e0, #3600ff, #2d008f, #c22313, #a21a0b, #721307 ],
	[ #a3632b, #884c18, #69370c, #e9c094, #c48f76, #875741, #177aff, #2040c0, #202080, #e00020, #a00000, #620000 ]
);

palette_list_push
(
	CHARACTER_SALLY + PALETTE_DEMON,
	[ #68232a, #421216, #260006, #e49c79, #bb6d4e, #66281d, #474784, #202886, #1b1342, #740000, #400000, #1c0000, #470000, #910000, #963423 ],
	[ #955f4a, #6e4435, #4d2d25, #dab273, #a1845c, #5e4d36, #6b69ff, #2145d6, #21208c, #a62005, #690000, #400000, #400000, #a1845c, #a1845c ]
);

palette_list_push
(
	CHARACTER_SALLY + PALETTE_DEMON,
	[ #68232a, #421216, #260006, #e49c79, #bb6d4e, #66281d, #474784, #202886, #1b1342, #740000, #400000, #1c0000, #000000, #470000, #910000, #963423 ],
	[ #c56b36, #985329, #71371c, #e0c080, #ba9954, #755f2f, #4080c0, #2060a0, #204060, #c22313, #a21a0b, #721307, #202020, #a03219, #9a4827, #a76939 ]
);


palette_list_push
(
	EXE_ORIGINAL + PALETTE_EXE,
	[ #6b69ff, #2145d6, #21208c, #fffbff, #d6d7ff, #b5b2d6, #6b698c, #800000, #e00000 ],
	[ #6c6cd8, #4848b4, #242490, #e4e0e4, #b3b3b3, #828282, #424242, #5a0000, #b30000 ]
);

palette_list_push
(
	EXE_ORIGINAL + PALETTE_EXE,
	[ #6b69ff, #2145d6, #21208c, #ffb28c, #b56942, #fffbff, #d6d7ff, #b5b2d6, #6b698c, #ff0000, #940000, #800000, #e00000 ],
	[ #256ba9, #205a7a, #13374d, #e3b890, #a5826b, #ddd0d0, #c1abaa, #83766d, #53524a, #d1322e, #731c1a, #5a0000, #b30000 ]
);

palette_list_push
(
	EXE_CHAOS + PALETTE_EXE,
	[ #2c3974, #253060, #171f3c, #001b2e, #000e18, #058cf9, #2f608e, #463e8e, #0094ff ],
	[ #2c6d74, #255a60, #173a3c, #002e20, #001811, #05f9b7, #137373, #132d46, #05f9b7 ]
);

palette_list_push
(
	EXE_CHAOS + PALETTE_EXE,
	[ #2c3974, #253060, #171f3c, #001b2e, #000e18, #058cf9, #2f608e, #463e8e, #fffbff, #d6d7ff, #a0a0c0, #606080, #b5b2d6, #6b698c, #606080, #0094ff ],
	[ #742c40, #602536, #3c1723, #2e0000, #170000, #ff0000, #940000, #2e0000, #ddd0d0, #c1abaa, #83766d, #53524a, #c1abaa, #83766d, #53524a, #ff0000 ]
);

palette_list_push
(
	EXE_EXETIOR + PALETTE_EXE,
	[ #003f99, #01316a, #011535, #f2c4b5, #99766c ],
	[ #0e38a3, #110b9f, #000f55, #e0a080, #a06040 ]
);

palette_list_push
(
	EXE_EXETIOR + PALETTE_EXE,
	[ #011535, #6b698c, #300909, #940001, #ff0000, #01316a, #99766c, #cc0005, #ff0001, #b8b8d8, #003f99, #f2c4b5, #d8d8f8, #fcfcfc, #222222, #ff3338, #940000, #604239 ],
	[ #3d0065, #3d0065, #3d0065, #3d0065, #0c0031, #0c0031, #0c0031, #0c0031, #0c0031, #0c0031, #000000, #000000, #000000, #000000, #000000, #7300bf, #3d0065, #3d0065 ]
);

palette_list_push
(
	EXE_EXELLER + PALETTE_EXE,
	[ #177aff, #0f47c0, #102676, #f2a572, #b2622d ],
	[ #6b69ff, #2145d6, #21208c, #ffb28c, #b56942 ]
);

palette_list_push
(
	EXE_EXELLER + PALETTE_EXE,
	[ #177aff, #0f47c0, #102676, #f2a572, #b2622d, #c40000 ],
	[ #353867, #292d50, #1c1f37, #c1bdb8, #898781, #800000 ] 
);

function palette_list_push(char, from, to)
{
	if(!ds_map_exists(global.palettes, char))
		ds_map_add(global.palettes, char, []);
	
	array_push(global.palettes[? char], { from: scr_palette(from), to: scr_palette(to) });
}

function scr_palette(array)
{
	palette = [];
	
	for(var i = 0; i < array_length(array); i++)
	{
		array_push(palette, color_get_red(array[i]) / 255.0);
		array_push(palette, color_get_green(array[i]) / 255.0);
		array_push(palette, color_get_blue(array[i]) / 255.0);
		array_push(palette, 1.0);
	}
	
	return palette;
}