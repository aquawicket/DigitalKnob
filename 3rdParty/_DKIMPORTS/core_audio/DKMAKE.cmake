if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html

FIND_LIBRARY(CoreAudio_lib CoreAudio)
if(NOT CoreAudio_lib)
	message(WARNING "Could not locate CoreAudio framework")
endif()
APPLE_LIB(${CoreAudio_lib})
