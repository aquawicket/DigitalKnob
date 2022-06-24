# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreServices_lib CoreServices)
if(NOT CoreServices_lib)
	dk_error("Could not locate CoreServices framework")
endif()
APPLE_dk_lib(${CoreServices_lib})
