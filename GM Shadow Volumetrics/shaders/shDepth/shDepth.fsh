
varying vec2 vCoord;
varying float vDepth;

vec3 DtC(float D) {float I = D * 16777215.; return floor(vec3(mod(I, 256.), mod(I / 256., 256.), I / 65536.)) / 255.;}
void main()
{
	gl_FragColor = vec4( DtC(vDepth), 1);
}
