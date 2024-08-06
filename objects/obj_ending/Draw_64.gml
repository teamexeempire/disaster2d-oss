if(fade < 0.5)
	fade += 0.01;

draw_sprite_ext(spr_black, 0, 0, 0, 1, 1, 0, c_white, fade);
draw_sprite_ext(sprite_index, floor(current_time / 100) % image_number, 480/2, 270/2, 1.5-fade, 1.5-fade, 0, c_white, fade * 2);