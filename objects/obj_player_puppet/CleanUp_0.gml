audio_emitter_free(emitter);

if(reviveObj != noone)
	instance_destroy(reviveObj);
	
if(healObj != noone)
	instance_destroy(healObj);