if(!visible)
	return;

if(instance_exists(global.player))
{
	var pos = 25;
	
	switch(global.character)
	{
		case CHARACTER_TAILS:
		case CHARACTER_CREAM:
			pos = 20;
			break;
			
		case CHARACTER_EGGMAN:
			pos = 36;
			break;
	}
	
	var _x = global.player.x;
	var _y = global.player.y;
	
	draw_sprite_ext(spr_indicator2, 0, ceil(_x-obj_camera.x), ceil(_y-obj_camera.y) - pos - 9, 1, 1, image_angle, c_white, 1);
}