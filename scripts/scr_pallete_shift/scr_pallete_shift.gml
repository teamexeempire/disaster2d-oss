function rgb_to_hsv(r, g, b)
{
    var max_val = max(r, g, b);
    var min_val = min(r, g, b);
    var delta = max_val - min_val;
    
    var hue = 0;
    var saturation = 0;
    var value = max_val;
    
    if (delta != 0)
    {
        saturation = delta / max_val;
        var delta_r = (((max_val - r) / 6) + (delta / 2)) / delta;
        var delta_g = (((max_val - g) / 6) + (delta / 2)) / delta;
        var delta_b = (((max_val - b) / 6) + (delta / 2)) / delta;
        
        if (r == max_val) hue = delta_b - delta_g;
        else if (g == max_val) hue = (1 / 3) + delta_r - delta_b;
        else if (b == max_val) hue = (2 / 3) + delta_g - delta_r;
        
        if (hue < 0) hue += 1;
        if (hue > 1) hue -= 1;
    }
    
    return [hue, saturation, value];
}

function hsv_to_rgb(hue, saturation, value)
{
    var h = (hue % 256) / 255; // Wrap hue around (0-255) to (0-1)
    var s = clamp(saturation / 255, 0, 1);
    var v = clamp(value / 255, 0, 1);

    var c = v * s;
    var b = c * (1 - abs((h * 6) mod 2 - 1));
    var m = v - c;
    
    var rgb;
    
    if (h < 1/6) rgb = [c, b, 0];
    else if (h < 2/6) rgb = [b, c, 0];
    else if (h < 3/6) rgb = [0, c, b];
    else if (h < 4/6) rgb = [0, b, c];
    else if (h < 5/6) rgb = [b, 0, c];
    else rgb = [c, 0, b];
    
    var r = round((rgb[0] + m) * 255);
    var g = round((rgb[1] + m) * 255);
    var b = round((rgb[2] + m) * 255);

    return [r, g, b];
}

function scr_pallete_shift(colours, h, s, v)
{
	var newArray = [];
	
	for(var i = 0; i < array_length(colours); i += 4)
	{
		var r = colours[i];
		var g = colours[i + 1];
		var b = colours[i + 2];
		var a = colours[i + 3];
		
		var hsv = rgb_to_hsv(r, g, b);
		var colour = hsv_to_rgb((hsv[0] * 255.0 + h), (hsv[1] * 255.0 + s), (hsv[2] * 255.0 + v));
		
		array_push(newArray, colour[0] / 255.0);
		array_push(newArray, colour[1] / 255.0);
		array_push(newArray, colour[2] / 255.0);
		array_push(newArray, a);
	}
	
	return newArray;
}