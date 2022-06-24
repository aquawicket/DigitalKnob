# https://developer.apple.com/documentation/GLKit?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(GLKit_Lib GLKit)
if(NOT GLKit_Lib)
	dk_error("Could not locate GLKit framework")
endif()
APPLE_dk_lib(${GLKit_Lib})
