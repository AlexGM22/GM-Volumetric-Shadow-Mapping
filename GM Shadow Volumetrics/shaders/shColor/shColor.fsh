//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D uf;

// https://www.shadertoy.com/view/tdjBR1
// You can adjust the fog color here

vec3 colormap(float t) 
{
    return .5 + .1 * cos((3.1416*2.)*( t + vec3(0.1,0.2,0.3) ));
}

void main()
{
	vec4 C = texture2D( gm_BaseTexture, v_vTexcoord );
	float F = texture2D( uf, v_vTexcoord ).r;
	gl_FragColor = vec4(mix(C.rgb, colormap(F) * 0.7 , F) , 1.0);
}
