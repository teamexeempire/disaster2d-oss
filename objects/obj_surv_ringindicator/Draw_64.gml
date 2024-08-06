if(!visible)
	return;

if(instance_exists(global.player))
{
	var _x = global.player.x;
	var _y = global.player.y;
	
	draw_sprite_ext(spr_sindicator2, 0, ceil(_x-obj_camera.x), ceil(_y-obj_camera.y), 1, 1, image_angle, c_white, 1);
}