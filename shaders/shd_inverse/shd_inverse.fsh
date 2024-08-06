varying vec4 v_colour;
varying vec2 v_texcoord;
varying highp vec2 v_point;
varying highp vec2 v_scale;
varying highp float v_radius;

void main()
{
	highp vec2 screen_size = vec2(480., 270.);
	screen_size *= v_scale;
	
	highp vec2 differ = gl_FragCoord.xy - (v_point * v_scale);
	highp float len = length(differ);
	highp vec2 radius = vec2(v_radius * v_scale.x, v_radius * v_scale.y);
	
	vec4 color;	
    if (len < radius.x && len < radius.y) 
	{
		highp vec2 size = vec2(
            max(len - radius.x/2., 0.0) / radius.x,
            max(len - radius.y/2., 0.0) / radius.y
        ) * 10. * v_scale;
        
        highp vec2 pos = vec2(cos(len * 0.2) * size.x, sin(len * 0.2) * size.y) / screen_size;
        vec4 color = v_colour * texture2D(gm_BaseTexture, v_texcoord + pos);
        color.r = 1.0 - color.r;
        color.g = 1.0 - color.g;
        color.b = 1.0 - color.b;
		gl_FragColor = color;
    }
	else
		gl_FragColor = v_colour * texture2D(gm_BaseTexture, v_texcoord);
		
}
