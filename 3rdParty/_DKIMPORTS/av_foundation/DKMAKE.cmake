# https://developer.apple.com/documentation/AVFoundation?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(avFoundtaion_Lib AVFoundation)
if(NOT avFoundtaion_Lib)
	dk_error("Could not locate AVFoundation framework")
endif()
APPLE_dk_lib(${avFoundtaion_Lib})
