image_blend = obj_menu.bSelected == 1 ? #800000 : c_white;

if(selected != obj_menu.bSelected)
{
	if(obj_menu.bSelected == 1)
		offset = 3;
		
	selected = obj_menu.bSelected;
}

if(offset > 0)
{
	 y = sY - offset;
	 offset -= 0.2;
}
else y = sY;

draw_self();