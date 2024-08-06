sY = y;
sS = random_range(0, 25);

image_alpha = 0;
exists = false;
for (var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k)) 
{
	var plr = ds_map_find_value(obj_netclient.players, k);
	
	if(plr.character - 1 == image_index)
		exists = true;
}

if(global.character - 1 == image_index)
	exists = true;