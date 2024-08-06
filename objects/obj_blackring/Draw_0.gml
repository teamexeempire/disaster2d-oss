draw_self();

if(room == room_majongforest)
{
	var xPos = 0;
	if(x < 512)
		xPos = x + (room_width - 512) + sprite_width;
	else if(x >= room_width - 512)
		xPos = x - (room_width - 512) - sprite_width;
		
	draw_sprite(sprite_index, image_index, xPos, y);
}