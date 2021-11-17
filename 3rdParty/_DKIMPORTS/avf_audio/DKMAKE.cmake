if(NOT CMAKE_HOST_APPLE)
	return()
endif()

# https://developer.apple.com/documentation/avfaudio?language=objc

FIND_LIBRARY(AVFAaudio_lib AVFAudio)
if(NOT AVFAaudio_lib)
	message(FATAL_ERROR "Could not locate AVFAudio framework")
endif()
APPLE_LIB(${AVFAaudio_lib})
