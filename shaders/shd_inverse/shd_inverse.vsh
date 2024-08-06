attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform highp vec2 u_point;
uniform highp vec2 u_scale;
uniform highp float u_radius;

varying vec4 v_colour;
varying vec2 v_texcoord;
varying highp vec2 v_point;
varying highp vec2 v_scale;
varying highp float v_radius;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position.xyz, 1.0);
	
	v_texcoord = in_TextureCoord;
	v_colour = in_Colour;
	v_radius = u_radius;
	v_point = u_point;
	v_scale = u_scale;
}
