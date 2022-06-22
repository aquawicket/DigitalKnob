# https://developer.apple.com/documentation/MediaPlayer?language=objc

if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(MediaPlayer_lib MediaPlayer)
if(NOT MediaPlayer_lib)
	dk_error("Could not locate MediaPlayer framework")
endif()
APPLE_dk_lib(${MediaPlayer_lib})
