if(!instance_exists(global.player))
	return;

if(nid == 1)
{
	if(global.player.x - 8 <= bbox_right)
		global.player.x = ceil(bbox_right) + 8;
		
	if(position_meeting(obj_player_sensorL.x, obj_player_sensorL.y, self))
	{
		if(obj_player_sensorL.coll && obj_player_sensorR.coll)
		{			
			if(!global.player.isDead && global.character != CHARACTER_EXE && global.player.revivalTimes < 2)
			{
				scr_player_instakill();
				audio_play_sound(snd_dead, 0, false);
				net_sound_emit(snd_dead);
				net_quick_effect(global.player.x, global.player.y, spr_blood2, false, sign(x - global.player.x), 0, 0, 1);
			}
				
			global.player.x = 1535;
			global.player.y = 943;
			global.player.gspd = 0;
			global.player.xspd = 0;
			global.player.yspd = 0;
			global.player.isHurt = false;
			global.player.hurttime = 0;
		}
	}
}

if(nid == 2)
{			
	if(global.player.x+8 >= bbox_left)
		global.player.x = ceil(bbox_left) - 8;
		
	if(position_meeting(obj_player_sensorR.x, obj_player_sensorR.y, self))
	{
		if(obj_player_sensorL.coll && obj_player_sensorR.coll)
		{
			if(!global.player.isDead && global.character != CHARACTER_EXE && global.player.revivalTimes < 2)
			{
				scr_player_instakill();
				audio_play_sound(snd_dead, 0, false);
				net_sound_emit(snd_dead);
				net_quick_effect(global.player.x, global.player.y, spr_blood2, false, sign(bbox_right - global.player.x), 0, 0, 1);
			}
				
			global.player.x = 1535;
			global.player.y = 943;
			global.player.gspd = 0;
			global.player.xspd = 0;
			global.player.yspd = 0;
			global.player.isHurt = false;
			global.player.hurttime = 0;
		}
	}
}

if(nid == 0)
{
	if(global.player.y <= bbox_bottom + 16)
	{
		if(!global.player.isDead && global.player.y <= bbox_bottom + 8)
		{		
			if(global.character != CHARACTER_EXE && global.player.revivalTimes < 2)
			{
				scr_player_instakill();
				audio_play_sound(snd_dead, 0, false);
				net_sound_emit(snd_dead);
				net_quick_effect(global.player.x, global.player.y, spr_blood2, false, sign(bbox_right - global.player.x), 0, 0, 1);
			}
			
			global.player.x = 1535;
			global.player.y = 943;
			global.player.gspd = 0;
			global.player.xspd = 0;
			global.player.yspd = 0;
			global.player.isHurt = false;
			global.player.hurttime = 0;
		}
		else
			global.player.y = bbox_bottom + 16;
	}
}