if(!instance_exists(obj_tails))
	return;
	
image_alpha = (global.player.hurttime > 0 || global.player.isHiding) ? 0.5 : obj_tails.image_alpha;
if(room == room_act9)
	image_blend = c_black;