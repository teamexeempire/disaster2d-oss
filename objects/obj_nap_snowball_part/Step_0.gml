yspd += 0.12;
xspd -= sign(xspd) * 0.04;

x += xspd;
y += yspd;
image_angle += 1;

if(doDestroy)
{
	image_alpha -= 0.05;
	
	if(image_alpha <= 0)
		instance_destroy();
}