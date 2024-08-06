/*
	КАК ИСПОЛЬЗОВАТЬ:
	в коде создания комнаты сделать лист всех слоев и их скоростей:
	
	формат:
	[ id слоя, х-скорость, у-скорость, y offset (опцианально) ]
	
	пример:
	global.parallax = 
	[
		[ layer_get_id("Background"), 0.3, 0 ]
	];
*/
for(var i = 0; i < array_length(global.parallax); i++)
{
	var lay = global.parallax[i][0];
	var xspd = global.parallax[i][1];
	var yspd = global.parallax[i][2];
	
	var cx, cy;
	if(array_length(global.parallax[i]) > 3)
	{
		var yoff = global.parallax[i][3];
		
		cx = camera_get_view_x(view_camera[0]);
		cy = camera_get_view_y(view_camera[0]) + yoff;
	}
	else
	{
		cx = camera_get_view_x(view_camera[0]);
		cy = camera_get_view_y(view_camera[0]);
	}
	
	layer_x(lay, cx * xspd);
	layer_y(lay, cy * yspd);
}