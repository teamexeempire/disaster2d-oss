if(effect)
{
	if(character == CHARACTER_EXE)
	{
		if(exeCharacter == 1)
		{
			if(effectTimer % irandom_range(5, 6) == 0)
				instance_create_depth(x + irandom_range(-8, 8), y, depth+10, obj_chaos_kapla);
		}
	}
	
	if(effectTimer % 3 == 0)
	{
		var inst = scr_effect_fade_quick(x, y, sprite_index);
		inst.depth = depth + 1;
		inst.image_xscale = image_xscale;
		inst.image_index = image_index;
		inst.image_speed = 0;
		inst.palleteFrom = fromPallete;
		inst.palleteTo = toPallete;
	}
	
	effectTimer++;
}
 
switch(character)
{		
	case CHARACTER_KNUX:		
		if(state == KNUX_GLIDE)
			image_xscale = 1;
		break;
}

scr_palette_swap(fromPallete, toPallete);
draw_sprite_ext(is_cheating ? spr_merfurmu : sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, angle, image_blend, (isHurt || isHiding) ? 0.5 : image_alpha);
shader_reset();

if(potater)
	draw_sprite(spr_goodperson, potatoTimer, floor(x), floor(y)); 
	
if(is_cheating)
	draw_sprite(spr_some, 0, x, y);

switch(character)
{
	case CHARACTER_EXE:
		switch(exeCharacter)
		{
			case EXE_ORIGINAL:
				if(state == EXE_ZIPLINE)
					draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 22 - 19);
				break;
				
				
			case EXE_CHAOS:
				if(state == CHAOS_ZIPLINE)
					draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 22 - 19);
				break;
				
				
			case EXE_EXELLER:
				if(state == EXELLER_ZIPLINE)
					draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 22 - 19);
				break;
				
				
			case EXE_EXETIOR:
				if(state == EXETIOR_ZIPLINE)
					draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 22 - 19);
				break;
		}
		break;
		
	case CHARACTER_TAILS:	
		if(state == TAILS_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 11 - 19);
		
		if(tailsCharge > 0)
			draw_sprite_ext(spr_tailscharge, floor((((tailsCharge / 60)) / 5.0) * 100), x + image_xscale * 24, y, image_xscale, 1, 0, c_white, 1);
		break;
		
	case CHARACTER_KNUX:
		if(state == KNUX_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 22 - 19);
		break;
		
	case CHARACTER_EGGMAN:
		if(state == EGG_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 25 - 19);
		
		if(isAttacking)
			draw_sprite(spr_electroshield, (current_time / 30) % 41, floor(x), floor(y));
		break;
		
	case CHARACTER_AMY:
		if(state == AMY_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 21 - 19);
		break;
		
	case CHARACTER_CREAM:
		if(state == CREAM_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 8 - 19);
		break;
		
	case CHARACTER_SALLY:
		if(state == SALLY_ZIPLINE)
			draw_sprite(spr_aiz_zipline, 0, floor(x) - 12, floor(y) - 18 - 19);
		
		if(sallyShield)
			draw_sprite(revivalTimes >= 2 ? spr_sallyshield2 : spr_sallyshield, (current_time / 30) % 41, floor(x), floor(y));
		break;
}