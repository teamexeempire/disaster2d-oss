var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(isDead)
{	
	if(image_index >= image_number - 1)
		instance_destroy();
		
	return;
}

if(state == 0)
{
	sprite_index = spr_ravinemist_sonic;
	image_xscale = 1;
}
else if(state == 1)
{
	sprite_index = spr_ravinemist_sonic;
	image_xscale = -1;
}

if(state == 2)
{
	sprite_index = spr_ravinemist_sonic2;
	image_xscale = 1;
}
else if(state == 3)
{
	sprite_index = spr_ravinemist_sonic2;
	image_xscale = -1;
}

if(state == 4)
{
	sprite_index = spr_ravinemist_sonic3;
	image_xscale = 1;
}
else if(state == 5)
{
	sprite_index = spr_ravinemist_sonic3;
	image_xscale = -1;
}

if(image_alpha < 1)
{
	image_alpha += 0.016;
	return;
}

if(!instance_exists(global.player))
	return;
	
if(instance_exists(obj_exetior_stompballs) && place_meeting(x, y, obj_exetior_stompballs))
{
	var pk = cpacket_tcp(PacketType.CLIENT_RMZSLIME_HIT);
	buffer_write(pk, buffer_u16, nid);
	buffer_write(pk, buffer_bool, true); //projectile
	send_server_tcp(pk);
	dead = true;
	return;
}

var inst = instance_place(x, y, obj_tails_projectile);
if(inst != noone)
{
	var pk = cpacket_tcp(PacketType.CLIENT_RMZSLIME_HIT);
	buffer_write(pk, buffer_u16, nid);
	buffer_write(pk, buffer_bool, true); //projectile
	send_server_tcp(pk);
	dead = true;
}

if(global.player.hp > 0 && !dead  && place_meeting(x, y, global.player))
{
	var ch = global.character;
	var isAttacking = false;
	
	if(global.player.isAttacking && (ch == CHARACTER_EXE || ch == CHARACTER_AMY || ch == CHARACTER_KNUX || ch == CHARACTER_EGGMAN || ch == CHARACTER_SALLY))
	{
		scr_camera_shake(25, 1, 0.2);
		isAttacking = true;
	}
			
	if(ch == CHARACTER_AMY && global.player.state == AMY_HJUMP)
		isAttacking = true;
	
	if(global.player.revivalTimes < 2)
	{
		if(global.player.isJumping && ch != CHARACTER_EXE || global.player.state == FALL && ch == CHARACTER_AMY)
		{
			 scr_player_hurt(0, 0, -5, snd_none, spr_blood2);
			 isAttacking = true;
		}
		
		if(global.player.isSpinning && (ch == CHARACTER_CREAM || ch == CHARACTER_KNUX || ch == CHARACTER_TAILS))
			 isAttacking = true;
			
		if(global.player.state == SALLY_SLIDE && ch == CHARACTER_SALLY)
			 isAttacking = true;
	}
	
	if(!isAttacking)
	{
		if(global.character != CHARACTER_EXE && global.player.revivalTimes < 2)
		{
			if(timer++ >= 10)
			{
				if(global.player.rings > 0)
				{
					audio_play_sound(snd_ringabsorb, 0, false);
					net_sound_emit(snd_ringabsorb);
					global.player.rings--;
				}
				else
					scr_player_hurt(20, -global.player.image_xscale * 4);
			
				timer = 0;
			}
		}
		else
			timer = 10;
		
		return;
	}
		
	var pk = cpacket_tcp(PacketType.CLIENT_RMZSLIME_HIT);
	buffer_write(pk, buffer_u16, nid);
	buffer_write(pk, buffer_bool, false); //projectile
	send_server_tcp(pk);
	
	state = 10;
	dead = true;
}
else
	timer = 10;