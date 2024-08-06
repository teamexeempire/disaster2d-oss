timeMin = 0;
timeSec = 0;
index = 0;
showBlack = true;
result = 0;

var packet = cpacket_tcp(PacketType.CLIENT_RESULTS_REQUEST);
send_server_tcp(packet);

audio_stop_all();