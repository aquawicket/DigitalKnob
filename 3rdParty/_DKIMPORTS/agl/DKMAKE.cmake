# https://developer.apple.com/documentation/agl/agl
if(NOT MAC_HOST)
	return()
endif()

dk_depend(carbon)
dk_depend(opengl)

#find_library(AGL_LIBRARY AGL)
#if(NOT AGL_LIBRARY)
#	dk_assert("Could not locate AGL framework")
#endif()
#dk_info(AGL_LIBRARY)
#dk_lib(${AGL_LIBRARY})
dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
