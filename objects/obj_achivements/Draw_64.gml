if(!boxSide)
{
	if(boxX > 0)
	{
		draw_sprite(spr_achivementbox, 0, boxX, 4);
		boxX -= 6;
	}
}
else
{
	if(boxX < 194)
		boxX += 6;
		
	draw_sprite(spr_achivementbox, 0, boxX, 4);
}