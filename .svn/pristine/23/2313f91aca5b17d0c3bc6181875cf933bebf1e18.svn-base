// VERTEX SHADER

// notes:
// to maintain compatibility, the version
// preprocessor call needs to be added to the
// beginning of this file by the (cpu) compiler:
//
// "#version 100" for OpenGL ES 2 and
// "#version 120" (or higher) for desktop OpenGL

#ifdef GL_ES
    // vertex shader defaults for types are:
    // precision highp float;
    // precision highp int;
    // precision lowp sampler2D;
    // precision lowp samplerCube;
#else
    // with default (non ES) OpenGL shaders, precision
    // qualifiers aren't used -- we explicitly set them
    // to be defined as 'nothing' so they are ignored
    #define lowp
    #define mediump
    #define highp
#endif


varying mediump vec4 VertexColor;
varying mediump vec2 TexCoord0;

// material color
uniform vec4 MaterialColor;

void main()
{
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    VertexColor = MaterialColor;
    TexCoord0 = gl_MultiTexCoord0.xy;
}
