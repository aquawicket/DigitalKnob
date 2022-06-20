# https://developer.apple.com/documentation/audiotoolbox
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AudioToolbox_lib AudioToolbox)
if(NOT AudioToolbox_lib)
	dk_warn("Could not locate AudioToolbox framework")
endif()
APPLE_dk_lib(${AudioToolbox_lib})
