if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/GLKit?language=objc

FIND_LIBRARY(GLKit_Lib GLKit)
if(NOT GLKit_Lib)
	message(FATAL_ERROR "Could not locate GLKit framework")
endif()
APPLE_LIB(${GLKit_Lib})
