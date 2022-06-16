# https://developer.apple.com/documentation/audiotoolbox
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AudioToolbox_lib AudioToolbox)
if(NOT AudioToolbox_lib)
	DKWARN("Could not locate AudioToolbox framework")
endif()
APPLE_DKLIB(${AudioToolbox_lib})
