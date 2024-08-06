isDemonized = revivalTimes >= 2 || character == CHARACTER_EXE;

if(alarm[2] > 0)
{
	x += xspd;
	y += yspd;
}

if(reviveObj != noone)
{
	reviveObj.master_id = master_id;
	reviveObj.x = x;
	reviveObj.y = y - 40;
}

if(healObj != noone)
{
	healObj.x = floor(x);
	healObj.y = floor(y) - 45;
}

if(isInactive)
	image_blend = c_dkgray;
else 
	image_blend = c_white;
	
if(room == room_act9)
	image_blend = c_black;

if(character == -1)
	return;

if(character == CHARACTER_TAILS)
{
	if(state != TAILS_FLY && audio_is_playing(snd_tails_fly))
		audio_stop_sound(snd_tails_fly);
}

if(instance_exists(obj_hiding_parent))
	isHiding = place_meeting(x, y, obj_hiding_parent) && state == LOOKDOWN;

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 240, obj_camera.y + 135), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!instance_exists(global.player))
	return;
	
var globalExe = (global.character == CHARACTER_EXE || global.player.revivalTimes >= 2);

//hack
if(character == CHARACTER_AMY && state == AMY_HJUMP && image_index < 3)
	isAttacking = true;

if(place_meeting(x, y, global.player))
{
	if(isAttacking)
	{
		if(isDemonized && visible)
		{
			if(global.character == CHARACTER_EXE)
				return;
			
			if(character != CHARACTER_AMY && character != CHARACTER_EGGMAN)
			{
				if((global.character == CHARACTER_KNUX || global.character == CHARACTER_SALLY) && global.player.isAttacking && global.player.revivalTimes < 2)
				{
					global.player.isAttacking = false;
					global.player.isHurt = true;
					global.player.hurttime = 60;
					global.player.xspd = sign(global.player.x - x) * 3;
					global.player.yspd = -2;
					global.player.isGrounded = false;
					audio_play_sound(snd_buble, 0, false);
					net_sound_emit(snd_buble);
					return;
				}
			}
			
			if(global.player.hurttime <= 0 && global.player.hp > 0)
			{
				if(global.player.revivalTimes >= 2)
					return;
				
				if(character != CHARACTER_AMY)
				{
					if(global.character == CHARACTER_EGGMAN && global.player.isAttacking)
						return;
				}
				
				if(global.character == CHARACTER_AMY && global.player.isAttacking)
					return;
					
				if(global.character == CHARACTER_SALLY && global.player.shieldTimer > 0)
				{			
					global.player.isGrounded = false;
					global.player.isHurt = true;
					global.player.hurttime = 60;
					global.player.xspd = sign(global.player.x - x) * 2;
					global.player.yspd = -2;
					global.player.shieldTimer = 0;
					
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
					
					audio_play_sound(snd_sally_shieldbreak, 0, false);
					net_quick_effect(global.player.x, global.player.y, global.player.revivalTimes >= 2 ? spr_shieldbreak2 : spr_shieldbreak, false, 1, 0, 0, 1);
					net_sound_emit(snd_sally_shieldbreak);
					return;
				}
				
				var damage = 20;
				if(character == CHARACTER_EXE)
				{
					switch(exeCharacter)
					{
						case 0:
						case 2:
						case 3:
							damage = 40;
							break;
					}
				}
				
				if(character == CHARACTER_EGGMAN && global.player.hurttime <= 0)
					scr_player_slow(3);
					
				if(character == CHARACTER_AMY)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 3);
					send_server_tcp(pak);
				}
				
				scr_player_hurt(damage, image_xscale * 3, -3, snd_hurt, spr_blood3);
				
				if(character == CHARACTER_EXE)
				{
					if(exeCharacter == EXE_CHAOS && sprite_index == spr_chaos_attack2)
					{
						var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
						buffer_write(pak, buffer_u16, master_id);
						buffer_write(pak, buffer_u8, 10);
						send_server_tcp(pak);
					}
					
					scr_exe_checkwin();
				}
				
				obj_level.bloodFade = 1;
				obj_camera.spectatingObj = noone;
				
				var buffer = cpacket_tcp(PacketType.CLIENT_PLAYER_HURT, true);
				buffer_write(buffer, buffer_u16, master_id);
				buffer_write(buffer, buffer_u16, x);
				buffer_write(buffer, buffer_u16, y);
				buffer_write(buffer, buffer_u16, 0);
				send_server_tcp(buffer);
				
				if(revivalTimes >= 2 && global.player.hp <= 0)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 4);
					send_server_tcp(pak);
				}
				
				if(revivalTimes >= 2 && character == CHARACTER_KNUX && sprite_index == spr_eknux_attack2)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 8);
					send_server_tcp(pak);
				}
				
				var buffer = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(buffer, buffer_u8, 2);
				buffer_write(buffer, buffer_u16, master_id);
				buffer_write(buffer, buffer_u16, damage);
				buffer_write(buffer, buffer_u16, global.player.hp);
				send_server_tcp(buffer);
				
				return;
			}
		}
		
		if(!isDemonized && globalExe)
		{
			if(global.character == CHARACTER_EXE && global.player.invisTimer > 0)
				return;
			
			if(global.character != CHARACTER_AMY && global.character != CHARACTER_EGGMAN)
			{
				if(global.player.isAttacking && (character == CHARACTER_KNUX || character == CHARACTER_SALLY))
				{
					global.player.isAttacking = false;
					global.player.isHurt = true;
					global.player.hurttime = 60;
					global.player.xspd = sign(global.player.x - x) * 2;
					global.player.yspd = -2;
					global.player.isGrounded = false;
					audio_play_sound(snd_buble, 0, false);
					net_sound_emit(snd_buble);
					return;
				}
			}
			
			if(global.player.shockedTimer <= 0 && global.player.hurttime <= 0)
			{
				if(global.character == CHARACTER_SALLY && global.player.shieldTimer > 0)
				{			
					global.player.isGrounded = false;
					global.player.isHurt = true;
					global.player.hurttime = 60;
					global.player.xspd = sign(global.player.x - x) * 2;
					global.player.yspd = -2;
					global.player.shieldTimer = 0;
					
					audio_play_sound(snd_sally_shieldbreak, 0, false);
					net_quick_effect(global.player.x, global.player.y, global.player.revivalTimes >= 2 ? spr_shieldbreak2 : spr_shieldbreak, false, 1, 0, 0, 1);
					net_sound_emit(snd_sally_shieldbreak);
					return;
				}
				
				if(global.character == CHARACTER_AMY && global.player.isAttacking)
					return;
				
				var stunTime = 3;
				var snd = snd_exe_stun;
				var xxspd = -sign(x - global.player.x) * 4;
								
				if(character == CHARACTER_EGGMAN)
				{
					net_quick_effect(global.player.x, global.player.y, spr_shockparticle);
					stunTime = 2;
					snd = snd_electroshock;
					xxspd = 0;
				}
				
				var buffer = cpacket_tcp(PacketType.CLIENT_PLAYER_HURT, true);
				buffer_write(buffer, buffer_u16, master_id);
				buffer_write(buffer, buffer_u16, x);
				buffer_write(buffer, buffer_u16, y);
				buffer_write(buffer, buffer_u16, stunTime);
				send_server_tcp(buffer);
				
				if(character == CHARACTER_KNUX && sprite_index == spr_knux_attack2)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 9);
					send_server_tcp(pak);
				}
				
				if(global.character == CHARACTER_SALLY)
					global.player.isSliding = false;
				
				global.player.shockedTimer = stunTime * 60;
				global.player.xspd = xxspd;
				global.player.yspd = -2;
				global.player.isGrounded = false;
				audio_play_sound(snd, 0, false);
				net_sound_emit(snd);
				
				var pak = cpacket_tcp(PacketType.CLIENT_STATS_REPORT);
				buffer_write(pak, buffer_u8, 1);
				buffer_write(pak, buffer_u16, obj_netclient.nid);
				buffer_write(pak, buffer_u16, master_id);
				buffer_write(pak, buffer_u8, stunTime);
				send_server_tcp(pak);
				
				if(character == CHARACTER_AMY)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 11);
					send_server_tcp(pak);
				}
				
				if(global.character == CHARACTER_EXE)
				{
					var pak = cpacket_tcp(PacketType.CLIENT_MERCOIN_BONUS, true);
					buffer_write(pak, buffer_u16, master_id);
					buffer_write(pak, buffer_u8, 1);
					send_server_tcp(pak);
					
					scr_exe_stunsound();
				}
				return;
			}
		}
	}
}