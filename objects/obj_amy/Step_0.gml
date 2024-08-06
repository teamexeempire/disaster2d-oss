/// @description General movement
if(shockedTimer <= 0)
{
	scr_move_basic();
}
else
{
	isBoosting = false;
	isLookingDown = false;
	isLookingUp = false;
	isAttacking = false;
	isJumping = false;
	gspd -= min(abs(gspd), acc) * sign(gspd); 
	xspd -= min(abs(xspd), acc) * sign(xspd); 
	shockedTimer--;
	hurttime = 60 * 2;
}

scr_collision_basic();

if(reviveObj != noone)
{
	reviveObj.x = x;
	reviveObj.y = y - 40;
	reviveObj.master_id = obj_netclient.nid;
}

if(redRingTimer > 0)
{
	if(redRingTimer == 1)
	{
		audio_stop_sound(mus_mindfuck);
		instance_destroy(obj_redring_screen);
	}
	
	redRingTimer--;
}

if(hurttime > 0)
	hurttime--;
	
if(hurttime > 0)
	return;

if(hp <= 0 && revivalTimes < 2)
	return;

if(isAttacking || (isHJ && image_index <= 3))
	return;

var list = ds_list_create();
instance_place_list(x, y, obj_player_puppet, list, false);

for(var i = 0; i < ds_list_size(list); i++)
{
	var inst = list[| i];
	if(inst.isDemonized && inst.visible && (inst.state == JUMP || inst.state == SPIN))
	{
		if(inst.character == CHARACTER_EGGMAN || inst.character == CHARACTER_AMY || inst.character == CHARACTER_SALLY)
			continue;
			
		if(revivalTimes >= 2)
			continue;
			
		if(inst.character == CHARACTER_EXE && inst.exeCharacter == 1 && inst.slimeMode)
			continue;
		
		var dirX = -sign(inst.x - x) * 3;
		scr_player_hurt(20, dirX, -4, snd_hurt, spr_blood2);
		
		if(hp <= 0 && inst.revivalTimes >= 2)
		{		
			var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
			buffer_write(pak, buffer_u16, inst.master_id);
			buffer_write(pak, buffer_u8, 4);
			send_server_tcp(pak);
		}
		
		if(inst.character == CHARACTER_EXE)
			scr_exe_checkwin();
		
		var buffer = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
		buffer_write(buffer, buffer_u8, 2);
		buffer_write(buffer, buffer_u16, inst.master_id);
		buffer_write(buffer, buffer_u16, 20);
		buffer_write(buffer, buffer_u16, hp);
		send_server_tcp(buffer);
		
		obj_level.bloodFade = 0.4;
	}
}

ds_list_destroy(list);