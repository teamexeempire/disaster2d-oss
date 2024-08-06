if(target == global.player)
	scr_palette_swap(obj_unlockables.petPallettes[? 5].from, obj_unlockables.petPallettes[? 5].to);
else
	scr_palette_swap(target.petFromPallete, target.petToPallete);

draw_self();
shader_reset();