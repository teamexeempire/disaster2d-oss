// Create event
surf = -1;

point = shader_get_uniform(shd_inverse, "u_point");
scale = shader_get_uniform(shd_inverse, "u_scale");
radius = shader_get_uniform(shd_inverse, "u_radius");
posX = 0;
posY = 0;
size = 0;
acc = 0.016 * 400;
staticFade = 0

left = global.KeyLeft;
right = global.KeyRight;
up = global.KeyUp;
down = global.KeyDown;

swapControls = function(sec, xx, yy)
{
	with(obj_marijuna_crystalcontroller)
	{
		if(alarm[0] > 0)
			return;
	
		audio_play_sound(snd_boohoo, 0, false);
		net_sound_emit(snd_boohoo);
		
		size = 0;
		acc = 0.016 * 400;
		posX = xx;
		posY = yy;
		global.KeyLeft = right;
		global.KeyRight = left;
		global.KeyUp = down;
		global.KeyDown = up
		alarm[0] = sec * 60;
	}
}

depth = -1;
application_surface_draw_enable(false);