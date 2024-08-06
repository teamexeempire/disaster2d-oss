 if(!instance_exists(obj_camera))
	return;

if(instance_exists(obj_bigring) && !bigrig)
{
	bigrig = true;
	
	var fx = layer_get_fx("Background");
	fx_set_parameter(fx, "g_TintCol", [1, 0, 0, 1]);
	
	var fx = layer_get_fx("ShadowTiles");
	fx_set_parameter(fx, "g_Intensity", 1);
	
	var fx = layer_get_fx("Tiles");
	fx_set_parameter(fx, "g_Intensity", 1);
	
	var background = layer_background_get_id(layer_get_id("Colour"));
	layer_background_blend(background, c_black);
	
	instance_create_depth(0, 0, -1002, obj_np_white);
}

xx = obj_camera.x;
yy = obj_camera.y;

if(image_index >= 107)
	side = true;

if(image_index >= 217)
	side = false;
	
spd += side ? -0.5 : 0.5;

layer_x(lay, xx + spd);
layer_y(lay, yy);