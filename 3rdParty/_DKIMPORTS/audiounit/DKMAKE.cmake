# https://developer.apple.com/documentation/audiounit

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AudioUnit_lib AudioUnit)
if(NOT AudioUnit_lib)
	dk_error("Could not locate AudioUnit framework")
endif()
APPLE_dk_lib(${AudioUnit_lib})
