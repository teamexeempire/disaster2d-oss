canStuck = false;
state = false;
sY = y;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);