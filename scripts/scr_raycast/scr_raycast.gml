#macro NO_COLLISION -1

function scr_raycast_v(tx, ty, d, obj)
{
	var yy = ty;
	var dist = 0;
	
	while(yy != ty + d)
	{
		if(position_meeting(tx, yy, obj))
		{
			return dist;
		}
		
		dist++;
		yy += sign(d);
	}
	
	return NO_COLLISION;
}