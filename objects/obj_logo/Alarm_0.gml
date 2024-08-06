ind++;
image_index = ind;

if(ind > image_number - 1)
{
	room_goto(room_menu);
}

instance_create_depth(0, 0, 0, obj_lobby_white);

if(ind == 1)
	alarm[0] = 60 * 2.4;
if(ind == 2)
	alarm[0] = 60 * 2.5;