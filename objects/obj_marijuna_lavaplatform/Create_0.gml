canStuck = false;
timer = 0;
state = 0;
prevState = 0;
targetY = 0;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);
scr_audio_play_3d(emitter, snd_lava, true, 0);