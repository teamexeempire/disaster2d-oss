draw_self();
draw_sprite_ext(spr_weed_latern, frame, targetX, targetY, 1, 1, image_alpha, c_white, 1);

if(active)
	draw_sprite(spr_weed_light, current_time / 500, targetX, targetY + 33/2); 