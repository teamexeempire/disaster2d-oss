isOwner = false;
isBreaking = false;
isExe = false;
dmg = 0;
charge = 0;
image_speed = 1.2;

_destroy = function()
{
	if(isBreaking)
		return;
		
	isBreaking = true;
	switch(charge)
	{
		case 0:
			sprite_index = spr_tail_ray_dead;
			break;
			
		case 1:
			sprite_index = spr_tail_ray_dead1;
			break;
			
		case 2:
			sprite_index = spr_tail_ray_dead2;
			break;
			
		case 3:
			sprite_index = spr_tail_ray_dead3;
			break;
			
		case 4:
			sprite_index = spr_tail_ray_dead4;
			break;
			
		case 5:
			sprite_index = spr_tail_ray_dead4;
			break;
	}
	image_speed = 1.2;
	
	var pk = cpacket_tcp(PacketType.CLIENT_TPROJECTILE_HIT);
	send_server_tcp(pk);
}