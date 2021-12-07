if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/quartzcore?language=objc

FIND_LIBRARY(CoreAnimation_lib CoreAnimation)
if(NOT CoreAnimation_lib)
	message(FATAL_ERROR "Could not locate CoreAnimation framework")
endif()
APPLE_LIB(${CoreAnimation_lib})
