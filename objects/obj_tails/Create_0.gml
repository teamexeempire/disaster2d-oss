// Default player values

#macro TAILS_ATTACK_RECHARGE  (23 * 60)
#macro ETAILS_ATTACK_RECHARGE (12 * 60)
#macro TAILS_MAXSPEED 11
#macro TAILS_ACC 0.046875

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
flyTimer = -420;
flyGrv = 0;
attackTimer = 0;
attackCharge = 0;
attackAfter = 0;
attackKDir = 0;
revivalTimes = 0;
shockedTimer = 0;
deadTimer = 31;
deadColor = c_white;
redRingTimer = 0;
deadTimer = 0;
reviveObj = instance_create_depth(x, y, 0, obj_revival_puppet);
bounceTimer = 0;
shards = 0;
chunkX = -1000;
chunkY = -1000;
chunkTimer = 0;

//General
hp = 100;
isGrounded = false;
isJumping = false;
isLookingUp = false;
isLookingDown = false;
isDead = false;
isHurt = false;
isFlying = false;
isSpinning = false;
justJumped = false;
isHiding = false;
isAttacking = false;
emotion = false;
isBoosting = false;
isZipline = false;
isOnEdge = false;
edgeDir = 1;

// DIANA SPECIFIC
doubleJump = false;

//Character flags (constants)
canMove = true;
canLookDown = true;
canLookUp = true;
canSpinDash = true;
canSpin = true;
specialFunc = scr_tails_special; /* Function with abilities */

//constants
acc = TAILS_ACC;
maxHSpeed = TAILS_MAXSPEED;
maxYSpeed = 12;
yAccel = 0.21875; //gravity
jumpForce = 7;
isSlow = false;
recoil = 0;

instance_create_depth(x, y, 0, obj_tails_tail);

// Create sensors
instance_create_depth(x, y, 0, obj_player_sensorTL);
instance_create_depth(x, y, 0, obj_player_sensorTR);
instance_create_depth(x, y, 0, obj_player_sensorL);
instance_create_depth(x, y, 0, obj_player_sensorR);
instance_create_depth(x, y, 0, obj_player_sensorBL);
instance_create_depth(x, y, 0, obj_player_sensorBR);
instance_create_depth(x, y, 0, obj_player_sensorAL);
instance_create_depth(x, y, 0, obj_player_sensorAR);