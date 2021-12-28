if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/MediaPlayer?language=objc

FIND_LIBRARY(MediaPlayer_lib MediaPlayer)
if(NOT MediaPlayer_lib)
	message(WARNING "Could not locate MediaPlayer framework")
endif()
APPLE_DKLIB(${MediaPlayer_lib})
