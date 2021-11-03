# https://developer.apple.com/documentation/audiounit

FIND_LIBRARY(audiounit_lib AudioUnit)
if(NOT ${audiounit_lib})
	message(FATAL_ERROR "Could not locate AudioUnit framework")
endif()
APPLE_LIB(${audiounit_lib})
