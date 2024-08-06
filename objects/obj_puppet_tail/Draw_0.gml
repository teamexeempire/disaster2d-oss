if(!instance_exists(target))
	return;

scr_palette_swap(target.fromPallete, target.toPallete);
draw_self();
shader_reset();