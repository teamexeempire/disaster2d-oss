scroll = lerp(scroll, tmpScroll, 0.2);

if(keyboard_check(global.KeyUp))
	move(1);
else if(keyboard_check(global.KeyDown))
	move(-1);

for(var i = 0; i < 50; i++)
	draw_sprite_part_ext(spr_achivements, 0, 0, i * 38, 428, 38, 480 / 2 - sprite_width / 2, 270 / 2 + i * 38 + scroll, 1, 1, obj_achivements.achivements[i] ? #0fff39 : c_white, 1);

for(var j = 0; j < array_length(obj_achivements.changed); j++)
	draw_sprite(spr_achivements_new, 0, 480 / 2 - sprite_width / 2, 270 / 2 + obj_achivements.changed[j] * 38 + scroll);