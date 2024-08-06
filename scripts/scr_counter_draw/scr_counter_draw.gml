function scr_counter_draw(number, xx, yy)
{
	draw_sprite(spr_counter, number, xx, yy);
}

function scr_counter_draw_m(number, xx, yy, numOfZeros)
{
	var str = string(number);
	var dif = numOfZeros - string_length(str);
	var xX = 0;
	
	for(var i = 0; i < dif; i++)
	{
		draw_sprite(spr_counter, 0, xx + 11 * i, yy);
		xX += 11;
	}
	
	for(var i = 0; i < string_length(str); i++)
	{
		var st = string_char_at(str, i+1);
		var num = real(st);
		draw_sprite(spr_counter, num, xx + xX + 11 * i, yy);
	}
}

function scr_counter_draw_s(number, xx, yy)
{
	var str = string(number);
	var xX = 0;
	
	for(var i = 0; i < string_length(str); i++)
	{
		var st = string_char_at(str, i+1);
		var num = real(st);
		draw_sprite(spr_counter, num, xx + xX + 11 * i, yy);
	}
}

function scr_counter_draw_r(number, xx, yy)
{
	var str = string(number);
	var len = string_length(str);
	xx -= (len - 1) * 11;
	
	for(var i = 0; i < len; i++)
	{
		var st = string_char_at(str, i+1);
		var num = real(st);
		draw_sprite(spr_counter, num, xx + 11 * i, yy);
	}
}