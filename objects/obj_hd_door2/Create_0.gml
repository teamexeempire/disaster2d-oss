canStuck = false;
state = false;
sX = x;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);