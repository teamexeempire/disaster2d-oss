if(!layer_get_visible(layer_get_id("OptionsControlsMobile")))
	return;
	
switch(bid)
{
	case 1:
		x = obj_config.bAX;
		y = obj_config.bAY;
		scale = obj_config.bAScale;
		image_alpha = obj_config.bAOpacity;
		break;
		
		
	case 2:
		x = obj_config.bBX;
		y = obj_config.bBY;
		scale = obj_config.bBScale;
		image_alpha = obj_config.bBOpacity;
		break;
		
	case 3:
		x = obj_config.bCX;
		y = obj_config.bCY;
		scale = obj_config.bCScale;
		image_alpha = obj_config.bCOpacity;
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
		
		if(scale > 1.5)
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
	
	var _self = self;
	with(obj_menu_mobilebutton)
		if(_self != self)
			dragTime = 0;
	
	with(obj_menu_mobilebutton2)
		dragTime = 0;
	
	with(obj_menu_mobiledpad)
		dragTime = 0;
}