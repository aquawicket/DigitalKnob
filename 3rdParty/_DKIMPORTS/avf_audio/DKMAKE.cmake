# https://developer.apple.com/documentation/avfaudio?language=objc

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(AVFAudio)
