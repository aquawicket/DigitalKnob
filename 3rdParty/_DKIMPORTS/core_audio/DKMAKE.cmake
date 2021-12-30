if(NOT MAC_HOST)
	return()
endif()

# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html

FIND_LIBRARY(CoreAudio_lib CoreAudio)
if(NOT CoreAudio_lib)
	DKWARN("Could not locate CoreAudio framework")
endif()
APPLE_DKLIB(${CoreAudio_lib})
