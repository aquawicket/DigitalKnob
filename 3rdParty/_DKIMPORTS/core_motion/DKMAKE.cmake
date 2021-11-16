if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/coremotion?language=objc

FIND_LIBRARY(coremotion_lib CoreMotion)
if(NOT coremotion_lib)
	message(FATAL_ERROR "Could not locate CoreMotion framework")
endif()
APPLE_LIB(${coremotion_lib})
