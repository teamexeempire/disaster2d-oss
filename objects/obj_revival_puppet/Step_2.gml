if(over >= 0)
{
	sprite_index = over == 1 ? spr_revival : spr_revival2;
	image_index = 0;
}

if(show)
{
	sprite_index = spr_revival;
	image_index = progress * image_number;
}

visible = show || over >= 0;