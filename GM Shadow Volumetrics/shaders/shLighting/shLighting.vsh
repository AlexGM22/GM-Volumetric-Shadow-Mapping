// Simple passthrough vertex shader

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 vCoordinates;
varying vec4 vWP;
varying vec3 vWN;

//varying float vL;

//uniform mat4 uLPM;
//uniform mat4 uLVM;

void main()
{
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position,1);
	
	vWP = gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1);
	vWN = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 1))).xyz;
	
	//vec4 CAM = uLVM * vWP;
	//vec4 SCR = uLPM * CAM;
	
	//vL = SCR.z / SCR.w;
	
	vCoordinates = in_TextureCoord;
}
