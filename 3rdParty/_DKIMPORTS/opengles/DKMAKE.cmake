if(WIN)
	DKDEPEND(opengl)
endif()

if(MAC)
	DKDEPEND(opengl)
endif()

if(IOS)
	FIND_LIBRARY(opengles_lib OpenGLES)
	APPLE_LIB(${opengles_lib})
endif()

if(IOSSIM)
	FIND_LIBRARY(opengles_lib OpenGLES)
	APPLE_LIB(${opengles_lib})
endif()

if(LINUX)
	DKDEPEND(opengl)
endif()

if(RASPBERRY)
	DKDEPEND(opengl)
endif()	

if(ANDROID)
	DKDEFINE(GL_GLEXT_PROTOTYPES)
	ANDROID_LIB(GLESv1_CM)
	ANDROID_LIB(GLESv2)
endif()
