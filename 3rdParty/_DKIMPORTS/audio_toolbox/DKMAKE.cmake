if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/audiotoolbox

FIND_LIBRARY(AudioToolbox_lib AudioToolbox)
if(NOT AudioToolbox_lib)
	message(WARNING "Could not locate AudioToolbox framework")
endif()
APPLE_LIB(${AudioToolbox_lib})
