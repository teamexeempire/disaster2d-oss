if(!visible)
	return;

if(!instance_exists(global.player))
	return;
	
draw_sprite_ext(spr_indicator, 0, ceil(global.player.x-obj_camera.x), ceil(global.player.y-obj_camera.y), 1, 1, image_angle, c_white, 1);