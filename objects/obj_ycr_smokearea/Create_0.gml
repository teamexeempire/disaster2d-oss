nid = 0;
timer = 0;
overlaps = false;
activated = false;
emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);