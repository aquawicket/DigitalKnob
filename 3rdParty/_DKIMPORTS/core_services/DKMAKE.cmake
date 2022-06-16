# https://developer.apple.com/documentation/coregraphics?language=objc
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreServices_lib CoreServices)
if(NOT CoreServices_lib)
	DKWARN("Could not locate CoreServices framework")
endif()
APPLE_DKLIB(${CoreServices_lib})
