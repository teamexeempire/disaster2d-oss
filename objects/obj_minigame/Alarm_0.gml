layer_set_visible("Minigame", false);
layer_set_visible("Minigame2", false);

layer = layer_get_id("UI");
obj_minisnoc.hspeed = 0;
obj_minisnoc.vspeed = 0;
obj_minisnoc.dead = false;
ingame = false;

with(obj_asteroid)
	instance_destroy();
	
with(obj_asteroid_breakable)
	instance_destroy();
	
scr_play_music(mus_waiting);