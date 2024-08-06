if(!instance_exists(global.player))
	return;

if(obj_netclient.nid == pid)
{
	global.player.x = x;
	global.player.y = y-16;
	global.player.xspd = 0;
	global.player.yspd = 0;
	global.player.state = HURT;
	global.player.isAttacking = false;
	global.player.isHurt = false;
	global.player.isFlying = false;
	global.player.isSpinning = false;
	global.player.isJumping = false;
	global.player.isGrounded = false;
	global.player.isStomping = false;
	global.player.canMove = true;
}