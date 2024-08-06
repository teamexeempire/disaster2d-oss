if(!instance_exists(obj_camera))
	return;
	
layer_x("Foguis", camera_get_view_x(view_camera[0]) + scroll);
layer_y("Foguis", camera_get_view_y(view_camera[0]));

scroll += 2;