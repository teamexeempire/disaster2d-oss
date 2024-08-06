randomize();

palettes = ds_map_create();
petPallettes = ds_map_create();
trades = [];
lobbyIcon = 0;
pet = -1;

_buffer = ds_map_create();
_buffer[? "lobbyIcon"] = 0;
_buffer[? "pet"] = -1;

_buffer[? "petPaletteFrom"] = array_create(7);
_buffer[? "petPaletteTo"] = array_create(7);
_buffer[? "trades"] = [];

load = function(filename)
{
	var _bfr = buffer_load(filename);
	var _tmp = buffer_create(1, buffer_grow, 1);

	for(var i = 0; i < buffer_get_size(_bfr); i++)
		buffer_write(_tmp, buffer_u8, (buffer_read(_bfr, buffer_u8) ^ 69));
	
	buffer_seek(_tmp, buffer_seek_start, 0);

	var _json = buffer_read(_tmp, buffer_string);
	_buffer = json_decode(_json);
	buffer_delete(_bfr);
	buffer_delete(_tmp);

	lobbyIcon = _buffer[? "lobbyIcon"];
	pet = _buffer[? "pet"];

	trades = [];
	for(var j = 0; j < ds_list_size(_buffer[? "trades"]); j++)
		array_push(trades, _buffer[? "trades"][| j]);

	for(var j = 0; j < 7; j++)
	{
		petPallettes[? j] = { 
			from: array_create(ds_list_size(_buffer[? "petPaletteFrom"][| j])), 
			to: array_create(ds_list_size(_buffer[? "petPaletteTo"][| j]))
		};
	
		for(var i = 0; i < ds_list_size(_buffer[? "petPaletteFrom"][| j]); i++)
			petPallettes[? j].from[i] = _buffer[? "petPaletteFrom"][| j][| i];
	
		for(var i = 0; i < ds_list_size(_buffer[? "petPaletteTo"][| j]); i++)
			petPallettes[? j].to[i] = _buffer[? "petPaletteTo"][| j][| i];
	}

	for (var k = ds_map_find_first(_buffer[? "palettes"]); !is_undefined(k); k = ds_map_find_next(_buffer[? "palettes"], k))
	{
		var _bu = _buffer[? "palettes"][? k];
		var _from = array_create(ds_list_size(_bu[? "from"]));
		var _to = array_create(ds_list_size(_bu[? "to"]));
		
		for(var j = 0; j < ds_list_size(_bu[? "from"]); j++)
			_from[j] = _bu[? "from"][| j];
	
		for(var j = 0; j < ds_list_size(_bu[? "to"]); j++)
			_to[j] = _bu[? "to"][| j];
	
		palettes[? real(k)] = {
			to: _to,
			from: _from,
			custom: bool(_bu[? "custom"]),
			name: _bu[? "name"],
			character: _bu[? "character"]
		};
	}
}

