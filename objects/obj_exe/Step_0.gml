/// @description General movement
if(shockedTimer <= 0)
{
	scr_move_basic();
}
else
{
	isBoosting = false;
	isLookingDown = false;
	isLookingUp = false;
	isAttacking = false;
	isJumping = false;
	gspd -= min(abs(gspd), acc) * sign(gspd); 
	xspd -= min(abs(xspd), acc) * sign(xspd); 
	shockedTimer--;
	hurttime = 60 * 2;
}

if(won || lost)
{
	gspd = 0;
	xspd = 0;
	angle = 0;
}

scr_collision_basic();

if(invisTimer <= 0 && bounceTimer <= 0)
{
	var list = ds_list_create();
	instance_place_list(x, y, obj_player_puppet, list, false);
	
	for(var i = 0; i < ds_list_size(list); i++)
	{
		var inst = list[| i];
		
		if(inst.isDemonized)
			continue;
			
		if(inst.isInactive)
			continue;
			
		if(inst.isHurt)
			continue;
		
		var jumping = (inst.state == JUMP || inst.state == SPIN);
		if(jumping && (isJumping || isSpinning))
		{
			if(inst.character == CHARACTER_EGGMAN || inst.character == CHARACTER_AMY || inst.character == CHARACTER_SALLY)
				continue;
				
			var dirX = sign(inst.x - x);
			var dirY = sign(inst.y - y);
			
			scr_player_hurt(0, -dirX * 3, -dirY * 4, snd_buble, spr_blood2, true);
			
			bounceTimer = 6;
		}
		
		if((isJumping || isSpinning) && (inst.hp > 0 && !inst.isHurt))
			scr_camera_shake(30, 1, 0.15);
	}
	
	ds_list_destroy(list);
}


if(hurttime > 0)
	hurttime--;