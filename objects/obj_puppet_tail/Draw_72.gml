if(!instance_exists(target))
	return;
	
image_alpha = (target.isHurt || target.isHiding) ? 0.5 : target.image_alpha;
if(room == room_act9)
	image_blend = c_black;