save = function()
{
	try
	{
		if(file_exists($"{game_save_id}/2.bson"))
			file_rename($"{game_save_id}/2.bson", $"{game_save_id}/2.bson.bak");
			
		ds_map_delete(_buffer, "palettes");
		ds_map_add_map(_buffer, "palettes", ds_map_create());
	
		_buffer[? "lobbyIcon"] = lobbyIcon;
		_buffer[? "pet"] = pet;
	
		for(var i = 0; i < 7; i++)
		{
			_buffer[? "petPaletteFrom"][| i] = petPallettes[? i].from;
			_buffer[? "petPaletteTo"][| i] = petPallettes[? i].to;
		}
	
		for(var i = 0; i < CHARACTER_SALLY; i++)
		{
			_buffer[? "palettes"][? i + 1] = palettes[? i + 1];
		}
	
		for(var i = 0; i < CHARACTER_SALLY; i++)
		{
			_buffer[? "palettes"][? i + PALETTE_DEMON + 1] = palettes[? i + PALETTE_DEMON + 1];
		}
	
		for(var i = 0; i < EXE_EXELLER+1; i++)
		{
			_buffer[? "palettes"][? i + PALETTE_EXE] = palettes[? i + PALETTE_EXE];
		}

		_buffer[? "trades"] = trades;
	
		var _json = json_encode(_buffer, false);
		var _bfr = buffer_create(1, buffer_grow, 1);
	
		buffer_write(_bfr, buffer_string, _json);
	
		for(var i = 0; i < buffer_get_size(_bfr); i++)
		{
			buffer_seek(_bfr, buffer_seek_start, i);
			var _read = buffer_read(_bfr, buffer_u8) ^ 69;
			buffer_seek(_bfr, buffer_seek_start, i);
			buffer_write(_bfr, buffer_u8, _read);		
		}
	
		buffer_save(_bfr, $"{game_save_id}/2.bson");
		buffer_delete(_bfr);
	}
	catch(error)
	{
		show_message_async($"Failed to save file (2.bson) (report to dev):\n{error.longMessage}");
	}
}

if(!file_exists($"{game_save_id}/2.bson"))
{
	try
	{
		ds_map_add_map(_buffer, "palettes", ds_map_create());
	
		for(var i = 0; i < 7; i++)
		{
			_buffer[? "petPaletteFrom"][i] = global.petPallettes[i];
			_buffer[? "petPaletteTo"][i] = global.petPallettes[i];
		}
	
		for(var i = 0; i < CHARACTER_SALLY; i++)
		{
			_buffer[? "palettes"][? i + 1] = {
				name: "default",
				custom: false,
				character: i + 1,
			
				from: [ 0, 0, 0, 0 ],
				to: [ 0, 0, 0, 0 ]
			};
		}
	
	
		for(var i = 0; i < CHARACTER_SALLY; i++)
		{
			_buffer[? "palettes"][? i + PALETTE_DEMON + 1] = {
				name: "default",
				custom: false,
				character: i + PALETTE_DEMON + 1,
			
				from: [ 0, 0, 0, 0 ],
				to: [ 0, 0, 0, 0 ]
			};
		}
	
		for(var i = 0; i < EXE_EXELLER+1; i++)
		{
			_buffer[? "palettes"][? i + PALETTE_EXE] = {
				name: "default",
				custom: false,
				character: i + PALETTE_EXE,
			
				from: [ 0, 0, 0, 0 ],
				to: [ 0, 0, 0, 0 ]
			};
		}
	
		var _json = json_encode(_buffer, false);
		var _bfr = buffer_create(1, buffer_grow, 1);
	
		buffer_write(_bfr, buffer_string, _json);
	
		for(var i = 0; i < buffer_get_size(_bfr); i++)
		{
			buffer_seek(_bfr, buffer_seek_start, i);
			var _read = buffer_read(_bfr, buffer_u8) ^ 69;
			buffer_seek(_bfr, buffer_seek_start, i);
			buffer_write(_bfr, buffer_u8, _read);		
		}
	
		buffer_save(_bfr, $"{game_save_id}/2.bson");
		buffer_delete(_bfr);
		
		load($"{game_save_id}/2.bson");
	}
	catch(error)
	{
		show_message_async($"Failed to save file (2.bson) (report to dev):\n{error.longMessage}");
	}
}
else
{
	try
	{
		load($"{game_save_id}/2.bson");
	}
	catch(error)
	{
		show_message(error);
		show_message_async($"Save file (2.bson) appears to be corrupted (due to blackout or game's crash)\nThe game will now load a backup save.");
	
		try
		{
			if(file_exists($"{game_save_id}/2.bson.bak"))
			{
				load($"{game_save_id}/2.bson.bak");
				save();
			}
		}
		catch(error2)
		{
			show_message_async($"Backup file (2.bson.bak) seems to be corrupted too. Loading default configuration then!");
		}
	}
}