function scr_survivor_heal()
{
	if(!instance_exists(global.player))
		return;
		
	if(healObj == noone)
		return;
		
	if(hp <= 0 || hp >= 100)
	{
		healObj.progress = 0;
		return;
	}
	
	if(revivalTimes >= 2 || isDemonized)
	{
		healObj.progress = 0;
		return;
	}
	
	if(global.player.rings < 10)
	{
		healObj.visible = false;
		healObj.progress = 0;
		return;
	}
	
	if(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2)
		return;
		
	if(global.player.hp <= 0)
		return;
	
	if(place_meeting(x, y, global.player))
	{	
		healObj.visible = true;
			
		if(global.playerControls && global.player.isLookingUp)
		{			
			if(floor(healObj.progress * 100) % 32 == 0)
			{			
				var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_HEAL_PART, true);
				buffer_write(pak, buffer_u16, x);
				buffer_write(pak, buffer_u16, y);
				buffer_write(pak, buffer_u16, global.player.rings);
				send_server_tcp(pak);
				
				instance_create_depth(x, y, -10, obj_heal_particle);
			}
			
			healObj.progress += 0.016;
			if(healObj.progress >= 1)
			{
				var pak = cpacket_tcp(PacketType.CLIENT_PLAYER_HEAL, true);
				buffer_write(pak, buffer_u16, master_id);
				buffer_write(pak, buffer_u16, global.player.rings);
				send_server_tcp(pak);
				
				if(obj_achivements.rHealPlayer != master_id)
				{
					obj_achivements.rHeals++;
					if(room != room_fartzone && !obj_achivements.achivements[17] && obj_achivements.rHeals >= 2)
					{
						obj_achivements.achivements[17] = true;
						obj_achivements.mercoins += 100;
						obj_achivements.save();
						
						obj_achivements.show();
					}
					
					if(room != room_fartzone && !obj_achivements.achivements[30] && obj_achivements.rHeals >= 3 && global.character == CHARACTER_CREAM)
					{
						obj_achivements.achivements[30] = true;
						obj_achivements.mercoins += 100;
						obj_achivements.save();
						
						obj_achivements.show();
					}
					
					obj_achivements.rHealPlayer = master_id;
				}
				
				healObj.progress = 0;
				global.player.rings -= 10;
			}
		}
		else if(healObj.progress > 0)
			healObj.progress = 0;
	}
	else
	{
		healObj.visible = false;
		healObj.progress = 0;
	}
}