if(obj_menu_waiting.chatMode)
	return;

if(obj_menu_waiting.voteKick)
	return;

if(cscore - last >= 5000 && !boss)
{
	instance_create_layer(x, y, "Minigame", obj_minisnoc_eggy);
}

if(!ingame)
{
	if(keyboard_check_pressed(global.KeyA))
		activate();
	else
		return;
}

if(--interval <= 0)
{
	if(boss)
	{
		instance_create_layer(496, random_range(34, 115), "Minigame", random_range(0, 4) <= 1 ? obj_asteroid : obj_asteroid_breakable);
		interval = random_range(3, 5) * (60 - elapsed);
	}
	else
	{
		instance_create_layer(496, random_range(34, 115), "Minigame", random_range(0, 4) <= 1 ? obj_asteroid_breakable : obj_asteroid);
		interval = random_range(1, 3) * (60 - elapsed);
	}
	
	if(elapsed < 50)
		elapsed += 0.5;
}

if(obj_minisnoc.dead)
	return;
	
off -= 1 + (elapsed / 10.0);
if(off <= -512)
	off += 512;