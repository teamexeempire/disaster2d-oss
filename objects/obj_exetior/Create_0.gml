// Default player values

#macro EXETIOR_MAXSPEED 11
#macro EXETIOR_ACC 0.051875
#macro EXETIOR_BRING_RECHARGE (42 * 60)

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
bringTimer = 0;
shards = 0;

//General
hp = 10000;
canMove = true;
isGrounded = false;
prevGrounded = true;
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
isStomping = false;
justLanded = false;
canSpawnRings = true;
isOnEdge = false;
edgeDir = 1;

taunt1 = array_contains(obj_unlockables.trades, "texetior0");
taunt2 = array_contains(obj_unlockables.trades, "texetior1");

// DIANA SPECIFIC
doubleJump = false;

//Character flags (constants)
canLookDown = true;
canLookUp = true;
canSpinDash = false;
canSpin = true;
specialFunc = scr_exetior_special; /* Function with abilities */

//constants
acc = EXETIOR_ACC;
maxHSpeed = EXETIOR_MAXSPEED;
maxYSpeed = 12;
yAccel = 0.21875; //gravity
jumpForce = 7;
isSlow = false;

instance_create_depth(x, y, 0, obj_exetior_indicator);
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