var gain = 1.0 - (min(distance_to_point(obj_camera.x + 240, obj_camera.y + 135), 700) / 700.0);
audio_emitter_position(emitter, x, y-16, 0);
audio_emitter_gain(emitter, gain);