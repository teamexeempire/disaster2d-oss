if(!global.init)
{
	global.init = true;
}
else
{
	room_goto(room_menu);
	return;
}

display_reset(0, true);
start = false;
ind = 0;

if(os_type == os_android)
{
	surface_resize(application_surface, 480, 270);
	window_set_size(480, 270);
	window_set_fullscreen(true);
}

image_speed = 0;