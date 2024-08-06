function scr_controls_update_gamepad()
{	
	if(gamepadId == -1)
	{
		for(var i = 0; i < 10; i++)
		{
			if(gamepad_is_connected(i))
			{
				gamepadId = i;
				gamepad_set_axis_deadzone(gamepadId, 0.5);
				break;
			}
		}
	}
	
	if(gamepadId != -1)
	{
		if(!gamepad_is_connected(gamepadId))
		{
			gamepadId = -1;
			return;
		}
		
		if(!useGamepad)
		{
			if(gamepad_button_check_pressed(gamepadId, gp_face1))
				useGamepad = true;
			
			if(gamepad_button_check_pressed(gamepadId, gp_face2))
				useGamepad = true;
				
			if(gamepad_button_check_pressed(gamepadId, gp_face3))
				useGamepad = true;
				
			if(gamepad_button_check_pressed(gamepadId, gp_face4))
				useGamepad = true;
			
			if(useGamepad)
				isMobile = false;
			
			return;
		}
		
		var _xAxis = gamepad_axis_value(gamepadId, gp_axislh);
		var _yAxis = gamepad_axis_value(gamepadId, gp_axislv);
		
		if(_xAxis > 0)
		{
			if(!keyboard_check(vk_right))
				keyboard_key_press(vk_right);
		}
		else if(_xAxis < 0)
		{
			if(!keyboard_check(vk_left))
				keyboard_key_press(vk_left);
		}
		else
		{
			if(keyboard_check(vk_left))
				keyboard_key_release(vk_left);
				
			if(keyboard_check(vk_right))
				keyboard_key_release(vk_right);
		}
		
		if(_yAxis > 0)
		{
			if(!keyboard_check(vk_down))
				keyboard_key_press(vk_down);
		}
		else if(_yAxis < 0)
		{
			if(!keyboard_check(vk_up))
				keyboard_key_press(vk_up);
		}
		else
		{
			if(keyboard_check(vk_down))
				keyboard_key_release(vk_down);
				
			if(keyboard_check(vk_up))
				keyboard_key_release(vk_up);
		}
		
		if(gamepad_button_check_pressed(gamepadId, gp_face1))
			keyboard_key_press(global.KeyA);
			
		if(gamepad_button_check_pressed(gamepadId, gp_face2))
			keyboard_key_press(global.KeyB);
			
		if(gamepad_button_check_pressed(gamepadId, gp_face3))
			keyboard_key_press(global.KeyC);
			
		if(gamepad_button_check_pressed(gamepadId, gp_start))
			keyboard_key_press(vk_enter);
			
		if(gamepad_button_check_pressed(gamepadId, gp_shoulderlb))
			keyboard_key_press(global.KeyPList);
			
		if(gamepad_button_check_pressed(gamepadId, gp_shoulderrb))
			keyboard_key_press(global.KeyHide);
			
		if(gamepad_button_check_pressed(gamepadId, gp_padu))
			keyboard_key_press(global.KeyEm1);
			
		if(gamepad_button_check_pressed(gamepadId, gp_padr))
			keyboard_key_press(global.KeyEm2);
			
		if(gamepad_button_check_pressed(gamepadId, gp_padl))
			keyboard_key_press(global.KeyEm2);
			
		if(gamepad_button_check_pressed(gamepadId, gp_padd))
			keyboard_key_press(global.KeyEm3);
			
			
		if(gamepad_button_check_released(gamepadId, gp_face1))
			keyboard_key_release(global.KeyA);
			
		if(gamepad_button_check_released(gamepadId, gp_face2))
			keyboard_key_release(global.KeyB);
			
		if(gamepad_button_check_released(gamepadId, gp_face3))
			keyboard_key_release(global.KeyC);
			
		if(gamepad_button_check_released(gamepadId, gp_start))
			keyboard_key_release(vk_enter);
			
		if(gamepad_button_check_released(gamepadId, gp_shoulderlb))
			keyboard_key_release(global.KeyPList);
			
		if(gamepad_button_check_released(gamepadId, gp_shoulderrb))
			keyboard_key_release(global.KeyHide);
			
		if(gamepad_button_check_released(gamepadId, gp_padu))
			keyboard_key_release(global.KeyEm1);
			
		if(gamepad_button_check_released(gamepadId, gp_padr))
			keyboard_key_release(global.KeyEm2);
			
		if(gamepad_button_check_released(gamepadId, gp_padl))
			keyboard_key_release(global.KeyEm2);
			
		if(gamepad_button_check_released(gamepadId, gp_padd))
			keyboard_key_release(global.KeyEm3);
	}
}