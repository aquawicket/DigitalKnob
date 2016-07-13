#ifdef LINUX
	#version 100
#endif

uniform sampler2D myTexture;
uniform bool is_texture;

#if defined(MAC) || defined(WIN32)
varying vec2 texCoord;
varying vec4 out_color;
#else
varying lowp vec2 texCoord;
varying lowp vec4 out_color;
#endif

void main(){

	if(is_texture){
		gl_FragColor = out_color * texture2D(myTexture, texCoord);
	}
	else{
		gl_FragColor = out_color;
	}
}