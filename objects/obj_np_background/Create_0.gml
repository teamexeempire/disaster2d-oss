lay = layer_get_id("Background");
spd = 0;
side = false;
xx = 0;
yy = 0;
bigrig = false;

particls = [];
particls2 = [];

for(var i = 0; i < 15; i++)
	array_push(particls, { x: irandom_range(0, 24) * 20, y: i * 24 });

for(var i = 0; i < 10; i++)
	array_push(particls2, { x: i * 48, sx: i * 48, y: irandom_range(0, 27) * 10 });


depth = 250;

var fx = layer_get_fx("Background");
fx_set_parameter(fx, "g_TintCol", [1, 1, 1, 1]);

var fx = layer_get_fx("ShadowTiles");
fx_set_parameter(fx, "g_Intensity", 0);

var fx = layer_get_fx("Tiles");
fx_set_parameter(fx, "g_Intensity", 0);

var background = layer_background_get_id(layer_get_id("Colour"));
layer_background_blend(background, make_color_rgb(0, 0, 63));