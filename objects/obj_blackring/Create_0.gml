nid = 0;
image_alpha = 0;
depth = -202;
used = false;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);
scr_audio_play_3d(emitter, snd_blackring_ball, true, 0);

var gain = 1.0 - (min(distance_to_point(obj_camera.x+213, obj_camera.y + 120), 400) / 400.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(room == room_act9)
	image_blend = c_dkgray;