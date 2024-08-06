if(target == global.player)
	scr_palette_swap(obj_unlockables.petPallettes[? 4].from, obj_unlockables.petPallettes[? 4].to);
else
	scr_palette_swap(target.petFromPallete, target.petToPallete);

draw_self();
shader_reset();