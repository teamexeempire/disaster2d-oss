if(!electro)
	return;

for(var i = 0; i < (bbox_right - bbox_left) / 97 + 1; i++)
{
	draw_sprite(spr_ghz_electroshock, current_time / 45, i * 97, bbox_top);
}