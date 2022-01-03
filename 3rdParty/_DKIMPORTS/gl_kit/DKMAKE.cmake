if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/GLKit?language=objc

FIND_LIBRARY(GLKit_Lib GLKit)
if(NOT GLKit_Lib)
	DKWARN("Could not locate GLKit framework")
endif()
APPLE_DKLIB(${GLKit_Lib})
