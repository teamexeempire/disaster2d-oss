nid = 0;
state = 0;
image_alpha = 0;
dead = false;
isDead = false;
timer = 10;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);

function destroy()
{
	state = 10;
	image_index = 0;
	sprite_index = spr_ravinemist_sonicdead;
	scr_audio_play_3d(emitter, snd_slime, 0, false);
	isDead = true;
}