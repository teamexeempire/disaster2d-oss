if(!instance_exists(global.player))
	return;
	
if(obj_netclient.nid == pid)
{
	global.player.state = HURT;
	global.player.isHurt = false;
	
	switch(global.character)
	{
		case CHARACTER_EXE:
			
			switch(global.exeCharacter)
			{
				case EXE_ORIGINAL:
					if(global.player.invisTimer > 0)
						global.player.sprite_index = spr_exe_invis_hurt;
					else
						global.player.sprite_index = spr_exe_hurt;
					break;
					
				case EXE_CHAOS:
					if(global.player.slimeTimer > 0)
						global.player.sprite_index = spr_chaos_sidle;
					else
						global.player.sprite_index = spr_chaos_hurt;
					break;
					
				case EXE_EXETIOR:
					global.player.sprite_index = spr_exetior_hurt;
					break;
					
				case EXE_EXELLER:
					global.player.sprite_index = spr_exeller_hurt;
					break;
			}
			break;
			
		case CHARACTER_TAILS:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_etails_hurt;
			else
				global.player.sprite_index = spr_tails_hurt;
			break;
			
		case CHARACTER_KNUX:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_eknux_hurt;
			else
				global.player.sprite_index = spr_knux_hurt;
			break;
			
		case CHARACTER_EGGMAN:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_eegg_hurt;
			else
				global.player.sprite_index = spr_egg_hurt;
			break;
			
		case CHARACTER_AMY:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_eamy_hurt;
			else
				global.player.sprite_index = spr_amy_hurt;
			break;
			
		case CHARACTER_CREAM:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_ecream_hurt;
			else
				global.player.sprite_index = spr_cream_hurt;
			break;
			
		case CHARACTER_SALLY:
			if(global.player.revivalTimes >= 2)
				global.player.sprite_index = spr_esally_hurt;
			else
				global.player.sprite_index = spr_sally_hurt;
			break;
	}
	
	global.player.image_speed = 0.5;
}