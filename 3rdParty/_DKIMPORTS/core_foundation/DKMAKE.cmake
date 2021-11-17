if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/corefoundation

FIND_LIBRARY(CoreFoundation_lib CoreFoundation)
if(NOT CoreFoundation_lib)
	message(FATAL_ERROR "Could not locate CoreFoundation framework")
endif()
APPLE_LIB(${CoreFoundation_lib})
