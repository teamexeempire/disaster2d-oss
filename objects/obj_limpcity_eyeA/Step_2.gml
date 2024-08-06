var _id = tid;
var _me = self;

with(obj_limpcity_eyechain)
{
	if(sid != _id)
		continue;
		
	_me.oX = x - lengthdir_y(sprite_height, image_angle) - sprite_width/2-2;
	_me.oY = y + lengthdir_x(sprite_height, image_angle) - 2;
	_me.offset = 14;
}

with(obj_limpcity_eyechain2)
{
	if(sid != _id)
		continue;
		
	_me.oX = x - lengthdir_y(sprite_height, image_angle) + sprite_width/2+2;
	_me.oY = y + lengthdir_x(sprite_height, image_angle) + 2;
	_me.offset = -14;
}