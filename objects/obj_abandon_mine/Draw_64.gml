if(global.timeMinutes > 0 || !obj_netclient.isServerReady)
	image_alpha = 0;
else
{
	if(image_alpha < 1)
		image_alpha += 0.016 / 60;
}

draw_self();