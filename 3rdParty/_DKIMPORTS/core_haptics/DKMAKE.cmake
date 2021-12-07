if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/corehaptics?language=objc

FIND_LIBRARY(CoreHaptics_lib CoreHaptics)
if(NOT CoreHaptics_lib)
	message(FATAL_ERROR "Could not locate CoreHaptics framework")
endif()
APPLE_LIB(${CoreHaptics_lib})
