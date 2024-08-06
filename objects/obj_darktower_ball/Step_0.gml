if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player))
	scr_player_hurt(20, -global.player.image_xscale * 4);