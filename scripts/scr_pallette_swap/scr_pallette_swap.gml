function scr_palette_swap(palleteIn, palleteOut)
{
	shader_set(shd_colour);
	
	var arr = shader_get_uniform(shd_colour, "u_Pattern");
	shader_set_uniform_f_array(arr, palleteIn);
	
	var arr2 = shader_get_uniform(shd_colour, "u_Replacements");
	shader_set_uniform_f_array(arr2, palleteOut);
	
	var cnt = shader_get_uniform(shd_colour, "u_ColourCount");
	shader_set_uniform_i(cnt, array_length(palleteIn) / 4);
}