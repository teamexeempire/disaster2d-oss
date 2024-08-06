function scr_audio_play_3d(emitter, soundid, loops, priority)
{	
	var inst = audio_play_sound_on(emitter, soundid, loops, priority);
	
	if(room == room_majongforest)
	{
		var xPos = 0;
		var _x = audio_emitter_get_x(emitter);
		var _y = audio_emitter_get_y(emitter);
		
		if(_x < 512)
			xPos = _x + (room_width - 512);	
		else if(_x >= room_width - 512)
			xPos = _x - (room_width - 512);
		
		if(xPos == 0)
			return inst;
		
		var _inst = instance_create_depth(xPos, _y, 0, obj_majong_sound);
		_inst.emitter = audio_emitter_create();
		_inst.tEmitter = emitter;
		audio_emitter_falloff(_inst.emitter, 250, 500, 1);

		var gain = 1.0 - (min(point_distance(xPos, _y, obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
		audio_emitter_position(_inst.emitter, xPos, _y, 0);
		audio_emitter_gain(_inst.emitter, gain);
		
		_inst.esndid = audio_play_sound_on(_inst.emitter, soundid, loops, priority);
	}
	
	return inst;
}