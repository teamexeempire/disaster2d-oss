function scr_level_split(tileSpr, _depth, _visible=true, yOffset=0)
{	
	for(var frm = 0; frm < sprite_get_number(tileSpr); frm++)
	{
		for(var i = 0; i < sprite_get_width(tileSpr) / 1024; i++)
		{
			for(var j = 0; j < sprite_get_height(tileSpr) / 1024; j++)
			{			
				var inst = instance_create_depth(i * 1024 + frm * sprite_get_width(tileSpr), j * 1024 + yOffset, _depth, obj_tile);
				inst.spr = tileSpr;
				inst.ind = frm;
				inst.visible = _visible;
				inst.isVis = _visible;
				inst.xx = i * 1024;
				inst.yy = j * 1024;
			}
		}
	}
}

function scr_level_splitl(tileSpr, _layer, _visible=true, yOffset=0)
{		
	for(var frm = 0; frm < sprite_get_number(tileSpr); frm++)
	{
		for(var i = 0; i < sprite_get_width(tileSpr) / 1024; i++)
		{
			for(var j = 0; j < sprite_get_height(tileSpr) / 1024; j++)
			{			
				var inst = instance_create_layer(i * 1024 + frm * sprite_get_width(tileSpr), j * 1024 + yOffset, _layer, obj_tile);
				inst.spr = tileSpr;
				inst.ind = frm;
				inst.visible = _visible;
				inst.isVis = _visible;
				inst.xx = i * 1024;
				inst.yy = j * 1024;
			}
		}
	}
}