if(!instance_exists(global.player))
	return;

if(obj_netclient.nid == pid)
{
	global.player.state = HURT;
	global.player.isHurt = false;
}