draw_self();

if(side)
{
	for(var i = 0; i < array_length(particls2); i++)
	{
		var arr = particls2[i];
		
		arr.x = arr.sx + sin(current_time / 400 + i) * 2;
		arr.y--;
		
		if(arr.y <= -16)
			arr.y = 286 + irandom_range(0, 32);
			
		draw_sprite(background_notperf2, bigrig, arr.x + xx , arr.y + yy);
	}
	return;
}

for(var i = 0; i < array_length(particls); i++)
{
	var arr = particls[i];
	
	arr.x--;
	
	if(arr.x <= -64)
		arr.x = 500;
	
	draw_sprite(background_notperf3, bigrig, arr.x + xx, arr.y + yy);
}