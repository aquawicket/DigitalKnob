# https://developer.apple.com/documentation/MediaPlayer?language=objc

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(MediaPlayer)
