// Default player values

#macro AMY_ATTACK_RECHARGE (60 * 20)
#macro AMY_EXEATTACK_RECHARGE (60 * 5)
#macro AMY_BIGJUMP_RECHARGE (60 * 9)
#macro AMY_MAXSPEED 11
#macro AMY_ACC 0.046875

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
revivalTimes = 0;
deadTimer = 31;
deadColor = c_white;
shockedTimer = 0;
reviveObj = instance_create_depth(x, y, 0, obj_revival_puppet);
redRingTimer = 0;
deadTimer = 0;
bounceTimer = 0;
shards = 0;
chunkX = -1000;
chunkY = -1000;
chunkTimer = 0;

attackTimer = 0;
hjumpTimer = 0;
isHJ = false;

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
isAttacking = false;
isHiding = false;
justJumped = false;
emotion = false;
isBoosting = false;
isZipline = false;
isOnEdge = false;
edgeDir = 1;

// DIANA SPECIFIC
doubleJump = false;

//Character flags (constants)
canLookDown = true;
canLookUp = true;
canSpinDash = true;
canSpin = false;
specialFunc = scr_amy_special; /* Function with abilities */

//constants
acc = AMY_ACC;
maxHSpeed = AMY_MAXSPEED;
maxYSpeed = 12;
yAccel = 0.21875; //gravity
jumpForce = 7;
isSlow = false;

// Create sensors
instance_create_depth(x, y, 0, obj_player_sensorTL);
instance_create_depth(x, y, 0, obj_player_sensorTR);
instance_create_depth(x, y, 0, obj_player_sensorL);
instance_create_depth(x, y, 0, obj_player_sensorR);
instance_create_depth(x, y, 0, obj_player_sensorBL);
instance_create_depth(x, y, 0, obj_player_sensorBR);
instance_create_depth(x, y, 0, obj_player_sensorAL);
instance_create_depth(x, y, 0, obj_player_sensorAR);