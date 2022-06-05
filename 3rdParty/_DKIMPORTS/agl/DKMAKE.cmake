# https://developer.apple.com/documentation/agl/agl

if(NOT MAC_HOST)
	return()
endif()

DKDEPEND(carbon)
DKDEPEND(opengl)

FIND_LIBRARY(AGL_Lib AGL)
if(NOT AGL_Lib)
	DKWARN("Could not locate AGL framework")
endif()

DKDEFINE(GL_SILENCE_DEPRECATION)
APPLE_DKLIB(${AGL_Lib})
