function scr_prefetch_group(name)
{
	var _tex_array = texturegroup_get_textures(name);
	for (var i = 0; i < array_length(_tex_array); ++i;)
	{
	    texture_prefetch(_tex_array[i]);
	}
}