precision highp float;
precision highp int;

uniform highp float u_Pattern[256];
uniform highp float u_Replacements[256];
uniform highp int u_ColourCount;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

bool areEqual(float c1, float c2)
{
	return (abs(c1 - c2) < 0.01);
}

void main()
{
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);
	
	for(int i = 0; i < u_ColourCount; i++)
	{	
		vec4 cmp = vec4(u_Pattern[i*4], u_Pattern[i*4+1], u_Pattern[i*4+2], u_Pattern[i*4+3]);
		
		if(areEqual(colour.r, cmp.r) && areEqual(colour.g, cmp.g) && areEqual(colour.b, cmp.b) && areEqual(colour.a, cmp.a))
		{
			colour = vec4(u_Replacements[i*4], u_Replacements[i*4+1], u_Replacements[i*4+2], u_Replacements[i*4+3]);
			break;
		}
	}
		
    gl_FragColor = v_vColour * colour;
}
