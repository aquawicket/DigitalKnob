if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/agl/agl


DKDEPEND(carbon)
DKDEPEND(opengl)

FIND_LIBRARY(AGL_Lib AGL)
if(NOT AGL_Lib)
	message(WARNING "Could not locate AGL framework")
endif()

DKDEFINE(GL_SILENCE_DEPRECATION)
APPLE_LIB(${AGL_Lib})
