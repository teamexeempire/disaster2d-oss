function scr_draw_bilboard(sprite, subimage, xx, yy, zz, xscale, yscale, alpha)
{
	shader_set(shd_bilboard);
	matrix_set(matrix_world, matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1));
	draw_sprite_ext(sprite, subimage, 0, 0, xscale, yscale, 0, c_white, alpha);
	matrix_set(matrix_world, matrix_build_identity());
	shader_reset();
}