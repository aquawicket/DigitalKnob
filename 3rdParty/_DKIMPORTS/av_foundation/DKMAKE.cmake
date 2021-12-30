if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/AVFoundation?language=objc

FIND_LIBRARY(avFoundtaion_Lib AVFoundation)
if(NOT avFoundtaion_Lib)
	DKWARN("Could not locate AVFoundation framework")
endif()
APPLE_DKLIB(${avFoundtaion_Lib})
