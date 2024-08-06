y = sY + sin(current_time / 400) * 2;

if(!instance_exists(obj_camera))
	return;

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);