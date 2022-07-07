# https://developer.apple.com/documentation/agl/agl
if(NOT MAC_HOST)
	return()
endif()

dk_depend(carbon)
dk_depend(opengl)

dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
