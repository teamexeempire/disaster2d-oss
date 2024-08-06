if(yy == -1)
	yy = y;
	
x -= xspd;

if(x < -16)
{
	x = room_width;
}

y = yy + sin(current_time / 500.0) * 2;
image_alpha = 0.5 + ((1 + sin(current_time / 200.0)) / 2.0) * .5;