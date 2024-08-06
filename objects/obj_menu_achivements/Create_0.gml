scroll = 0;
tmpScroll = 0;

move = function(dir)
{
	tmpScroll += dir * 8;
	
	if(tmpScroll < -(sprite_height))
		tmpScroll = -(sprite_height);
	else if(tmpScroll > 0)
		tmpScroll = 0;
};