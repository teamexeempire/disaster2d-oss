draw_sprite_ext(spr_redring_fore, current_time / 200, 0, 0, 1, 1, 0, c_white, 0.4);
	
if(current_time % irandom_range(20, 24) <= 10)
{
	var xx = random_range(-4, 4);
	var xx2 = random_range(- 60,  60);
	
	var ass = camera_get_view_x(view_camera[0]);
	var ass2 = camera_get_view_y(view_camera[0]);
	
	camera_set_view_pos(view_camera[0], ass - xx2, ass2 - xx2);
	camera_set_view_size(view_camera[0], 480 + xx2, 270 + xx2);
	
	draw_sprite_stretched(spr_darktower_jumpscare, xx, xx, 0, 480, 270);
}