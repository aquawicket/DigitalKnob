if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/coregraphics?language=objc

FIND_LIBRARY(CoreServices_lib CoreServices)
if(NOT CoreServices_lib)
	message(FATAL_ERROR "Could not locate CoreServices framework")
endif()
APPLE_LIB(${CoreServices_lib})
