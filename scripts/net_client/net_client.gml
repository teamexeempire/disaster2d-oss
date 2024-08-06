global.tcp_buffer = buffer_create(256, buffer_fixed, 1);
global.udp_buffer = buffer_create(256, buffer_fixed, 1);

function cpacket_tcp(type, passtrough = false)
{
	buffer_seek(global.tcp_buffer, buffer_seek_start, 0);
	buffer_write(global.tcp_buffer, buffer_u8, passtrough);
	buffer_write(global.tcp_buffer, buffer_u8, real(type));
	
	return global.tcp_buffer;
}

function cpacket_udp(type, passtrough = false)
{
	buffer_seek(global.udp_buffer, buffer_seek_start, 0);
	buffer_write(global.udp_buffer, buffer_u8, passtrough);
	buffer_write(global.udp_buffer, buffer_u8, real(type));
		
	return global.udp_buffer;	
}

function send_server_tcp(buffer)
{		
	with(obj_netclient)
	{		
		var size = buffer_tell(buffer);
		disnet_send(buffer_get_address(buffer), size, true);
	}
}

function send_server_udp(buffer)
{
	with(obj_netclient)
	{
		var size = buffer_tell(buffer);
		disnet_send(buffer_get_address(buffer), size, false);
	}
}

function buffer_read_s(buffer, type)
{
	var sz = buffer_sizeof(type);
	if(buffer_tell(buffer) + sz > buffer_get_size(buffer))
	{		
		return -1;
	}
	
	return buffer_read(buffer, type);
}
