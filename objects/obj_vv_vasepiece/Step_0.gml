if(stopped)
	return;
	
x += xspd;
y += yspd;

if(position_meeting(bbox_right+xspd, y-1, obj_floor_parent))
	xspd = 0;
	
if(position_meeting(bbox_left+xspd, y-1, obj_floor_parent))
	xspd = 0;

if(position_meeting(x, y+4, obj_floor_parent))
{
	xspd -= sign(xspd) * 0.1;
	yspd = 0;
	
	if(abs(xspd) <= 0 && abs(yspd) <= 0)
		stopped = true;
	
	return;
}

yspd += 0.32;
image_angle += xspd;