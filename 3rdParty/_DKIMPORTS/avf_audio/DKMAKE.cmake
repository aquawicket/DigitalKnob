if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/documentation/avfaudio?language=objc

FIND_LIBRARY(AVFAaudio_lib AVFAudio)
if(NOT AVFAaudio_lib)
	message(WARNING "Could not locate AVFAudio framework")
endif()
APPLE_DKLIB(${AVFAaudio_lib})
