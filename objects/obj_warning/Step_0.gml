if(!instance_exists(global.player))
	return;
	
var dist = distance_to_object(global.player);
image_alpha = (48 - clamp(dist, 0, 48)) / 48.0