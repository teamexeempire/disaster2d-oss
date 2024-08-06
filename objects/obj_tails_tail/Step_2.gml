visible = false;
image_angle = 0;
image_speed = 0.2;

if(!instance_exists(obj_tails))
{
	instance_destroy();
	return;
}

x = obj_tails.x;
y = obj_tails.y;
depth = obj_tails.depth+1;

if(obj_tails.sprite_index == spr_tails_hurt)
	return;
	
if(obj_tails.sprite_index == spr_etails_hurt)
	return;
	
if(obj_tails.state == BALANCING)
{
	image_xscale = obj_tails.edgeDir;
	x += image_xscale * 4;
	y += 8;
	
	visible = true;
	sprite_index = obj_tails.revivalTimes >= 2 ? spr_etails_tail1 : spr_tails_tail1;
	return;
}

if(obj_tails.state == IDLE || obj_tails.emotion || obj_tails.state == LOOKDOWN ||obj_tails.state == LOOKUP)
{
	image_xscale = obj_tails.image_xscale;
	
	x += image_xscale * 2;
	y += 4;
	
	visible = true;
	sprite_index = obj_tails.revivalTimes >= 2 ? spr_etails_tail2 : spr_tails_tail2;
	return;
}

if(obj_tails.state == JUMP || obj_tails.state == SPIN)
{
	y += 6;
	image_xscale = 1;
	visible = true;
	image_angle = -radtodeg(arctan2(obj_tails.yspd, obj_tails.isGrounded ? obj_tails.gspd : obj_tails.xspd));
	sprite_index = obj_tails.revivalTimes >= 2 ? spr_etails_tail1 : spr_tails_tail1;
}