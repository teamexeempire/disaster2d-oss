if(ground)
{
	if(cY == -1)
		cY = y;
		
	y = cY + sin(current_time / 200) * 3;
}

if(instance_exists(global.player) && global.character != CHARACTER_EXE && global.player.hp > 0 && global.player.revivalTimes < 2)
{
	if(place_meeting(x, y, global.player) && !coll)
	{		
		var pak = cpacket_tcp(PacketType.CLIENT_RMZSHARD_COLLECT);
		buffer_write(pak, buffer_u16, gid);
		send_server_tcp(pak);
		coll = true;
	}
}

if(!grv)
	return;
	
if(ground)
	return;
	
while(collision_point(x - 7, y + 7, obj_floor_parent, true, true))
{
	x++;
}

while(collision_point(x + 7, y + 7, obj_floor_parent, true, true))
{
	x--;
}
	
if(!collision_rectangle(x - 7, y + 14, x + 7, y + 21, obj_floor_parent, true, true))
{
	if(yspd < 6)
		yspd += 0.16;
		
	y += yspd;
}
else
{
	for(var i = 0; i < 7; i++)
	{
		if(collision_rectangle(x - 7, y + (20-i), x + 7, y + 21, obj_floor_parent, true, true))
			y--;
	}
	
	var pak = cpacket_tcp(PacketType.CLIENT_RMZSHARD_LAND, true);
	buffer_write(pak, buffer_u16, gid);
	buffer_write(pak, buffer_u16, x);
	buffer_write(pak, buffer_u16, y);
	send_server_tcp(pak);
	
	ground = true;
}