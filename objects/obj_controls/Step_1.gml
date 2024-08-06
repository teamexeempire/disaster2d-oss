if(instance_exists(obj_level) && keyboard_check_pressed(global.KeyHide))
	global.showHud = !global.showHud;

if(isMobile)
	scr_controls_update_touch();
if(gamepadSupport)
	scr_controls_update_gamepad();
	
if(keyboard_check_pressed(vk_f4))
{
	if(window_get_fullscreen())
	{
		obj_config.screenMode = prevScreenMode;
		obj_config.applyRes();
		obj_config.save();
	}
	else
	{
		prevScreenMode = obj_config.screenMode;
		obj_config.screenMode = 3;
		obj_config.applyRes();
		obj_config.save();
	}
}