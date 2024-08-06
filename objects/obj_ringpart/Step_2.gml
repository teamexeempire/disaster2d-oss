if(alarm[0] < 60)
	image_alpha = alarm[0] / 60.0;
	
x += xspd;
y += yspd;

image_angle += xspd;
image_index += (yspd + xspd) * 0.1;

if(position_meeting(bbox_right+xspd, y-1, obj_floor_parent))
	xspd = 0;
	
if(position_meeting(bbox_left+xspd, y-1, obj_floor_parent))
	xspd = 0;
	
while(position_meeting(x, y + 4, obj_floor_parent))
{
	yspd = 0;
	y--;
}

if(position_meeting(x, y + 5, obj_floor_parent))
{
	xspd -= min(abs(xspd), 0.0512) * sign(xspd);
	return;
}

yspd += 0.32;