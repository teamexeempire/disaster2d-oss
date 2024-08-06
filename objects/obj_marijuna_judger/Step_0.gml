var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

image_index = state > 0;
if(state == 2)
{
	if(timer % 6 == 0)
	{
		var _xscale = -40;
		if(image_xscale > 0)
			_xscale = 30;
			
		var _inst = instance_create_depth(x + _xscale, y - 4, depth+1, obj_marijuna_judgerpor);
		_inst.dir = image_xscale;
	}
	
	if(timer % 15 == 0)
		audio_play_sound_on(emitter, snd_lavahit, false, 0);
		
	timer++;
}