if(global.showHud && isMobile)
{
	if(jUse)
	{
		draw_sprite_ext(spr_mobile_dpad, jDir, obj_config.dpadX, obj_config.dpadY, obj_config.jScale, obj_config.jScale, 0, c_white, jTouchId == -1 ? obj_config.jOpacity : obj_config.jOpacity + 0.15);
		
		draw_sprite_ext(spr_mobile_emotionbutton, DTouchId == -1 ? 0 : 1, obj_config.bDX, obj_config.bDY, obj_config.bDScale, obj_config.bDScale, 0, c_white, DTouchId == -1 ? obj_config.bDOpacity : obj_config.bDOpacity + 0.15);
		draw_sprite_ext(spr_mobile_emotionbutton, ETouchId == -1 ? 2 : 3, obj_config.bEX, obj_config.bEY, obj_config.bEScale, obj_config.bEScale, 0, c_white, ETouchId == -1 ? obj_config.bEOpacity : obj_config.bEOpacity + 0.15);
		draw_sprite_ext(spr_mobile_emotionbutton, FTouchId == -1 ? 4 : 5, obj_config.bFX, obj_config.bFY, obj_config.bFScale, obj_config.bFScale, 0, c_white, FTouchId == -1 ? obj_config.bFOpacity : obj_config.bFOpacity + 0.15);
		draw_sprite_ext(spr_mobile_emotionbutton, GTouchId == -1 ? 6 : 7, obj_config.bGX, obj_config.bGY, obj_config.bGScale, obj_config.bGScale, 0, c_white, GTouchId == -1 ? obj_config.bGOpacity : obj_config.bGOpacity + 0.15);
		draw_sprite_ext(spr_mobile_emotionbutton, WTouchId == -1 ? 8 : 9, obj_config.bWX, obj_config.bWY, obj_config.bWScale, obj_config.bWScale, 0, c_white, WTouchId == -1 ? obj_config.bWOpacity : obj_config.bWOpacity + 0.15);
	}
	
	if(bUse)
	{
		draw_sprite_ext(spr_mobile_button, ATouchId == -1 ? 0 : 1, obj_config.bAX, obj_config.bAY, obj_config.bAScale, obj_config.bAScale, 0, c_white, ATouchId == -1 ? obj_config.bAOpacity : obj_config.bAOpacity + 0.15);
		draw_sprite_ext(spr_mobile_button, BTouchId == -1 ? 2 : 3, obj_config.bBX, obj_config.bBY, obj_config.bBScale, obj_config.bBScale, 0, c_white, BTouchId == -1 ? obj_config.bBOpacity : obj_config.bBOpacity + 0.15);
		draw_sprite_ext(spr_mobile_button, CTouchId == -1 ? 4 : 5, obj_config.bCX, obj_config.bCY, obj_config.bCScale, obj_config.bCScale, 0, c_white, CTouchId == -1 ? obj_config.bCOpacity : obj_config.bCOpacity + 0.15);
	}
}