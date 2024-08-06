activated = false;
shouldFade = false;
pid = 0;
image_alpha = 0;
depth = -2;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);