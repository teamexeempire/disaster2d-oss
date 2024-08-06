if(!instance_exists(obj_camera))
	return;

x = obj_camera.x + 427/2;
y = obj_camera.y + 240/2;

if(state)
{
	if(fade > 0)
		fade -= 0.05;
	else
	{
		layer_background_sprite(BG, bgnew);
		state = false;
	}
}
else
{	
	if(fade < 1)
		fade += 0.05;
	else
		fadeB = false;
}

layer_background_alpha(BG, fade);

if(position_meeting(x, y, obj_dotdotdot_trigger3))
{
	if(!fadeB && layer_background_get_sprite(BG) != background_dotdotdot3)
	{
		audio_sound_gain(mus_dotdotdot2, 1, 2000);
		audio_sound_gain(mus_dotdotdot, 0, 2000);
		
		fadeB = true;
		state = true;
		bgnew = background_dotdotdot3;
	}
	return;
}

if(position_meeting(x, y, obj_dotdotdot_trigger2))
{
	if(!fadeB && layer_background_get_sprite(BG) != background_dotdotdot2)
	{			
		fadeB = true;
		state = true;
		bgnew = background_dotdotdot2;
	}
	return;
}

if(position_meeting(x, y, obj_dotdotdot_trigger))
{
	if(!fadeB && layer_background_get_sprite(BG) != background_dotdotdot)
	{
		audio_sound_gain(mus_dotdotdot2, 0, 2000);
		audio_sound_gain(mus_dotdotdot, 1, 2000);
		
		fadeB = true;
		state = true;
		bgnew = background_dotdotdot;
	}
	return;
}