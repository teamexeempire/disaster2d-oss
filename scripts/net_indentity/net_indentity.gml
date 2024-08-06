function net_identity()
{
	var pak = cpacket_tcp(PacketType.IDENTITY, false);
	var osInfo = os_get_info();
	
	buffer_write(pak, buffer_u16, BUILD_VER);
	buffer_write(pak, buffer_s32, obj_netclient.want_lobby);
	buffer_write(pak, buffer_string, global.nickname);
	
	if(os_type != os_android)
	{
		buffer_write(pak, buffer_string, $"mod-{osInfo[? "udid"]}");
	}
	else
	{
		var udid = $"{osInfo[? "VERSION"]}";
		udid += osInfo[? "CPU_ABI"];
		udid += osInfo[? "RELEASE"];
		udid += osInfo[? "MODEL"];
		udid += osInfo[? "DEVICE"];
		udid += osInfo[? "MANUFACTURER"];
		udid += osInfo[? "BOOTLOADER"];
	
		buffer_write(pak, buffer_string, $"mod-{udid}");
	}
	
	buffer_write(pak, buffer_s8, obj_unlockables.lobbyIcon);
	buffer_write(pak, buffer_s8, obj_unlockables.pet);
	buffer_write(pak, buffer_u64, 0);
	buffer_write(pak, buffer_u64, 0);
	
	send_server_tcp(pak);
}