_timer++;

if(!_fade && _timer > 60 * 10)
{
	_fade = true;
	_timer = 0;
}

if(_fade && _timer > 60 * 1)
{
	_fade = false;
	_timer = 0;
}

if(_fade)
{
	if(_alpha < 1)
		_alpha += 0.016;
}
else
{
	if(_alpha > 0)
		_alpha -= 0.016;
}

draw_sprite_ext(spr_black, 0, 0, 0, 1, 1, 0, c_white, _alpha);