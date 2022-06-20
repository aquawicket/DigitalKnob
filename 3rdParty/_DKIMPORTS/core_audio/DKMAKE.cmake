# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html
if(NOT MAC_HOST)
	return()
endif()


FIND_LIBRARY(CoreAudio_lib CoreAudio)
if(NOT CoreAudio_lib)
	dk_warn("Could not locate CoreAudio framework")
endif()
APPLE_dk_lib(${CoreAudio_lib})
