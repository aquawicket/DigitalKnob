# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html

FIND_LIBRARY(coreaudio_lib CoreAudio)
if(NOT ${coreaudio_lib})
	message(FATAL_ERROR "Could not locate CoreAudio framework")
endif()
APPLE_LIB(${coreaudio_lib})
