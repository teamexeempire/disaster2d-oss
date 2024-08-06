if(effectTime > 0)
{
	effectTime--;
	
	if(effectTime % irandom_range(5, 6) == 0)
		instance_create_depth(x, y + irandom_range(-8, 8), depth+10, obj_chaos_kapla);
	
	if(effectTime % 3 == 0)
	{
		var inst = scr_effect_fade_quick(x, y, sprite_index);
		inst.image_xscale = image_xscale;
		inst.image_index = image_index;
		inst.image_speed = 0;
		inst.depth = depth+10;
		inst.palleteFrom = global.palleteFrom;
		inst.palleteTo = global.palleteTo;
	}
}

//Actual draw
scr_palette_swap(global.palleteFrom, global.palleteTo);

var _angle = isSpinning ? 0 : radtodeg(angle);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, _angle, image_blend, (hurttime > 0 || isHiding || shockedTimer > 0) ? 0.5 : image_alpha);
shader_reset();

//hakc
if(isDead)
{
	xspd = 0;
	gspd = 0;
	return;
}