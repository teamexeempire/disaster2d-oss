visible = false;
image_speed = 0.2;

if(!instance_exists(target))
{
	instance_destroy();
	return;
}

x = target.x;
y = target.y;
depth = target.depth+1;

if(target.hp <= 0)
	return;
	
if(target.state == BALANCING)
{
	image_xscale = target.image_xscale;
	x += image_xscale * 4;
	y += 8;
	visible = true;
	sprite_index = target.revivalTimes >= 2 ? spr_etails_tail1 : spr_tails_tail1;
	return;
}
	
if((target.state == IDLE || target.state == BALANCING || target.state == EMOTION1 || target.state == EMOTION2 || target.state == EMOTION3) || target.state == LOOKDOWN || target.state == LOOKUP)
{
	image_xscale = target.image_xscale;
	
	x += image_xscale * 2;
	y += 4;
	
	visible = true;
	sprite_index = target.revivalTimes >= 2 ? spr_etails_tail2 : spr_tails_tail2;
	return;
}

if(target.state == JUMP || target.state == SPIN)
{
	y += 6;
	image_xscale = 1;
	visible = true;
	sprite_index = target.revivalTimes >= 2 ? spr_etails_tail1 : spr_tails_tail1;
}

var cX = camera_get_view_x(view_camera[0]);
var cY = camera_get_view_y(view_camera[0]);
var cW = 480;
var cH = 270;

if ((bbox_right > cX) && (bbox_left < cX + cW) && (bbox_bottom > cY) && (bbox_top < cY + cH))
{}
else
	visible = false;