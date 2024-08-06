x = xP + sin(current_time / 300 + xOff) * 4;

if(mDestroy)
{
	image_alpha -= 0.01;
	
	if(image_alpha <= 0)
		instance_destroy();
}
else
{
	if(image_alpha < 1)
		image_alpha += 0.0025;
		
	if(!instance_exists(global.player))
		return;
	
	if(global.player.isDead)
		return;
	
	if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
		return;
	
	if(place_meeting(x, y, global.player))
		area.overlaps = true;
}