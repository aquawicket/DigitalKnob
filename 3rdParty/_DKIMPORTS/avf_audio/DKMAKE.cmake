# https://developer.apple.com/documentation/avfaudio?language=objc
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(AVFAaudio_lib AVFAudio)
if(NOT AVFAaudio_lib)
	dk_warn("Could not locate AVFAudio framework")
endif()
APPLE_dk_lib(${AVFAaudio_lib})
