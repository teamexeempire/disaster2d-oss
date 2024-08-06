active = false;
frame = 0;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);

targetX = x;
targetY = y + sprite_width/2;
light = instance_create_depth(x, y + sprite_height + 33/2, -401, obj_weed_light);