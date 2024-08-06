if(row > 1)
{
	obj_minigame.cscore += row * 200;
	instance_create_layer(x, y, "Minigame", obj_granny);
}
else
	obj_minigame.cscore += 100;

row = 0