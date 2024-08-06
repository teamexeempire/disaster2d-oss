if(!active)
	image_index = 0;
else
	image_index = floor(current_time / 50) % 2;

if(!instance_exists(global.player))
	return;
	
if(place_meeting(x, y, global.player) && active)
	scr_player_hurt(20, -global.player.image_xscale * 4);