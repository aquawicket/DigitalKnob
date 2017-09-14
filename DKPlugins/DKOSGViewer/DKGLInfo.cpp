#include "DK/stdafx.h"
#include "DKGLInfo.h"

#include <osg/FragmentProgram>
#include <osg/GraphicsContext>
#include <osg/GL>
#include <osg/GLExtensions>
#include <osg/GL2Extensions>
#include <osg/Texture>
#include <osgViewer/Version>
#include <OpenThreads/Thread>

/////////////////////
void DKGLInfo::Init()
{
	osgViewerGetVersion();

	// check the environment in order to disable ATI workarounds
	bool enableATIworkarounds = true;

	// logical CPUs (cores)
	_numProcessors = OpenThreads::GetNumberOfProcessors();

	// GLES compile?
#if (defined(OSG_GLES1_AVAILABLE) || defined(OSG_GLES2_AVAILABLE))
	_isGLES = true;
#else
	_isGLES = false;
#endif

	osg::GraphicsContext::ScreenIdentifier si;
	si.readDISPLAY();
	si.setUndefinedScreenDetailsToDefaultScreen();

	osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
	traits->hostName = si.hostName;
	traits->displayNum = si.displayNum;
	traits->screenNum = si.screenNum;
	traits->x = 0;
	traits->y = 0;
	traits->width = 1;
	traits->height = 1;
	traits->windowDecoration = false;
	traits->doubleBuffer = false;
	traits->sharedContext = 0;
	traits->pbuffer = false;

	// Intel graphics adapters dont' support pbuffers, and some of their drivers crash when
	// you try to create them. So by default we will only use the unmapped/pbuffer method
	// upon special request.
	if (getenv("DK_USE_PBUFFER_TEST")){
		traits->pbuffer = true;
		DKLog("Activating pbuffer test for graphics capabilities. \n", DKINFO);
		_gc = osg::GraphicsContext::createGraphicsContext(traits.get());
		if (!_gc.valid()){
			DKLog("Failed to create pbuffer \n", DKERROR);
		}
	}

	if (!_gc.valid()){
		// fall back on a mapped window
		traits->pbuffer = false;
		_gc = osg::GraphicsContext::createGraphicsContext(traits.get());
	}

	if (_gc.valid()){
		_gc->realize();
		_gc->makeCurrent();

		if (traits->pbuffer == false)
		{
			DKLog("Realized graphics window for OpenGL operations. \n", DKINFO);
		}
		else
		{
			DKLog("Realized pbuffer for OpenGL operations. \n", DKINFO);
		}
	}
	else{
		DKLog("Failed to create graphic window too. \n", DKERROR);
	}


	////////////////////////////////////////////////
	if (!_gc.valid() || !_gc->isRealized()){
		DKLog("DKGLInfo: context invalid. \n", DKERROR);
		return;
	}

	osg::GraphicsContext* gc = _gc.get();
	unsigned int id = gc->getState()->getContextID();
	const osg::GL2Extensions* GL2 = osg::GL2Extensions::Get(id, true);

	if (::getenv("DK_NO_GLSL")){
		_supportsGLSL = false;
		DKLog("Note: GLSL expressly disabled (DK_NO_GLSL)\n", DKINFO);
	}
	else{
			/*
#if OSG_MIN_VERSION_REQUIRED(3,3,3)
			_supportsGLSL = GL2->isGlslSupported;
#else
			_supportsGLSL = GL2->isGlslSupported();
#endif
			*/
	}

	DKLog("Detected hardware capabilities: \n", DKINFO);

	_vendor = std::string(reinterpret_cast<const char*>(glGetString(GL_VENDOR)));
	DKLog("  Vendor = " + _vendor +"\n", DKINFO);

	_renderer = std::string(reinterpret_cast<const char*>(glGetString(GL_RENDERER)));
	DKLog("  Renderer = " + _renderer + "\n", DKINFO);

	_version = std::string(reinterpret_cast<const char*>(glGetString(GL_VERSION)));
	DKLog("  Version = " + _version + "\n", DKINFO);

	glGetIntegerv(GL_MAX_TEXTURE_UNITS, &_maxFFPTextureUnits);
	//DKLog("  Max FFP texture units = " + _maxFFPTextureUnits + "\n");

	glGetIntegerv(GL_MAX_TEXTURE_IMAGE_UNITS_ARB, &_maxGPUTextureUnits);
	//DKLog("  Max GPU texture units = " + _maxGPUTextureUnits + "\n");

	glGetIntegerv(GL_MAX_TEXTURE_COORDS_ARB, &_maxGPUTextureCoordSets);
	//DKLog("  Max GPU texture coord indices = " + _maxGPUTextureCoordSets + "\n");

	glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, &_maxGPUAttribs);
	//DKLog("  Max GPU attributes = " + _maxGPUAttribs + "\n");

	glGetIntegerv(GL_DEPTH_BITS, &_depthBits);
	//DKLog("  Depth buffer bits = " + _depthBits + "\n");

	glGetIntegerv(GL_MAX_TEXTURE_SIZE, &_maxTextureSize);
