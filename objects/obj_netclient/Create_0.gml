#macro BUILD_VER 1101

// Client stuff
isConnected = false;
isReady = false;
isServerReady = false;
nid = -1;
frame = 0;
gameEnds = false;
reconnAttempts = 0;
want_lobby = -1;

buffer = buffer_create(256, buffer_fixed, 1);
ip = "";
port = 8606;
ping = 0;
udp_timeout = 60 * 5;

state = STATE_PENDING;
sendTimeout = 60;
isInit = false;

// Lobby
exeId = 0;
chance = 0;

// Game
lvlId = -1;
pings = ds_map_create();

players = ds_map_create();
avCharacters = 
[ 
	false, //0 (exe) (cannot)
	true,  //1 (tails)
	true,
	true,
	true,
	true,
	true
];

depth = -9999999;