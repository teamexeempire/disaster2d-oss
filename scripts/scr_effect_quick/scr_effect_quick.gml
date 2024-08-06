//
// Spawns effect
//
function scr_effect_quick(xx, yy, effSpr, effSpeed=0.5, fade = false, xspd = 0, yspd = 0)
{
	if(fade)
	{
		var inst = instance_create_depth(xx, yy, 0, obj_quickeffect_fade);
		inst.sprite_index = effSpr;
		inst.fadeSpeed = effSpeed;
		inst.hspeed = xspd;
		inst.vspeed = yspd;
		
		if(room == room_act9)
			inst.image_blend = c_black
			
		return inst;
	}
	else
	{
		var inst = instance_create_depth(xx, yy, 0, obj_quickeffect);
		inst.sprite_index = effSpr;
		inst.image_speed = effSpeed;
		inst.hspeed = xspd;
		inst.vspeed = yspd;
		
		if(room == room_act9)
			inst.image_blend = c_black;
			
		return inst;
	}
}

//
// Spawns effect with fade
//
function scr_effect_fade_quick(xx, yy, effSpr, effSpeed=0.05)
{
	var inst = instance_create_depth(xx, yy, 0, obj_quickeffect_fade);
	inst.sprite_index = effSpr;
	inst.fadeSpeed = effSpeed;
	
	if(room == room_act9)
		inst.image_blend = c_black;
	
	return inst;
}