# https://developer.apple.com/documentation/audiounit
if(NOT MAC_HOST)
	return()
endif()

FIND_LIBRARY(AudioUnit_lib AudioUnit)
if(NOT AudioUnit_lib)
	APPLE_dk_lib(${AudioUnit_lib})
else()
	DKWARN("Could not locate AudioUnit framework")
endif()

