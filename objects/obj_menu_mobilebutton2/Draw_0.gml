if(!layer_get_visible(layer_get_id("OptionsControlsMobile")))
	return;

switch(bid)
{
	case 4:
		x = obj_config.bDX;
		y = obj_config.bDY;
		scale = obj_config.bDScale;
		image_alpha = obj_config.bDOpacity;
		break;
		
	case 5:
		x = obj_config.bEX;
		y = obj_config.bEY;
		scale = obj_config.bEScale;
		image_alpha = obj_config.bEOpacity;
		break;
		
	case 6:
		x = obj_config.bFX;
		y = obj_config.bFY;
		scale = obj_config.bFScale;
		image_alpha = obj_config.bFOpacity;
		break;
		
	case 7:
		x = obj_config.bGX;
		y = obj_config.bGY;
		scale = obj_config.bGScale;
		image_alpha = obj_config.bGOpacity;
		break;
		
	case 8:
		x = obj_config.bWX;
		y = obj_config.bWY;
		scale = obj_config.bWScale;
		image_alpha = obj_config.bWOpacity;
		break;
}

if(mouse_check_button_released(mb_any) && position_meeting(mouse_x, mouse_y, self))
{
	obj_menu.mobSelectedButton = bid;
	obj_menu_slider.value = image_alpha;
	tapCount++;
	
	if(tapCount >= 2)
	{
		scale += .5;	
		
		if(scale >= 2)
			scale = .5;
			
		obj_controls.buttonSetProp(bid, scale, image_alpha);
		tapCount = 0;
	}
	
	tapTimer = 10;
}

if(tapTimer > 0)
	tapTimer--;
else
	tapCount = 0;
	
if(mouse_check_button(mb_any))
{	
	if(dragTime < 20 && position_meeting(mouse_x, mouse_y, self))
		dragTime++;
}
else dragTime = 0;

if(dragTime >= 20)
{
	obj_controls.buttonSetPos(bid, mouse_x, mouse_y);
	
	with(obj_menu_mobilebutton)
		dragTime = 0;
	
	var _self = self;
	with(obj_menu_mobilebutton2)
		if(_self != self)
			dragTime = 0;
	
	with(obj_menu_mobiledpad)
		dragTime = 0;
}