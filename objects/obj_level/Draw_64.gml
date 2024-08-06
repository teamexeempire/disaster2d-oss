var player_exists = instance_exists(global.player);

switch(room)
{
	case room_notperfect:
	case room_act9:
	case room_youcantrun:
	case room_nastyparadise:
	case room_ravinemist:
	case room_volcanovalley:
	case room_greenhill:
	case room_angelisland:
	case room_fartzone:
	case room_weedzone:
		break;
		
	default:
		draw_sprite_ext(spr_screenoverlay, 0, 0, 0, 1, 1, 0, c_white, 0.7);
		break;
		
}

draw_sprite_ext(spr_hidegui, 0, 0, 0, 1, 1, 0, c_white, hideFade);
draw_sprite_ext(spr_attackgui, 0, 0, 0, 1, 1, 0, c_white, bloodFade);

if(bloodFade > 0)
	bloodFade -= 0.02;
	
if(player_exists && global.player.isHiding)
{
	if(hideFade < 1)
		hideFade += 0.02;
}
else
{
	if(hideFade > 0)
		hideFade -= 0.02;
}
if(global.showHud && titleCard > 4)
{	
	if(obj_netclient.udp_timeout < 60 * 3)
		draw_sprite(spr_badconnection, floor(current_time/200) % 6, 0, 0);
	
	draw_sprite(spr_clock, 0, 211, 0);
	clockAngle = lerp(clockAngle, (-45 * timeFrame), 0.2);
	draw_sprite_ext(spr_clockhand, 0, 212, 11.5, 1, 1, clockAngle, c_white, 1);
	
	draw_sprite(spr_counter, 10, 233, 4);
	scr_counter_draw(global.timeMinutes, 224, 4);
	scr_counter_draw_m(global.timeSeconds, 244, 4, 2);
	
	if(!showSurvivors)
	{
		if(state == 1 && (current_time / 30) % 20 < 10) // Escape!!!
		{
			if(global.character == CHARACTER_EXE || (instance_exists(global.player) && global.player.revivalTimes >= 2))
				draw_sprite(spr_status, 1, 480/2, 32);
			else
				draw_sprite(spr_status, 0, 480/2, 32);
		}
	}
	
	// Icons
	var pos = 480/2 - (ds_map_size(obj_netclient.players) * 28) / 2;
	
	//self icon
	if(obj_netclient.exeId != obj_netclient.nid)
	{		
		var sprIndex = (global.character-CHARACTER_TAILS) * 7;
		
		if(player_exists)
		{
			if(global.player.revivalTimes < 2)
			{
				sprIndex += round((1.0 - (global.player.hp / 100.0)) * 5);
				
				if(global.player.hp <= 0)
				{
					if(global.player.revivalTimes == 0)
						sprIndex = (global.character-CHARACTER_TAILS) * 7 + 5;
					else
						sprIndex = (global.character-CHARACTER_TAILS) * 7 + 6;
				}
				
				draw_sprite(global.player.redRingTimer > 0 ? spr_playerhealth_redring : spr_playerhealth, sprIndex, pos, 268);
				if(global.player.revivalTimes >= 1 && global.player.hp > 0)
					draw_sprite(spr_playerhealth_hit, global.character - 1, pos, 268);
				
				if(global.player.isDead)
				{
					if(global.player.revivalTimes == 0 && global.player.deadTimer < 31)
						scr_number_spr(pos + 12, 264, string(global.player.deadTimer), global.player.deadColor);
				}
				else if(global.player.shards > 0)
					scr_number_spr(pos + 12, 264, string(global.player.shards), #27ff23);		
			}
			else
				draw_sprite(spr_playerhealth_demon, global.character-CHARACTER_TAILS, pos, 268);
		}
		else
			draw_sprite(spr_playerescaped, (global.character-CHARACTER_TAILS), pos, 268);
		
		pos += 28;
	}
	
	var i = 0;
	for(var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k))
	{
		if(!ds_map_exists(obj_netclient.players, k))
			continue;
		
		if(k == obj_netclient.exeId)
			continue;
		
		var player = obj_netclient.players[? k];
		var inst = noone;
		
		var redRing = false;
		if(instance_exists(obj_player_puppet))
		{
			with(obj_player_puppet)
			{
				if(master_id != k)
					continue;
					
				inst = self;
				redRing = hasRedRing;
				break;
			}
		}
		
		if(inst != noone)
		{
			if(!inst.isDemonized || inst.character == CHARACTER_EXE)
			{
				var sprIndex = (inst.character-CHARACTER_TAILS) * 7;
				sprIndex += round((1.0 - (inst.hp / 100.0)) * 5);
				
				if(inst.hp <= 0)
				{
					if(inst.revivalTimes == 0)
						sprIndex = (inst.character-CHARACTER_TAILS) * 7 + 5;
					else
						sprIndex = (inst.character-CHARACTER_TAILS) * 7 + 6;
				}
				
				draw_sprite(redRing ? spr_playerhealth_redring : spr_playerhealth, sprIndex, pos + i * 28, 268);
				if(inst.revivalTimes >= 1 && inst.hp > 0)
					draw_sprite(spr_playerhealth_hit, inst.character - 1, pos + i * 28, 268);
				
				if(inst.revivalTimes == 0 && inst.deadTimer < 31)
					scr_number_spr(pos + i * 28 + 12, 264, string(inst.deadTimer), inst.deadColor);
				else if(player_exists && global.character != CHARACTER_EXE && global.player.revivalTimes < 2 && !global.player.isDead && inst.shards > 0)
					scr_number_spr(pos + i * 28 + 12, 264, string(inst.shards), #27ff23);
			}
			else
			{
				draw_sprite(spr_playerhealth_demon, inst.character-CHARACTER_TAILS, pos + i * 28, 268);
			}
		}
		else 
			draw_sprite(spr_playerescaped, (player.character-CHARACTER_TAILS), pos + i * 28, 268);
			
		i++;
	}
}


if(titleCard < 8)
{
	if(cardX > 0)
		cardX -= 12;
		
	if(cardY < 0)
		cardY += 12;
}

if(titleCard < 18)
	draw_sprite_ext(spr_black, 0, 0, 0, 1, 1, 0, c_white, 1.0 - ((clamp(titleCard, 8, 16) - 8) / 8.0));

if(titleCard > 18)
{
	if(cardX < 480)
		cardX += 12;
		
	if(cardY > -270)
		cardY -= 12;
}

if(titleCard < 30)
{
	cardX = clamp(cardX, 0, 480);
	cardY = clamp(cardY, -270, 0);
	
	draw_sprite_ext(spr_titlecard2, obj_netclient.lvlId, 0, cardY, 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_titlecard1, obj_netclient.lvlId, cardX, 0, 1, 1, 0, c_white, 1);
	
	titleCard += 0.12;
}

if(global.showHud)
{
	var clr = #0fff39;
	if(obj_netclient.ping >= 80 && obj_netclient.ping < 160)
		clr = #ffc400;
	else if(obj_netclient.ping >= 160)
		clr = #ff0001;
	
	if(obj_netclient.ping <= 0)
		scr_text_spr(4, 4, $"waiting for players{string_copy("...", 0, (current_time / 500) % 4)}");
	else if(obj_config.showPing)
		scr_text_spr(4, 4, string(obj_netclient.ping) + "ms", clr);
	
	if(obj_config.showFps)
		scr_text_spr(4, 10, string(floor(fps_real)) + "fps");
}

//tab
if(keyboard_check(global.KeyPList))
{
	draw_sprite(spr_tab, 0, 0, 0);
	drawPing(global.character, global.exeCharacter, obj_netclient.ping, !instance_exists(global.player) ? 0 : global.player.revivalTimes, global.nickname, 0);
	
	var index = 1;
	for (var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k)) 
	{
		var plr = obj_netclient.players[? k];
		var ping = obj_netclient.pings[? k];
		var inst = noone;

		if(instance_exists(obj_player_puppet))
		{
			with(obj_player_puppet)
			{
				if(master_id != plr.nid)
					continue;
					
				inst = self;
			}
		}
		
		drawPing(plr.character, plr.exeCharacter, ping, inst == noone ? 0 : inst.revivalTimes, plr.nickname, index);
		index++;
	}
}