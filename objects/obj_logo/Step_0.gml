if(device_mouse_check_button_pressed(0, mb_any))
{
	ind = image_number;
	alarm[0] = 1;
	audio_stop_all();
}