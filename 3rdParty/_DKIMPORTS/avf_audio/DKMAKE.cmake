# https://developer.apple.com/documentation/avfaudio?language=objc
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AVFAaudio_lib AVFAudio)
if(NOT AVFAaudio_lib)
	DKWARN("Could not locate AVFAudio framework")
endif()
APPLE_DKLIB(${AVFAaudio_lib})
