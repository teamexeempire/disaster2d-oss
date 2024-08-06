x = sx + random_range(-3, 3);
y = sy + random_range(-3, 3);

if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player) && !obj_fart_controller.potater)
{	
	obj_fart_controller.potater = true;
	obj_fart_controller.potatoTimer = 60 * 4;
}