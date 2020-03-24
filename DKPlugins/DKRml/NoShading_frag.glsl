// FRAGMENT SHADER

// notes:
// to maintain compatibility, the version
// preprocessor call needs to be added to the
// beginning of this file by the (cpu) compiler:
//
// "#version 100" for OpenGL ES 2 and
// "#version 120" (or higher) for desktop OpenGL

#ifdef GL_ES
    // the fragment shader in ES 2 doesn't have a
    // default precision qualifier for floats so
    // it needs to be explicitly specified
    precision mediump float;

    // note: highp may not be available for float types in
    // the fragment shader -- use the following to set it:
    // #ifdef GL_FRAGMENT_PRECISION_HIGH
    // precision highp float;
    // #else
    // precision mediump float;
    // #endif

    // fragment shader defaults for other types are:
    // precision mediump int;
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

varying vec4 VertexColor;
varying vec2 TexCoord0;

// set to zero by default
uniform sampler2D GlyphTexture;

void main()
{
    gl_FragColor = VertexColor * texture2D(GlyphTexture,TexCoord0).aaaa;
}
