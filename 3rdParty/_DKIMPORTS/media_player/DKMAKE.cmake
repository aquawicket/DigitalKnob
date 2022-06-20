if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/MediaPlayer?language=objc

FIND_LIBRARY(MediaPlayer_lib MediaPlayer)
if(NOT MediaPlayer_lib)
	dk_warn("Could not locate MediaPlayer framework")
endif()
APPLE_dk_lib(${MediaPlayer_lib})