#if !(defined(OSG_GLES1_AVAILABLE) || defined(OSG_GLES2_AVAILABLE))
		// Use the texture-proxy method to determine the maximum texture size 
	for (int s = _maxTextureSize; s > 2; s >>= 1){
		glTexImage2D(GL_PROXY_TEXTURE_2D, 0, GL_RGBA8, s, s, 0, GL_RGBA, GL_UNSIGNED_BYTE, 0L);
		GLint width = 0;
		glGetTexLevelParameteriv(GL_PROXY_TEXTURE_2D, 0, GL_TEXTURE_WIDTH, &width);
		if (width == s){
			_maxTextureSize = s;
			break;
		}
	}
#endif
	//DKLog("  Max texture size = " + _maxTextureSize + "\n");

#ifdef OSG_GL_FIXED_FUNCTION_AVAILABLE
		glGetIntegerv(GL_MAX_LIGHTS, &_maxLights);
#else
		_maxLights = 1;
#endif
	//DKLog("  Max lights = " + _maxLights + "\n");

	DKLog("  GLSL = " + toString(_supportsGLSL) + "\n", DKINFO);

	if (_supportsGLSL){
	/*
#if OSG_MIN_VERSION_REQUIRED(3,3,3)
		_GLSLversion = GL2->glslLanguageVersion;
#else
		_GLSLversion = GL2->getLanguageVersion();
#endif
	DKLog("  GLSL Version = " + getGLSLVersionInt());
	*/
	}

	_supportsTextureArrays =
	_supportsGLSL &&
	osg::getGLVersionNumber() >= 2.0f && // hopefully this will detect Intel cards
	osg::isGLExtensionSupported(id, "GL_EXT_texture_array");
	DKLog("  Texture arrays = " + toString(_supportsTextureArrays) + "\n", DKINFO);

	_supportsTexture3D = osg::isGLExtensionSupported(id, "GL_EXT_texture3D");
	DKLog("  3D textures = " + toString(_supportsTexture3D) + "\n", DKINFO);

	_supportsMultiTexture =
	osg::getGLVersionNumber() >= 1.3f ||
	osg::isGLExtensionSupported(id, "GL_ARB_multitexture") ||
	osg::isGLExtensionSupported(id, "GL_EXT_multitexture");
	DKLog("  Multitexturing = " + toString(_supportsMultiTexture) + "\n", DKINFO);

	_supportsStencilWrap = osg::isGLExtensionSupported(id, "GL_EXT_stencil_wrap");
	//DKLog("  Stencil wrapping = " + toString(_supportsStencilWrap)+"\n");

	_supportsTwoSidedStencil = osg::isGLExtensionSupported(id, "GL_EXT_stencil_two_side");
	//DKLog("  2-sided stencils = " + toString(_supportsTwoSidedStencil)+"\n");

	_supportsDepthPackedStencilBuffer = osg::isGLExtensionSupported(id, "GL_EXT_packed_depth_stencil") ||
	osg::isGLExtensionSupported(id, "GL_OES_packed_depth_stencil");
	//DKLog("  depth-packed stencil = " + toString(_supportsDepthPackedStencilBuffer)+"\n");

	_supportsOcclusionQuery = osg::isGLExtensionSupported(id, "GL_ARB_occlusion_query");
	//DKLog("  occlusion query = " + toString(_supportsOcclusionQuery)+"\n");

	_supportsDrawInstanced =
	_supportsGLSL &&
	osg::isGLExtensionOrVersionSupported(id, "GL_EXT_draw_instanced", 3.1f);
	DKLog("  draw instanced = " + toString(_supportsDrawInstanced) + "\n", DKINFO);

	glGetIntegerv(GL_MAX_UNIFORM_BLOCK_SIZE, &_maxUniformBlockSize);
	//DKLog("  max uniform block size = " + _maxUniformBlockSize+"\n");

	_supportsUniformBufferObjects =
	_supportsGLSL &&
	osg::isGLExtensionOrVersionSupported(id, "GL_ARB_uniform_buffer_object", 2.0f);
	DKLog("  uniform buffer objects = " + toString(_supportsUniformBufferObjects) + "\n", DKINFO);

	if (_supportsUniformBufferObjects && _maxUniformBlockSize == 0){
		DKLog("  ...but disabled, since UBO block size reports zero \n", DKINFO);
		_supportsUniformBufferObjects = false;
	}

	_supportsNonPowerOfTwoTextures =
	osg::isGLExtensionSupported(id, "GL_ARB_texture_non_power_of_two");
	DKLog("  NPOT textures = " + toString(_supportsNonPowerOfTwoTextures) + "\n", DKINFO);

	_supportsTextureBuffer =
	osg::isGLExtensionOrVersionSupported(id, "GL_ARB_texture_buffer_object", 3.0) ||
	osg::isGLExtensionOrVersionSupported(id, "GL_EXT_texture_buffer_object", 3.0);

	if (_supportsTextureBuffer){
		glGetIntegerv(GL_MAX_TEXTURE_BUFFER_SIZE, &_maxTextureBufferSize);
	}

	DKLog("  Texture buffers = " + toString(_supportsTextureBuffer) + "\n", DKINFO);
	if (_supportsTextureBuffer){
		//DKLog("  Texture buffer max size = " + _maxTextureBufferSize + "\n");
	}

	bool supportsTransformFeedback =
	osg::isGLExtensionSupported(id, "GL_ARB_transform_feedback2");
	DKLog("  Transform feedback = " + toString(supportsTransformFeedback) + "\n", DKINFO);

	// Writing to gl_FragDepth is not supported under GLES:
