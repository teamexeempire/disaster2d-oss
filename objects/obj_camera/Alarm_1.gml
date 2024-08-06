if(instance_exists(global.player) && global.player.hp > 0)
	return;
	
if(spectatingObj != noone && spectatingObj.character == CHARACTER_EXE)
	return;
	
spectatingObj = noone;
spectatingInd = 0;
global.cameraMode = 2;