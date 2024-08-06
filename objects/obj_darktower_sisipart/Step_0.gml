yspd += 0.2;
xspd += dir * .05;

x += xspd;
y += yspd;

var inst = instance_place(x, y, obj_floor_parent)
if(inst != noone)
{
	if(!inst.visible)
		return;
		
	instance_destroy();
}