#if (defined(OSG_GLES1_AVAILABLE) || defined(OSG_GLES2_AVAILABLE))
	_supportsFragDepthWrite = false;
#else
	_supportsFragDepthWrite = true;
#endif

	//_supportsTexture2DLod = osg::isGLExtensionSupported( id, "GL_ARB_shader_texture_lod" );
	//DKLog("  texture2DLod = " + toString(_supportsTexture2DLod) + "\n";

	// NVIDIA:
	bool isNVIDIA = _vendor.find("NVIDIA") == 0;

	// NVIDIA has h/w acceleration of some kind for display lists, supposedly.
	// In any case they do benchmark much faster in osgEarth for static geom.
	// BUT unfortunately, they dont' seem to work too well with shaders. Colors
	// change randomly, etc. Might work OK for textured geometry but not for 
	// untextured. TODO: investigate.
#if 1
	_preferDLforStaticGeom = false;
	if (::getenv("DK_TRY_DISPLAY_LISTS")){
		_preferDLforStaticGeom = true;
	}
#else
	if (::getenv("DK_ALWAYS_USE_VBOS")){
		_preferDLforStaticGeom = false;
	}
	else{
		_preferDLforStaticGeom = isNVIDIA;
	}
#endif

	DKLog("  prefer DL for static geom = " + toString(_preferDLforStaticGeom) + "\n", DKINFO);

	// ATI workarounds:
	bool isATI = _vendor.find("ATI ") == 0;

	_supportsMipmappedTextureUpdates = isATI && enableATIworkarounds ? false : true;
	DKLog("  Mipmapped texture updates = " + toString(_supportsMipmappedTextureUpdates) + "\n", DKINFO);

#if 0
	// Intel workarounds:
	bool isIntel =
	_vendor.find("Intel ") != std::string::npos ||
	_vendor.find("Intel(R)") != std::string::npos ||
	_vendor.compare("Intel") == 0;
#endif

	_maxFastTextureSize = _maxTextureSize;

	//DKLog("  Max Fast Texture Size = " + _maxFastTextureSize + "\n";

	/*
	// tetxure compression
	DKLog("  Compression = ");
	_supportsARBTC = osg::isGLExtensionSupported(id, "GL_ARB_texture_compression");
	if (_supportsARBTC) DK_INFO_CONTINUE << "ARB ";

	_supportsS3TC = osg::isGLExtensionSupported(id, "GL_EXT_texture_compression_s3tc");
	if (_supportsS3TC) DK_INFO_CONTINUE << "S3 ";

	_supportsPVRTC = osg::isGLExtensionSupported(id, "GL_IMG_texture_compression_pvrtc");
	if (_supportsPVRTC) DK_INFO_CONTINUE << "PVR ";

	_supportsETC = osg::isGLExtensionSupported(id, "GL_OES_compressed_ETC1_RGB8_texture");
	if (_supportsETC) DK_INFO_CONTINUE << "ETC1 ";

	_supportsRGTC = osg::isGLExtensionSupported(id, "GL_EXT_texture_compression_rgtc");
	if (_supportsRGTC) DK_INFO_CONTINUE << "RG";

	OE_INFO_CONTINUE << std::endl;
	*/

	//CLOSE the graphics context
	_gc->close();
	_gc = NULL;
}