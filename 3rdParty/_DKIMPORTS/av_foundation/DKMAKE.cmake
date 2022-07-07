# https://developer.apple.com/documentation/AVFoundation?language=objc

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(AVFoundation)
