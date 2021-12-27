if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/audiounit

FIND_LIBRARY(AudioUnit_lib AudioUnit)
if(NOT AudioUnit_lib)
	APPLE_LIB(${AudioUnit_lib})
else()
	message(WARNING "Could not locate AudioUnit framework")
endif()

