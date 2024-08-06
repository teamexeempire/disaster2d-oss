// Default player values

#macro EXELLER_CLONE_RECHARGE (60 * 30)
#macro EXELLER_MAXSPEED 12
#macro EXELLER_ACC 0.056875

//Variables
gspd = 0;
xspd = 0;
yspd = 0;
state = 0;
angle = 0;
hurttime = 0;
rings = 0;
lookTimer = 0;
effectTime = 0;
attackTimer = 0;
shockedTimer = 0;
deadTimer = 31;
deadColor = c_white;
invisTimer = 0;
revivalTimes = 0;
redRingTimer = 0;
attackSpeed = 0;
bounceTimer = 0;

clones = [ -1, -1 ];
cloneTimer = 0;
cloneCount = 0;

shards = 0;

//General
hp = 10000;
isGrounded = false;
isJumping = false;
isLookingUp = false;
isLookingDown = false;
isDead = false;
isHurt = false;
isAttacking = false;
isSpinning = false;
isHiding = false;
won = false;
lost = false;
justJumped = false;
emotion = false;
emotionSnd = snd_none;
isBoosting = false;
isZipline = false;
isOnEdge = false;
edgeDir = 1;

taunt1 = array_contains(obj_unlockables.trades, "texeller0");
taunt2 = array_contains(obj_unlockables.trades, "texeller1");

// DIANA SPECIFIC
doubleJump = false;

//Character flags (constants)
canLookDown = true;
canLookUp = true;
canSpinDash = false;
canSpin = true;
specialFunc = scr_exeller_special; /* Function with abilities */

//constants
acc = EXELLER_ACC;
maxHSpeed = EXELLER_MAXSPEED;
maxYSpeed = 12;
yAccel = 0.21875; //gravity
jumpForce = 7;
isSlow = false;

lostState = choose(EXELLER_LOST, EXELLER_LOST2);

instance_create_depth(x, y, 0, obj_exetior_indicator);
instance_create_depth(x, y, 0, obj_exeller_indicator);
instance_create_depth(x, y, 0, obj_exeller_indicator_up);
instance_create_depth(x, y, 0, obj_exeller_indicator_down);
instance_create_depth(x, y, 0, obj_exe_sprindicator);

// Create sensors
instance_create_depth(x, y, 0, obj_player_sensorTL);
instance_create_depth(x, y, 0, obj_player_sensorTR);
instance_create_depth(x, y, 0, obj_player_sensorL);
instance_create_depth(x, y, 0, obj_player_sensorR);
instance_create_depth(x, y, 0, obj_player_sensorBL);
instance_create_depth(x, y, 0, obj_player_sensorBR);
instance_create_depth(x, y, 0, obj_player_sensorAL);
instance_create_depth(x, y, 0, obj_player_sensorAR);

global.playerControls = false;