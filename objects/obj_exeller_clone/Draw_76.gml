if(room != room_notperfect)
	return;

while(collision_rectangle(x-7, y-20, x+7, y+18, obj_floor_parent, false, false))
	y--;