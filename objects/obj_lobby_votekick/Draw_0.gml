if(obj_lobby.state != 0)
{
	instance_destroy();
	return;
}

var i = 0;
var plr = noone;

for(var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k))
{
	var player = obj_netclient.players[? k];
	
	if(player.pending)
		continue;
	
	if(player.nid == obj_netclient.nid)
		continue;
		
	if(ind == i)
		plr = player;
		
	i++;
}

if(plr != noone && keyboard_check_pressed(global.KeyA))
{
	var pak = cpacket_tcp(packet);
	buffer_write(pak, buffer_u16, plr.nid);
	send_server_tcp(pak);
	
	instance_destroy();
	return;
}

if(plr != noone && keyboard_check_pressed(global.KeyB))
{
	instance_destroy();
	return;
}

if(i <= 0)
{
	instance_destroy();
	return;
}

if(keyboard_check_pressed(global.KeyLeft))
	ind--;

if(keyboard_check_pressed(global.KeyRight))
	ind++;

if(ind < 0)
	ind = i - 1;
else if(ind >= i)
	ind = 0;
	
var xx = 40 + ind * 80;
var yy = 58;

draw_sprite(spr_lobby_icon_arrow, current_time / 300.0, xx, yy);