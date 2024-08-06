if(!instance_exists(global.player))
	return;
	
if(potater)
{
	draw_sprite(spr_goodperson, potatoTimer / 60, global.player.x, global.player.y);
	global.player.sprite_index = spr_merfurmu;
}