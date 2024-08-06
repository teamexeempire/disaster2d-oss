function scr_player_instakill() 
{
	if(global.player.isDead) //Нельзя умереть 2 раза :rage:
		return;
		
	if(obj_netclient.gameEnds)
		return;
	
	var packet = cpacket_tcp(PacketType.CLIENT_PLAYER_DEATH_STATE);
	buffer_write(packet, buffer_bool, true);
	buffer_write(packet, buffer_u8, global.player.revivalTimes);
	send_server_tcp(packet);
	
	global.cameraMode = 3;
	
	global.player.hp = 0;
	global.player.deadTimer = 31;
	global.player.alarm[0] = 60;
	global.player.rings = 0;
	global.player.xspd = image_xscale * 2;
	global.player.isGrounded = false;
	global.player.isSpinning = false;
	global.player.isLookingDown = false;
	global.player.isLookingUp = false;
	global.player.isDead = true;
	global.player.shards = 0;
	global.player.chunkX = -1000;
	global.player.chunkY = -1000;
	global.player.chunkTimer = 0;
	obj_achivements.rShardsCollected = 0;
	
	if(instance_exists(obj_deserttown_i))
		with(obj_deserttown_i)
			show = false;
	
	audio_play_sound(snd_dead, 0, false);
	net_quick_effect(global.player.x, global.player.y, spr_blood2, false, 1, 0, 0, 1);
	net_sound_emit(snd_dead);
}

function scr_player_hurt(damage, xpw=4, ypw=-6, sndid=snd_hurt, blood=spr_blood1, ignore=false)
{	
	if(!instance_exists(global.player))
		return;
		
	if(obj_netclient.gameEnds)
		return;
		
	if(global.player.isDead)
		return;
	
	if(global.player.hurttime > 0)
	{
		if(ignore)
		{
			global.player.isGrounded = false;
			global.player.isSpinning = false;
			global.player.isLookingDown = false;
			global.player.isLookingUp = false;
			
			global.player.xspd = xpw;
			global.player.yspd = ypw;
		}
		
		return;
	}
	
	if(global.character != CHARACTER_EXE)
	{
		if(damage > 0)
		{
			if(global.character == CHARACTER_SALLY && global.player.shieldTimer > 0)
			{
				if(global.player.revivalTimes < 2 && global.player.hp <= 20)
				{
					obj_achivements.rSallyShield++;
					
					if(obj_achivements.rSallyShield >= 2 && room != room_fartzone && !obj_achivements.achivements[32])
					{
						obj_achivements.achivements[32] = true;
						obj_achivements.show();
						obj_achivements.save();
						
						obj_achivements.mercoins += 75;
						obj_achivements.save();
					}
				}
				global.player.hurttime = 60;
				global.player.shieldTimer = 0;
				
				audio_play_sound(snd_sally_shieldbreak, 0, false);
				net_quick_effect(global.player.x, global.player.y, global.player.revivalTimes >= 2 ? spr_shieldbreak2 : spr_shieldbreak, false, 1, 0, 0, 1);
				net_sound_emit(snd_sally_shieldbreak);
				return;
			}
		}
			
		if(global.player.revivalTimes < 2) // ignore if we're demonized
		{
			obj_achivements.wasHurt = true;
			global.player.hp -= damage;
			
			if(global.player.hp <= 0)
			{
				var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(pak, buffer_u8, 3);
				buffer_write(pak, buffer_u8, global.player.hp + damage);
				send_server_tcp(pak);
				
				scr_player_instakill();
				return;
			}
			
			var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
			buffer_write(pak, buffer_u8, 3);
			buffer_write(pak, buffer_u8, damage);
			send_server_tcp(pak);
		}
	}
	else
	{
		if(global.player.invisTimer > 0 || global.player.won || global.player.lost)
			return;
	}
	
	if(global.player.rings > 0 && damage > 0)
	{
		global.player.rings = 0;
		audio_play_sound(snd_ringlose, 0, false);
		
		net_sound_emit(snd_ringlose);
		net_quick_effect(global.player.x, global.player.y, spr_ringlose);
		
		scr_camera_shake(25, 1, 0.2);
	}
	else if(damage > 0 || sndid == snd_buble)
	{
		audio_play_sound(sndid, 0, false);
		net_sound_emit(sndid);
		scr_camera_shake(25, 1, 0.2);
	}
	
	if(damage > 0)
	{
		global.player.isHurt = true;
		global.player.isJumping = false;
		net_quick_effect(global.player.x, global.player.y, blood, false, sign(xpw), 0, 0, 1);
	}
	
	global.player.isGrounded = false;
	global.player.isSpinning = false;
	global.player.isLookingDown = false;
	global.player.isLookingUp = false;
	
	global.player.xspd = xpw;
	global.player.yspd = ypw;
	
	if(damage != 0)
		global.player.hurttime = (global.timeMinutes <= 0 && global.timeSeconds <  60) ? 1 * 60 : 3 * 60;
	else
		global.player.hurttime = 0;
	
}