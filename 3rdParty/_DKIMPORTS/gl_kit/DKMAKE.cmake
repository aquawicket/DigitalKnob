# https://developer.apple.com/documentation/GLKit?language=objc

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(GLKit)
