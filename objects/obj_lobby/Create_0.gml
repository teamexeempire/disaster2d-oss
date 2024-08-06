playerCnt = 0;
countdown = -1;
isCounting = false;
isReady = false;
state = 0;
nextMap = -1;
fade = 0;
countScale = 1;
chat = [ ];
chatMsg = "";
chatMode = false;
charIndex = 0;

chars = 
[
	spr_menu_tails,
	spr_menu_knux,
	spr_menu_egg,
	spr_menu_amy,
	spr_menu_cream,
	spr_menu_sally,
	spr_menu_exe,
	spr_menu_chaos,
	spr_menu_exetior,
	spr_menu_exeller,
];

// Vote
map1 = 0;
map2 = 0;
map3 = 0;
mapOff = 4;
map1Votes = 0;
map2Votes = 0;
map3Votes = 0;
mapChose = false;
mapFade = 0;
mapChosen = 0;
voteTimer = 20;
canUse = false;

charTimer = 30;

voteKick = false;

if(obj_netclient.isConnected && obj_netclient.isReady && obj_netclient.nid != -1)
	instance_create_depth(0, 0, -100, obj_blackfadeout);