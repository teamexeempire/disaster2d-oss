//Создать игрока и камеру
if(!instance_exists(global.player) && global.character == CHARACTER_EXE)
{
	var inst = instance_find(obj_exespawn, irandom(instance_number(obj_exespawn) - 1));
	instance_create_depth(inst.x, inst.y-18, 0, global.player);
	instance_create_depth(inst.x, inst.y, 0, obj_camera);
	instance_create_depth(inst.x, inst.y, 0, obj_level);
	instance_create_depth(inst.x, inst.y-18, 0, obj_surv_indicator);
	
	if(obj_unlockables.pet != -1)
	{
		var pet = instance_create_depth(inst.x, inst.y, 0, global.pets[clamp(obj_unlockables.pet, 0, 7)]);
		pet.secret = obj_unlockables.pet - 7;
	}
}