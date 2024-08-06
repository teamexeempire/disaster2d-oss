// Default player values

#macro CHAOS_MAXSPEED 12
#macro CHAOS_ACC 0.056875
#macro CHAOS_INVIS_RECHARGE (60 * 20)
#macro CHAOS_INVIS_DURATION (60 * 15)

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
dashDirX = 0;
dashDirY = 0;
revivalTimes = 0;
redRingTimer = 0;
attackSpeed = 0;
bounceTimer = 0;
shards = 0;
dashedIntoPussy = 0;
stuckTimer = 0;
stuckDir = 0;
stuckDashTimer = 0;
leftPressed = false;
rightPressed = false;
upPressed = false;
canMove = true;

slimeTimer = -CHAOS_INVIS_RECHARGE;
slimeAnim = false;

//General
hp = 10000;
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
isOnEdge = false;
edgeDir = 1;

taunt1 = array_contains(obj_unlockables.trades, "tchaos0");
taunt2 = array_contains(obj_unlockables.trades, "tchaos1");

// DIANA SPECIFIC
doubleJump = false;

//Character flags (constants)
canLookDown = true;
canLookUp = true;
canSpinDash = false;
canSpin = true;
specialFunc = scr_chaos_special; /* Function with abilities */

//constants
acc = CHAOS_ACC;
maxHSpeed = CHAOS_MAXSPEED;
maxYSpeed = 12;
yAccel = 0.21875; //gravity
jumpForce = 7;
isSlow = false;

lostState = choose(CHAOS_LOST, CHAOS_LOST2);

instance_create_depth(x, y, 0, obj_exe_indicator);
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