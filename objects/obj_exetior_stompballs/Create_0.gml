dir = -1;
cnt = 0;
image_index = 0;

target = noone;
if(global.character != CHARACTER_EXE)
{
	if(!instance_exists(obj_player_puppet))
		return;
	
	var _tg = noone;
	with(obj_player_puppet)
	{
		if(character != CHARACTER_EXE)
			continue;
			
		_tg = self;
	}
	
	target = _tg;
}
else
{
	if(global.palleteName == "menace")
		image_blend = #ae57ff;
}

if(target != noone)
{
	if(target.palleteName == "menace")
		image_blend = #ae57ff;
}

if(room == room_act9)
	image_blend = c_dkgray;
	
emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

expsid = scr_audio_play_3d(emitter, snd_exetior_shockwave, 0, false);