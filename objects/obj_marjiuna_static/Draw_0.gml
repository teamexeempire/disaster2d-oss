if(fade < 1)
	fade += 0.016;
else
	fade = 1;

draw_sprite_ext(spr_static, image_index, obj_camera.x, obj_camera.y, 1, 1, 0, c_white, fade * 0.1);