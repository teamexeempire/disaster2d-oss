x = oX + sin(current_time / 200 + delay) * 2;
y = oY + offset;

if(angle_timer-- <= 0)
{
	angle = choose(-16, 16, -8, 8);
	angle_timer = 60;
}

image_angle = angle;
image_index = floor((charge / 100.0) * 5);

var use = used && useID == obj_netclient.nid;
if(abs(angle) > 0)
	angle -= 0.5 * sign(angle);
	
if(!instance_exists(global.player))
	return;
	
if(global.player.isDead)
	return;

if(place_meeting(x, y, global.player))
{
	var lookDown = global.player.isLookingDown;
	var lookUp = global.player.isLookingUp;
	over = true;
	
	if(!use && !requested)
	{
		if(charge < 20)
			return;
			
		if(lookDown)
		{
			var packet = cpacket_tcp(PacketType.CLIENT_LCEYE_REQUEST_ACTIVATE);
			buffer_write(packet, buffer_bool, true);
			buffer_write(packet, buffer_u8, nid);
			buffer_write(packet, buffer_u8, target1);
			send_server_tcp(packet);
			requested = true;
		}
		else if(lookUp)
		{
			var packet = cpacket_tcp(PacketType.CLIENT_LCEYE_REQUEST_ACTIVATE);
			buffer_write(packet, buffer_bool, true);
			buffer_write(packet, buffer_u8, nid);
			buffer_write(packet, buffer_u8, target2);
			send_server_tcp(packet);
			requested = true;
		}
	}
	
	if(use && !lookDown && !lookUp)
	{
		var packet = cpacket_tcp(PacketType.CLIENT_LCEYE_REQUEST_ACTIVATE);
		buffer_write(packet, buffer_bool, false);
		buffer_write(packet, buffer_u8, nid);
		buffer_write(packet, buffer_u8, target2);
		send_server_tcp(packet);
		global.cameraMode = 0;
	}
}
else
{
	if(use)
	{
		var packet = cpacket_tcp(PacketType.CLIENT_LCEYE_REQUEST_ACTIVATE);
		buffer_write(packet, buffer_bool, false);
		buffer_write(packet, buffer_u8, nid);
		buffer_write(packet, buffer_u8, target2);
		send_server_tcp(packet);
		global.cameraMode = 0;
	}
	
	requested = false;
	over = false;
}