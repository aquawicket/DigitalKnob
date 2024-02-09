if(ANDROID)
	#dk_findLibrary(OpenGLES ${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-aarch64/sysroot/usr/include)
	
	dk_define(GL_GLEXT_PROTOTYPES)
	ANDROID_dk_lib(GLESv1_CM)
	ANDROID_dk_lib(GLESv2)
endif()

if(IOS)
	dk_findLibrary(OpenGLES)
endif()

if(IOSSIM)
	dk_findLibrary(OpenGLES)
endif()

#if(LINUX)
	#dk_depend(opengl)
#endif()

#if(MAC)
	#dk_depend(opengl)
#endif()

#if(RASPBERRY)
	#dk_depend(opengl)
#endif()	

#if(WIN)
	#dk_depend(opengl)
#endif()


