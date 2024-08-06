if(!isConnected)
	return;
	
if(room == room_lobby)
{
	isServerReady = false;
	ping = 0;
}

if(room == room_lobby || room == room_menu)
	ds_map_clear(pings);

if(lvlId != -1 && room == global.levels[lvlId].rid)
{
	draw_texture_flush();
	texturegroup_load(global.levels[lvlId].group);
	texturegroup_load("Game");
}

sendTimeout = 60 * .5;
udp_timeout = 60 * 5;
isInit = false;

if(instance_exists(obj_level) && isReady)
{
	obj_achivements.changed = [];
	
	for (var k = ds_map_find_first(players); !is_undefined(k); k = ds_map_find_next(players, k)) 
	{
		if(k != nid)
		{
			var plr = ds_map_find_value(players, k);
			
			if(plr.character == CHARACTER_TAILS)
				continue;
				
			var inst = instance_create_depth(0, 0, 0, obj_player_puppet);
			inst.nickname = plr.nickname;
			inst.character = plr.character;
			inst.exeCharacter = plr.exeCharacter;
			inst.master_id = plr.nid;
			pings[? plr.nid] = 0;
			
			if(inst.character == CHARACTER_TAILS)
			{
				var tail = instance_create_depth(0, 0, 0, obj_puppet_tail);
				tail.target = inst;
			}
			
			if(plr.pet == -1)
				continue;
			
			if(plr.pet < 7)
			{
				var pet = instance_create_depth(inst.x, inst.y, 0, global.pets[max(plr.pet, 0)]);
				pet.target = inst;
			}
			else
			{
				var pet = instance_create_depth(inst.x, inst.y, 0, global.pets[7]);
				pet.target = inst;
				pet.secret = plr.pet - 7;
			}
		}
	}
	
	for (var k = ds_map_find_first(players); !is_undefined(k); k = ds_map_find_next(players, k)) 
	{
		if(k != nid)
		{
			var plr = ds_map_find_value(players, k);
			
			if(plr.character != CHARACTER_TAILS)
				continue;
			
			var inst = instance_create_depth(0, 0, 0, obj_player_puppet);
			inst.nickname = plr.nickname;
			inst.character = plr.character;
			inst.exeCharacter = plr.exeCharacter;
			inst.master_id = plr.nid;
			pings[? plr.nid] = 0;
			
			if(inst.character == CHARACTER_TAILS)
			{
				var tail = instance_create_depth(0, 0, 0, obj_puppet_tail);
				tail.target = inst;
			}
			
			if(plr.pet == -1)
				continue;
			
			if(plr.pet < 7)
			{
				var pet = instance_create_depth(inst.x, inst.y, 0, global.pets[max(plr.pet, 0)]);
				pet.target = inst;
			}
			else
			{
				var pet = instance_create_depth(inst.x, inst.y, 0, global.pets[7]);
				pet.target = inst;
				pet.secret = plr.pet - 7;
			}
		}
	}
}
