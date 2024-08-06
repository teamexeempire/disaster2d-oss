if(state == 0)
{
	draw_sprite(spr_lobby_bars, 0, 0, 0);
	
	if(countScale > 1)
		countScale -= 0.02;
		
	if(isCounting && !voteKick)
		draw_sprite_ext(spr_countdown, countdown - 1,  480/2, 13, countScale, countScale, 0, c_white, 1);
	else
		draw_sprite(voteKick ? spr_lobby_votekick : spr_lobby_waiting, (current_time / 300) % 4, 240, 8);
		
	var str = "";
	for(var i = 0; i < array_length(chat); i++)
		str += $"{chat[i]}\n";
	
	scr_text_spr(3, 148-6, str);
	
	var ind = chatMode;
	if(string_length(chatMsg) > 0)
		ind = 1;
	
	draw_sprite(spr_lobby_chatbox, ind, 0, 211);
	scr_text_spr(2, 214, chatMsg);
	scr_text_spr(170, 256, $"\\\your chance to be exe: {obj_netclient.chance}%");
}
else if(state == 1)
{		
	draw_sprite(spr_vote_bars, 0, 0, 0);
	
	if(countScale > 1)
		countScale -= 0.02;
		
	draw_sprite_ext(spr_counter3, voteTimer, 480/2, 13, countScale, countScale, 0, c_white, 1);
	
	var col = c_dkgray;
	if(mapChosen == 0 && !mapChose)
		col = c_white;
	
	draw_sprite_ext(spr_mapvote, map1, 16, 58 + 20 * mapFade - (mapChosen == 0 ? mapOff : 0), 1, 1, 0, col, mapFade);
	
	var col = c_dkgray;
	if(mapChosen == 1 && !mapChose)
		col = c_white;
	
	draw_sprite_ext(spr_mapvote, map2, 179, 58 + 20 * mapFade - (mapChosen == 1 ? mapOff : 0), 1, 1, 0, col, mapFade);
	
	var col = c_dkgray;
	if(mapChosen == 2 && !mapChose)
		col = c_white;
		
	draw_sprite_ext(spr_mapvote, map3, 341, 58 + 20 * mapFade - (mapChosen == 2 ? mapOff : 0), 1, 1, 0, col, mapFade);
	
	if(mapFade < 1)
		mapFade += 0.016;
		
	if(mapOff > 0)
		mapOff -= 0.32;
	
	var _map = map1;
	
	if(mapChosen == 1)
		_map = map2;
		
	if(mapChosen == 2)
		_map = map3;
		
	with(obj_lobby_prolet)
	{
		visible = true;
		image_blend = c_dkgray;

		if(map != _map)
			setZone(_map);
	}
	
	scr_text_spr(4, 233, global.levelDescriptions[_map]);
	if(!mapChose)
		return;
	
	var col = c_white;
	if(mapChose && mapChosen == 0)
		col = #27ff23;
	
	draw_sprite_ext(spr_counter2, map1Votes, 16 + 61, (58 + 20 * mapFade - (mapChosen == 0 ? mapOff : 0)) + 53, 1, 1, 0, col, 1);
	
	var col = c_white;
	if(mapChose && mapChosen == 1)
		col = #27ff23;
	
	draw_sprite_ext(spr_counter2, map2Votes, 179 + 61, (58 + 20 * mapFade - (mapChosen == 1 ? mapOff : 0)) + 53, 1, 1, 0, col, 1);
	
	var col = c_white;
	if(mapChose && mapChosen == 2)
		col = #27ff23;
	
	draw_sprite_ext(spr_counter2, map3Votes, 341 + 61, (58 + 20 * mapFade - (mapChosen == 2 ? mapOff : 0)) + 53, 1, 1, 0, col, 1);
}
else if(state == 2 || state == 3)
{		
	var sprInd = 0;
	
	with(obj_lobby_icon)
	{
		if(master_id != obj_netclient.nid)
			continue;
			
		sprInd = selected - 1;
		
		if(obj_netclient.exeId == obj_netclient.nid)
			sprInd += CHARACTER_SALLY;
	}
	
	if(obj_netclient.exeId == obj_netclient.nid || obj_netclient.avCharacters[sprInd+1])
		draw_sprite(chars[sprInd], charIndex, 132, 230);
	
	draw_sprite(spr_char_bars, obj_netclient.exeId == obj_netclient.nid, 0, 0);
	draw_sprite(spr_char_info, sprInd, 1, 232-5);
	
	if(countScale > 1)
		countScale -= 0.02;
	
	if(global.character == -1 || (global.character == CHARACTER_EXE && global.exeCharacter == -1))
		draw_sprite_ext(spr_counter3, charTimer, 480/2, 13, countScale, countScale, 0, charTimer <= 3 ? c_red : c_white, 1);

	charIndex += (1.0 / 60.0) * sprite_get_speed(chars[sprInd]);
}