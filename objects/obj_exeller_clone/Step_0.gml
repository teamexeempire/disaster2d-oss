if(position_meeting(x, y+18, obj_floor_parent))
	sprite_index = spr_exeller_clone;
else
	sprite_index = spr_exeller_clone2;

if(instance_exists(obj_hd_door))
{
	while(place_meeting(x, y, obj_hd_door))
		x++;
}
	
if(global.character != CHARACTER_EXE)
{
	if(!instance_exists(obj_player_puppet))
		return;
	
	var _self = self;
	with(obj_player_puppet)
	{
		if(character != CHARACTER_EXE)
			continue;
			
		if(state == IDLE && _self.sprite_index == spr_exeller_clone)
			_self.sprite_index = spr_exeller_idle;
	}
	return;
}
else
{
	if(global.player.state == IDLE && sprite_index == spr_exeller_clone)
		sprite_index = spr_exeller_idle;
}

var _target = noone;
var _dist = 99999999;
var _clone = self;

with(obj_player_puppet)
{
	if(hp <= 0)
		continue;
	
	if(revivalTimes >= 2)
		continue;
	
	var dist = distance_to_object(_clone);
	if(dist < 240 && dist < _dist)
	{
		_target = self;		
		_dist = dist;
	}
}

if(_target == noone)
	return;

if(pindex == 0)
{
	obj_exeller_indicator_up.show = true;
	obj_exeller_indicator_up.sprX = _target.x;
	obj_exeller_indicator_up.sprY = _target.y;
}
else if(pindex == 1)
{
	obj_exeller_indicator_down.show = true;
	obj_exeller_indicator_down.sprX = _target.x;
	obj_exeller_indicator_down.sprY = _target.y;
}