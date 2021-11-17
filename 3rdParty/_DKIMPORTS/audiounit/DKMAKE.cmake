if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/audiounit

FIND_LIBRARY(AudioUnit_lib AudioUnit)
if(NOT AudioUnit_lib)
	message(FATAL_ERROR "Could not locate AudioUnit framework")
endif()
APPLE_LIB(${AudioUnit_lib})
