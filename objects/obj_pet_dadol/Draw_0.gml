if(!instance_exists(target))
{
	instance_destroy();
	return;
}

var xspd = target.x - x - target.image_xscale * 32;
var yspd = target.y - y;

bodyX = x - (xspd) * 0.15;
bodyY = y - (yspd) * 0.15;

armsX = bodyX - (xspd) * 0.11;
armsY = bodyY - (yspd) * 0.11;

legsX = bodyX - (xspd) * 0.11;
legsY = bodyY - (yspd) * 0.11;

tailX = bodyX - (xspd) * 0.1;
tailY = bodyY - (yspd) * 0.1;

if(target == global.player)
	scr_palette_swap(obj_unlockables.petPallettes[? 3].from, obj_unlockables.petPallettes[? 3].to);
else
	scr_palette_swap(target.petFromPallete, target.petToPallete);
	
draw_sprite_ext(spr_pet_daldol, 4, tailX, tailY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_pet_daldol, 1, bodyX, bodyY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_pet_daldol, 3, legsX, legsY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_pet_daldol, 2, armsX, armsY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_self();
shader_reset();