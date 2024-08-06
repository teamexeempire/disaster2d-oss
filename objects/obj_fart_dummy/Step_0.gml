if(!instance_exists(global.player))
	return;

if(timer > 0)
{
	timer--;
	return;
}

image_index = !(global.character == CHARACTER_EXE || global.player.revivalTimes >= 2);
 
if(instance_exists(obj_tails_projectile))
{
	var inst = instance_place(x, y, obj_tails_projectile);
	if(inst != noone && !inst.isBreaking)
	{			
		var sg = sign(x - inst.x);
		var dmg = "";
		
		if(inst.isExe)
			dmg = $"-{inst.dmg/20}";
		else
			dmg = $"+{inst.dmg}s";
		
		var pak = cpacket_tcp(PacketType.CLIENT_FART_PUSH, false);
		buffer_write(pak, buffer_s8, sg * inst.charge);
		send_server_tcp(pak);
		
		audio_play_sound(choose(snd_dummy, snd_dummy2, snd_dummy3), 0, false);
		instance_create_depth(x, y, 0, obj_fart_text).text = dmg;
		
		inst._destroy();
		timer = 20;
	}
}

if(instance_exists(obj_exetior_stompballs))
{
	var inst = instance_place(x, y, obj_exetior_stompballs);
	if(inst != noone)
	{					
		var pak = cpacket_tcp(PacketType.CLIENT_FART_PUSH, false);
		buffer_write(pak, buffer_s8, global.player.image_xscale);
		send_server_tcp(pak);
		
		audio_play_sound(choose(snd_dummy, snd_dummy2, snd_dummy3), 0, false);
		instance_create_depth(x, y, 0, obj_fart_text).text = "-1";
		
		timer = 10;
	}
}

if(place_meeting(x, y, global.player))
{
	var dmg = 0;
	var push = 0;
	var isAttacking = global.player.isAttacking;
	
	if(global.character == CHARACTER_AMY && global.player.state == AMY_HJUMP && global.player.image_index < 3)
		isAttacking = true;
	
	if((global.character == CHARACTER_EXE || global.player.revivalTimes >= 2) && (global.player.state == JUMP || global.player.state == FALL || global.player.state == SPIN))
	{
		if(global.character != CHARACTER_EGGMAN && global.character != CHARACTER_AMY && global.character != CHARACTER_SALLY)
		{
			var pak = cpacket_tcp(PacketType.CLIENT_FART_PUSH, false);
			buffer_write(pak, buffer_s8, global.player.image_xscale * 3);
			send_server_tcp(pak);
			
			audio_play_sound(choose(snd_dummy, snd_dummy2, snd_dummy3), 0, false);
			instance_create_depth(x, y, 0, obj_fart_text).text = "-1";
			timer = 20;
			return;
		}
	}
	
	if(!isAttacking)
		return;
	
	if(global.character == CHARACTER_EXE)
	{
		switch(global.exeCharacter)
		{
			case EXE_ORIGINAL:
			case EXE_EXETIOR:
			case EXE_EXELLER:
				dmg = "-2";
				push = global.player.image_xscale * 2;
				break;
				
			case EXE_CHAOS:
				dmg = "-1";
				push = global.player.image_xscale;
				break;
		}
	}
	else if(global.player.revivalTimes < 2)
	{
		switch(global.character)
		{
			case CHARACTER_KNUX:
			{
				dmg = "+3s";
				push = global.player.image_xscale * 1.5;
				break;
			}
			
			case CHARACTER_EGGMAN:
			{
				dmg = "+2s";
				push = global.player.image_xscale * 1;
				break;
			}
			
			case CHARACTER_AMY:
			{
				dmg = "+3s";
				push = global.player.image_xscale * 1.5;
				break;
			}
			
			case CHARACTER_SALLY:
			{
				dmg = "+2s";
				push = global.player.image_xscale * 1;
				break;
			}
		}
	}
	else
	{
		switch(global.character)
		{
			case CHARACTER_KNUX:
			case CHARACTER_EGGMAN:
			case CHARACTER_AMY:
			case CHARACTER_SALLY:
			{
				dmg = "-1";
				push = global.player.image_xscale * 1;
				break;
			}
		}
	}
	
	var pak = cpacket_tcp(PacketType.CLIENT_FART_PUSH, false);
	buffer_write(pak, buffer_s8, push * 3);
	send_server_tcp(pak);
	
	audio_play_sound(choose(snd_dummy, snd_dummy2, snd_dummy3), 0, false);
	instance_create_depth(x, y, 0, obj_fart_text).text = dmg;
	timer = 20;
}