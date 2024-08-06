if(!layer_get_visible(layer_get_id("OptionsControlsMobile")))
	return;

x = obj_config.dpadX;
y = obj_config.dpadY;
scale = obj_config.jScale;
image_alpha = obj_config.jOpacity;

if(mouse_check_button(mb_any))
{	
	if(dragTime < 20 && position_meeting(mouse_x, mouse_y, self))
	{
		dragTime++;
	}
}
else dragTime = 0;

if(mouse_check_button_released(mb_any) && position_meeting(mouse_x, mouse_y, self))
{
	obj_menu.mobSelectedButton = 0;
	obj_menu_slider.value = image_alpha;
	tapCount++;
	
	if(tapCount >= 2)
	{
		scale += .5;
		
		if(scale > 1.5)
			scale = .5;
		obj_controls.buttonSetProp(0, scale, image_alpha);
		tapCount = 0;
	}
	
	tapTimer = 10;
}

if(tapTimer > 0)
	tapTimer--;
else
	tapCount = 0;

if(dragTime >= 20)
{
	obj_controls.buttonSetPos(0, mouse_x, mouse_y);
	
	with(obj_menu_mobilebutton)
		dragTime = 0;
	
	with(obj_menu_mobilebutton2)
			dragTime = 0;
	
	var _self = self;
	with(obj_menu_mobiledpad)
		if(_self != self)
			dragTime = 0;
	
}