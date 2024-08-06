//if(os_type == os_windows)
//{
//	if(!init_multiplayer())
//		room_goto(room_you_are_failure);
//}

global.init = false;
global.score = 0;
global.player = obj_exe;
global.playerControls = true;
global.cameraMode = 0;
global.lives = 3;
global.showHud = true;
global.paused = false;
global.errorCode = -1;
global.muteChat = false;

global.ringId = 0;
global.ringFrame = 0;
global.character = -1;
global.exeCharacter = -1;
global.nickname = "player";
global.configInit = false;
global.palleteFrom = [];
global.palleteTo = [];
global.palleteName = "defualt";

//Keys
global.KeyLeft = vk_left;
global.KeyRight = vk_right;
global.KeyUp = vk_up;
global.KeyDown = vk_down;
global.KeyA = ord("Z");
global.KeyB = ord("X");
global.KeyC = ord("C");
global.KeyEm1 = ord("A");
global.KeyEm2 = ord("S");
global.KeyEm3 = ord("D");
global.KeyHide = vk_lcontrol;
global.KeyPList = vk_tab;
global.KeyIdle = ord("W");

#macro MAP_FART 20

global.levels = 
[
	{ group: "HideAndSeek2", rid: room_hideandseek2, bg: background_hn2, music: mus_hideandseek2, chaseMusic: mus_hideandseek2_chase },
	{ group: "RavineMist", rid: room_ravinemist, bg: background_rm, music: mus_ravimemist, chaseMusic: mus_ravimemist_chase },
	{ group: "DotDotDot", rid: room_dotdotdot, bg: background_dotdotdot, music: mus_dotdotdot, chaseMusic: mus_dotdotdot_chase },
	{ group: "DesertTown", rid: room_deserttown, bg: background_dt, music: mus_deserttown, chaseMusic: mus_deserttown_chase },
	{ group: "YouCantRun", rid: room_youcantrun, bg: background_ycr, music: mus_youcantrun, chaseMusic: mus_youcantrun_chase },
	{ group: "LimpCity", rid: room_limpcity, bg: background_limpcity, music: mus_limpcity, chaseMusic: mus_limpcity_chase },
	{ group: "NotPerfect", rid: room_notperfect, bg: background_notperf, music: mus_notperfect, chaseMusic: mus_notperfect_chase },
	{ group: "KindaFair", rid: room_kindandfair, bg: background_knf, music: mus_kindandfair, chaseMusic: mus_kindandfair_chase },
	{ group: "Act9", rid: room_act9, bg: background_act9, music: mus_act9, chaseMusic: mus_act9_chase },
	{ group: "NastyParadise", rid: room_nastyparadise, bg: background_nap, music: mus_nastyparadise, chaseMusic: mus_nastyparadise_chase },
	{ group: "PricelessFreedom", rid: room_pricelessfreedom, bg: background_pf, music: mus_pricelessfreedom, chaseMusic: mus_pricelessfreedom_chase },
	{ group: "VolcanoValley", rid: room_volcanovalley, bg: background_vv, music: mus_volcanovalley, chaseMusic: mus_volcanovalley_chase },
	{ group: "Hill", rid: room_greenhill, bg: background_greenhill, music: mus_hill, chaseMusic: mus_hill_chase },
	{ group: "MajinForest", rid: room_majongforest, bg: background_majong, music: mus_majinforest, chaseMusic: mus_majinforest_chase },
	{ group: "HideAndSeek", rid: room_angelisland, bg: background_aiz5, music: mus_angelisland, chaseMusic: mus_angelisland_chase },
	{ group: "TortureCave", rid: room_torturecave, bg: background_am, music: mus_torturecave, chaseMusic: mus_torturecave_chase },
	{ group: "DarkTower", rid: room_dartower, bg: background_darktower, music: mus_darktower, chaseMusic: mus_darktower_chase },
	{ group: "HauntDream", rid: room_haundream, bg: background_darktower, music: mus_hauntdream, chaseMusic: mus_hauntdream_chase },
	{ group: "WoodDream", rid: room_weedzone, bg: background_weed, music: mus_weedzone, chaseMusic: mus_weedzone_chase },
	{ group: "Marijuna", rid: room_marijuna, bg: background_weed, music: mus_marijuna, chaseMusic: mus_marijuna_chase },
	{ group: "Fart", rid: room_fartzone, bg: background_test, music: mus_fartzone, chaseMusic: mus_fartzone_chase },
];

global.levelDescriptions = 
[
	"long and spacious map with no less spacious boxes to hide behind, using       \nsprings echoes all over the cave, revealing your location to exe |+25 sec.",
	"6 shards have to be collected to access the exit on the last minute, collected\nshards will lead you to the exit. avoid slugs that feed on rings, kill them  \nto obtain the ring if they devour one",
	"long stairway with three floors, you can't run on stairs and the lower you go \n- the darker it gets |+25 sec.",
	"high buildings will serve you a hideout, it's hard to break away here, but you\ncan hide almost everywhere",
	"constant gas leaks will fill the areas poisoning you and causing you to       \nhallucinate, revealing your location to exe ",
	"the city is limp but not blind, you can be watched through eye cameras or use \nthem yourself, there are the circuits that periodically activate blocking the \npassages |-25 sec.",
	"map rotates every 30 seconds, the floor becomes walls and the walls become the\nfloor, the exit is available on only one turn |-25 sec.",
	"avoid breaking speed monitors, as they will launch you right in the spikes    \nwithout letting you stop running until you meet a wall or get hurt",
	"you can see only the silhouettes, the walls are slowly shrickening, avoid     \ngetting cornered if you don't want to be squished |-50 sec. +10 sec. for each\nsurvivor instead of 25",
	"giant snowballs roll down the slopes, damaging and slowing you down.\nsometimes springs and rings cover with ice |-25 sec.",
	"escape with elevators and avoid black rings that will drain your health upon  \ngetting them, damage from them can be avoided by having 5 rings |-25 sec. +10 \nsec. for each survivor instead of 25",
	"long map filled with lava pits, some of which burst with lava pillars. break  \nthe pots to get more rings",
	"long linear map filled with water that slows you down. when the lightning     \nstrikes, don't touch the water",
	"wherever you run - you will never reach the end, there are no bounds, fun is   \ninfinite |-25 sec. +10 sec. for each survivor instead of 25",
	"hide behind palm trees and bushes, moving along the ziplines",
	"an abandoned mine illuminated only by searchlights, sometimes acid evaporates \nincreasing its area, stay away from it unless you're a fan of sulfuric acid  \nbaths |-25 sec.",
	"don't stand under stalactites, they will fall if you walk under them. every 10 \nseconds it gets dark for a while, at this time try not to run into the owner  \nof this place |+25 sec.",
	"you will be able to open the passages by activating the crystals. hold the jump  \nor up on special springs so that they throw you higher, and most importantly, \ndo not wake up |+25 sec.",
	"be careful on conveyor belts and get to ignited lanterns to banish spirit that \nhaunts the forest, before things get even darker |-25 sec",
	"you better not touch the crystals releasing the phantom energy, otherwise it \nwill be difficult for you to move and avoid traps of the ancient temple \n|+25 sec"
];