if(!instance_exists(global.player) || obj_netclient.gameEnds)
	return;
	
var width = window_get_width();
var height = window_get_height();

shader_set(shd_inverse);
shader_set_uniform_f(point, posX - obj_camera.x, posY - obj_camera.y);
shader_set_uniform_f(scale, width / 480., height / 270.0);
shader_set_uniform_f(radius, size);

if(os_type == os_android)
{
	var aspect_ratio = width / height;
	var view_w = 480;
	var view_h = 270;
	var view_aspect_ratio = view_w / view_h;

	if (aspect_ratio > view_aspect_ratio) 
	{
		var _scale = height / view_h;
		var draw_w = view_w * _scale;
		var draw_h = height;
		var draw_x = (width - draw_w) / 2;
		var draw_y = 0;
		draw_surface_stretched(application_surface, draw_x, draw_y, draw_w, draw_h);
	} 
	else
	{
		var _scale = width / view_w;
		var draw_w = width;
		var draw_h = view_h * _scale;
		var draw_x = 0;
		var draw_y = (height - draw_h) / 2;
		draw_surface_stretched(application_surface, draw_x, draw_y, draw_w, draw_h);
	}
}
else
	draw_surface_stretched(application_surface, 0, 0, width, height);

shader_reset();