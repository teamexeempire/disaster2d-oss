// Default player values
depth = obj_spawnpoint.depth + 2;
//Variables
master_id = 0;
is_cheating = 0;

character = 0;
exeCharacter = 0;

hp = 100;
nickname = "";
nicknameWidth = 0;
rings = 0;
shards = 0;

isDemonized = false;
isAttacking = false;
isHurt = false;
reviveObj = noone;
revivalTimes = 0;
xspd = 0;
yspd = 0;
pX = x;
pY = y;
image_speed = 0;
isHiding = false;
hasRedRing = false;
deadTimer = 31;
deadColor = c_white;

tailsCharge = 0;
sallyShield = false;
slimeMode = false;

isInactive = false;
state = 0;
angle = 0;
effect = false;
effectTimer = 0;
emitter = audio_emitter_create();
audio_emitter_falloff(emitter, 250, 500, 1);

reviveObj = instance_create_depth(x, y, 0, obj_revival_puppet);
healObj = instance_create_depth(x, y, 0, obj_heal_progress);

fromPallete = [ 0 ];
toPallete = [ 0 ];
petFromPallete = [ 0 ];
petToPallete = [ 0 ];

palleteName = "";

potater = false;
potatoTimer = 0;