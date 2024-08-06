if(blackwhite)
	shader_set(shd_blackwhite);

var w = side ? sprite_get_height(mapData[map].tiles[index]) : sprite_get_width(mapData[map].tiles[index]);

scroll += 0.64 + 0.16;

if(map == 7)
	scroll -= 0.38;

if(scroll <= 56)
	image_alpha = scroll / 32.0;

var cc = side ? 270 : 480;
if(scroll >= w - (cc+48))
	image_alpha = 1.5 - ((scroll - (w - (cc+48))) / 32.0);
	
if(scroll > w - cc)
{
	scroll = 0;
	index++;
	
	if(index >= array_length(mapData[map].tiles))
		index = 0;
		
	side = mapData[map].side[index];
}

if(side)
{
	var bgW = sprite_get_width(mapData[map].bg);
	var bgH = sprite_get_height(mapData[map].bg);
	
	for(var i = 0; i < 480 / bgW + 2; i++)
	{
		for(var j = 0; j < 270 / bgH + 2; j++)
		{
			draw_sprite_ext(mapData[map].bg, current_time / 100, i * bgW, -scroll / 10.0 + j * bgH, 1, 1, 0, image_blend, image_alpha - 0.5); 
		}
	}
}
else
{
	var bgW = sprite_get_width(mapData[map].bg);
	var bgH = sprite_get_height(mapData[map].bg);
	
	for(var i = 0; i < 480 / bgW + 2; i++)
	{
		for(var j = 0; j < 270 / bgH + 2; j++)
		{
			draw_sprite_ext(mapData[map].bg, current_time / 100, -scroll / 10.0 + i * bgW, j * bgH, 1, 1, 0, image_blend, image_alpha - 0.5); 
		}
	}
}	

if(map != 20)
{
	if(side)
		draw_sprite_ext(mapData[map].tiles[index], 0, 0, -scroll, 1, 1, 0, image_blend, image_alpha);
	else
		draw_sprite_ext(mapData[map].tiles[index], 0, -scroll, 0, 1, 1, 0, image_blend, image_alpha);
}

if(blackwhite)
	shader_reset();