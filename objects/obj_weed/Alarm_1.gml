var type = irandom_range(0, 4);

switch(type)
{
	case 0:
		var _inst = instance_create_layer(0, irandom_range(0, 200), "Ghost2", obj_weed_ghost2);
		_inst.dir = random_range(0.5, 1);
		_inst.xx = -64;
		break;
		
	case 1:
		var _inst = instance_create_layer(0, irandom_range(0, 200), "Ghost1", obj_weed_ghost);
		_inst.dir = random_range(0.5, 1);
		_inst.xx = -64;
		break;
		
	case 2:
		var _inst = instance_create_layer(0, irandom_range(0, 200), "Ghost2", obj_weed_ghost2);
		_inst.dir = -random_range(0.5, 1);
		_inst.xx = 480+64;
		break;
		
	case 3:
		var _inst = instance_create_layer(0, irandom_range(0, 200), "Ghost1", obj_weed_ghost);
		_inst.dir = -random_range(0.5, 1);
		_inst.xx = 480+64;
		break;
}

alarm[1] = irandom_range(5, 7) * 60;