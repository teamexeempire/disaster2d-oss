if(image_xscale < 1)
	image_xscale += 0.2;

if(offset > 0)
	offset -= 0.2;

if(obj_netclient.nid == master_id)
{
	x = 240;
	y = 115;
	aY = 115;
	
	if(obj_lobby.state == 0 && obj_lobby.isReady != isReady)
	{
		if(obj_lobby.isReady)
		{
			offset = 3;
			image_blend = c_lime;
		}
		else
		{
			offset = 3;
			image_blend = c_white;
		}
		
		isReady = obj_lobby.isReady;
	}
		
	
	visible = true;
	return;
}

var i = 0;
for (var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k))
{
	var player = obj_netclient.players[? k];
	
	if(player.pending)
		continue;
	
	if(player.nid == master_id)
	{			
		x = 40 + i * 80;
		y = 58;
		
		if(player.isReady)
			image_blend = c_lime;
		else
			image_blend = c_white;
			
		if(obj_lobby.state == 0 && player.isReady != isReady)
		{
			if(player.isReady)
				offset = 3;
			else
				offset = 3;
			
			isReady = player.isReady;
		} 
		else if(obj_lobby.state != 0)
			image_blend = isSelected ? c_white : c_grey;
		
		visible = true;	
	}
	i++;
}