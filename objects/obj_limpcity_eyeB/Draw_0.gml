draw_sprite(sprite_index, image_index, x, y);
	
if(used)
{
	var dist = 512;
	var inst = noone;
	var inst2 = instance_nearest(x, y, global.player);
	
	var _this = self;
	with(obj_player_puppet)
	{
		if(!visible)
			continue;
			
		var dst = point_distance(_this.x, _this.y, x, y);
		if(dst < dist)
		{
			dist = dst;
			inst = self;
		}
	}
	
	var res = noone;
	
	if(inst == noone && inst2 != noone)
		res = inst2;
	else if(inst2 == noone && inst != noone)
		res = inst;
	else if(inst != noone && inst2 != noone)
	{
		var d1 = point_distance(x, y, inst.x, inst.y);
		var d2 = point_distance(x, y, inst2.x, inst2.y);
		
		if(d1 < d2)
			res = inst;
		else
			res = inst2;
	}
	
	var angle = 0;
	var found = false;
	
	if(res != noone)
	{
		if(point_distance(x, y, res.x, res.y) < 270)
		{
			angle = point_direction(x, y, res.x, res.y);
			found = true;
		}
		else
			angle = 0;
	}
	
	draw_sprite_ext(found ? spr_limpcity_eyelid : spr_limpcity_eye_recharge, 5, x, y, 1, 1, angle, c_white, image_alpha);
}