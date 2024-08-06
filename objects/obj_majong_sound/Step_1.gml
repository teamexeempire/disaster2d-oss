if(!instance_exists(obj_camera))
	return;

if(!audio_is_playing(esndid))
{
	instance_destroy();
	return;
}

if(!audio_emitter_exists(tEmitter))
{
	instance_destroy();
	return;
}

var xPos = 0;
var _x = audio_emitter_get_x(tEmitter);
var _y = audio_emitter_get_y(tEmitter);
		
if(_x < 512)
	xPos = _x + (room_width - 512);	
else if(_x >= room_width - 512)
	xPos = _x - (room_width - 512);

if(xPos == 0)
	return;

var gain = 1.0 - (min(point_distance(xPos, _y, obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, xPos, _y, 0);
audio_emitter_gain(emitter, gain);