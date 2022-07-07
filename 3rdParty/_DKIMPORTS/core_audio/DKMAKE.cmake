# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(CoreAudio)
