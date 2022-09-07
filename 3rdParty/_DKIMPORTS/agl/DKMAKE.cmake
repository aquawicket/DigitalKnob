# https://developer.apple.com/documentation/agl/agl
if(NOT MAC)
	dk_undepend(agl)
	return()
endif()

dk_depend(carbon)
dk_depend(opengl)

dk_findLibrary(AGL)
dk_define(GL_SILENCE_DEPRECATION)
