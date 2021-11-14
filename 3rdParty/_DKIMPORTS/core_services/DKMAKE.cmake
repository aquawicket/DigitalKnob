if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/coregraphics?language=objc

FIND_LIBRARY(core_services_lib CoreServices)
if(NOT core_services_lib)
	message(FATAL_ERROR "Could not locate CoreServices framework")
endif()
APPLE_LIB(${core_services_lib})
