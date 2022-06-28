# https://developer.apple.com/documentation/agl/agl
if(NOT MAC_HOST)
	return()
endif()


dk_depend(carbon)
dk_depend(opengl)


FIND_LIBRARY(AGL_Lib AGL)
if(NOT AGL_Lib)
	dk_error("Could not locate AGL framework")
endif()
dk_define(GL_SILENCE_DEPRECATION)
APPLE_dk_lib(${AGL_Lib})
