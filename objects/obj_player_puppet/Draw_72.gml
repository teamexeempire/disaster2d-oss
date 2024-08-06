if(character == -1)
	return;
	
if(potater)
{
	sprite_index = spr_merfurmu;
	return;
}
	
if(character == CHARACTER_EXE)
{
	var arr = global.player_exesanims;
	
	if(state >= array_length(arr[? exeCharacter]))
		return;
		
	var offset = 0;
	if(slimeMode)
		offset = CHAOS_AIRTRANSFORM+1;
		
	sprite_index = arr[? exeCharacter][state + offset];
}
else
{
	var arr = revivalTimes >= 2 ? global.player_eanims : global.player_anims;
	
	if(state >= array_length(arr[? character]))
		return;
	
	sprite_index = arr[? character][state];
}