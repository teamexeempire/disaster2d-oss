if(!instance_exists(obj_camera))
	return;

visible = distance_to_point(obj_camera.x+240, obj_camera.y+135) < 480;