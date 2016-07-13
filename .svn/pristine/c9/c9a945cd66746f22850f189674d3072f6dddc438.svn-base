#ifdef LINUX
	#version 100
#endif
			
uniform vec2 LibRocketPosition;
varying vec2 texCoord;
varying vec4 out_color;

void main(){
	texCoord = vec2(gl_MultiTexCoord0);
	vec4 pos = gl_Vertex + vec4(LibRocketPosition, 0, 0);
	gl_Position = gl_ModelViewProjectionMatrix * pos;
	out_color = gl_Color;
}