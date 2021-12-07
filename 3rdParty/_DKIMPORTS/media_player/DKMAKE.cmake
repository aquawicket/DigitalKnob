if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/MediaPlayer?language=objc

FIND_LIBRARY(MediaPlayer_lib MediaPlayer)
if(NOT MediaPlayer_lib)
	message(FATAL_ERROR "Could not locate MediaPlayer framework")
endif()
APPLE_LIB(${MediaPlayer_lib})
