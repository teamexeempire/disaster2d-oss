zstart = noone;
zend = noone;
zspeed = 0.001;
zvspeed = 0;
hasPlayer = false;
timeout = 0;
camY = 0;
progress = 0;


_holdPlayer = function()
{	
	global.player.xspd = 0;
	global.player.yspd = 0;
	global.player.image_xscale = sign(zend.x - zstart.x);
	global.player.isSpinning = false;
	global.player.isJumping = false;
	global.player.isGrounded = false;
	global.player.isHurt = false;
	global.player.isAttacking = false;
	global.player.isZipline = true;
	global.player.angle = 0;
	global.playerControls = false;
}