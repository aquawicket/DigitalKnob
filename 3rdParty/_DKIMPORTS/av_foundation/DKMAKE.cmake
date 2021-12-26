if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/AVFoundation?language=objc

FIND_LIBRARY(avFoundtaion_Lib AVFoundation)
if(NOT avFoundtaion_Lib)
	message(FATAL_ERROR "Could not locate AVFoundation framework")
endif()
APPLE_LIB(${avFoundtaion_Lib})
