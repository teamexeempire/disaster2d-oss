x = oX + sin(current_time / 200 + delay) * 2;
y = oY + offset;

if(angle_timer-- <= 0)
{
	angle = choose(-16, 16, -8, 8);
	angle_timer = 60;
}

image_angle = angle;
if(abs(angle) > 0)
	angle -= 0.5 * sign(angle);