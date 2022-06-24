# https://developer.apple.com/documentation/AVKit?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AVKit_Lib AVKit)
if(NOT AVKit_Lib)
	dk_error("Could not locate AVKit framework")
endif()
APPLE_dk_lib(${AVKit_Lib})
