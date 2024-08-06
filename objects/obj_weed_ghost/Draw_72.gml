if(!instance_exists(obj_camera))
	return;

xx += dir;
yy = pY + sin(current_time / 300 + rand) * 10;
image_xscale = -sign(dir);

if(dir > 0 && xx >= 480 + sprite_width + 64)
	instance_destroy();
	
if(dir < 0 && xx <= -128)
	instance_destroy();
	
x = obj_camera.x + xx;
y = obj_camera.y + yy;