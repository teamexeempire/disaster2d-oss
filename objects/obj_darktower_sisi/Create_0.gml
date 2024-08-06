depth = 101;
image_alpha = 0;

nid = 0;
damage = false;
dying = false;

emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);

_destroy = function()
{
	if(dying)
		return;
		
	audio_play_sound_on(emitter, snd_snowball_break, false, 0);
	for(var i = 0; i < 2; i++)
	{
		var inst = instance_create_depth(x + 40 + irandom_range(-4, 4), y + irandom_range(-10, 10), -20, obj_darktower_sisipart);
		inst.xspd = 1 - i/10.0;
		inst.yspd = -choose(4, 5, 6, 7);
		inst.dir = -1;
	}
	
	for(var i = 0; i < 2; i++)
	{
		var inst = instance_create_depth(x + 40 + irandom_range(-4, 4), y + irandom_range(-10, 10), -20, obj_darktower_sisipart);
		inst.xspd = 1 + i/10.0;
		inst.yspd = -choose(4, 5, 6, 7);
		inst.dir = 1;
	}
	
	alarm[0] = 60;
	visible = false;
	dying = true;
}