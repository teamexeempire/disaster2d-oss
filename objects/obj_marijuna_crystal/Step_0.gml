var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(activated)
{
	if(fade < 1)
		fade += 0.016;
	else
		fade = 1;
		
	if(instance_exists(global.player) && place_meeting(x, y, global.player) && fade >= 1)
		obj_marijuna_crystalcontroller.swapControls(5, x, y);
}
else
{	
	if(fade > 0)
		fade -= 0.016;
	else
		fade = 0;
}