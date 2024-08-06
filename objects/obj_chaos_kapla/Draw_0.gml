if(target == noone)
	scr_palette_swap(global.palleteFrom, global.palleteTo);
else
	scr_palette_swap(target.fromPallete, target.toPallete);

draw_self();
shader_reset();