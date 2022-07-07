# https://developer.apple.com/documentation/avfaudio?language=objc

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(AVFAudio)
