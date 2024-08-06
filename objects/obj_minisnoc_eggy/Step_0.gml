if(dead)
{
	if(yspd < 6)
		yspd += 0.26;
	
	image_angle += 1;
	x -= 2;
	y += yspd;
	
	if(cantattack++ % 3 == 0)
		instance_create_layer(x + random_range(-10, 10), y + random_range(-10, 10), "Minigame", obj_minisnoc_pil);
	
	if(y >= room_height + 10)
		instance_destroy();
		
	obj_minigame.last = obj_minigame.cscore;
}

if(!obj_minigame.ingame)
	return;
	
if(place_meeting(x, y, obj_minisnoc) && !obj_minisnoc.dead)
	obj_minigame.dead();

image_index = hit;

if(--hit >= 0)
	return;
	
var inst = instance_place(x, y, obj_asteroid_part)
if(inst != noone)
{
	with(inst)
		instance_destroy();
	
	audio_play_sound(snd_minidestroy, 0, false);
	hit = 60 * 0.5;
	cantattack = 60 * 1.5;
	if(--hp <= 0)
	{
		dead = true;
		yspd = irandom_range(-5, -2);
		return;
	}
}

image_index = 0;

if(x > 480-sprite_width*1.5)
{
	x--;
	return;
}

if(cantattack > 0)
	cantattack--;

if(shooting)
{
	repeat(2)
	{
		side = y <= obj_minisnoc.y;
		if(side)
		{
			if(y < 113)
				y += 1;
		}
		else
		{
			if(y > 34)
				y -= 1;
		}
	}
	
	if(cantattack <= 0 && --moved <= 0)
	{
		instance_create_layer(x, y, "Minigame", obj_minisnoc_eggy2);
		moved = random_range(30, 70);
	}
}
else
{
	if(side)
	{
		if(y < 113)
			y += 1;
		else
			side = !side;
	}
	else
	{
		if(y > 34)
			y -= 1;
		else
			side = !side;
	}
	
	if(cantattack <= 0 && --moved <= 0)
	{
		instance_create_layer(x, y, "Minigame", obj_minisnoc_eggy2);
		moved = random_range(40, 50);
	}
}