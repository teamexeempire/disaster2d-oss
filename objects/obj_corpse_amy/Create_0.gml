char = CHARACTER_AMY;
exists = false;
for (var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k)) 
{
	var plr = ds_map_find_value(obj_netclient.players, k);
	
	if(plr.character == char)
		exists = true;
}