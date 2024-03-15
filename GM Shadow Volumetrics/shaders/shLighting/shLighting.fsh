
varying vec2 vCoordinates;
varying vec3 vWN;
varying vec4 vWP;

//varying float vL;

uniform vec3 uP;
uniform vec3 uS;

uniform mat4 uLPM;
uniform mat4 uLVM;

uniform sampler2D uDT;
uniform sampler2D uB;

#define AMB .3
float CtD(vec3 C) {return dot(C, vec3(1.,256.,65536.)/16777215.*255.);}
vec3 SH(vec4 W) {vec4 C = uLVM * W, S = uLPM * C; vec2 Q = (S.xy / S.w) * 0.5 + 0.5; return vec3(Q, S.z/S.w );}

// This is a mess, but you're free to use it!
// Shader: CC BY 4.0

void main()
{
	vec4 Tex = texture2D( gm_BaseTexture, vCoordinates);
	vec3 S = SH(vWP), W = vWP.xyz, N = vWN, LP = normalize(uS);
	
	float I, F, B = texture2D(uB,gl_FragCoord.xy/8.).r,
	DP = CtD(texture2D(uDT, S.xy).xyz),
	NDL = max(AMB, dot(N, LP));
	float SHD = (S.z > DP + 8e-4)? AMB : 1.0, i = 14.;
	for(;I++ < i;)
	{
		vec3 s = SH(vec4(W+(uP-W)*((I+B)/i),1));
		float D = CtD(texture2D(uDT, s.xy).xyz);
		F += (s.z < D)? (clamp(D,-1.,1.)) : 0.0;
	}
	gl_FragData[0] = vec4(Tex.rgb * NDL * SHD, 1.0);
	gl_FragData[1] = vec4(F,0,0,1);
}