if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/GLKit?language=objc

FIND_LIBRARY(GLKit_Lib GLKit)
if(NOT GLKit_Lib)
	dk_warn("Could not locate GLKit framework")
endif()
APPLE_dk_lib(${GLKit_Lib})
