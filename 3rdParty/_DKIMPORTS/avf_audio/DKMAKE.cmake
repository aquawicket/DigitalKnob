# https://developer.apple.com/documentation/avfaudio?language=objc

FIND_LIBRARY(avfaudio_lib AVFAudio)
if(NOT ${avfaudio_lib})
	message(FATAL_ERROR "Could not locate AVFAudio framework")
endif()
APPLE_LIB(${avfaudio_lib})
