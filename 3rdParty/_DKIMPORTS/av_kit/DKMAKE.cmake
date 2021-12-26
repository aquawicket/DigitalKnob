if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/AVKit?language=objc

FIND_LIBRARY(AVKit_Lib AVKit)
if(NOT AVKit_Lib)
	message(FATAL_ERROR "Could not locate AVKit framework")
endif()
APPLE_LIB(${AVKit_Lib})
