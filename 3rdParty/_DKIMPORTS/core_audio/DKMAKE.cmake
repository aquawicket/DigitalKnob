# https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/WhatisCoreAudio/WhatisCoreAudio.html

if(NOT APPLE)
	dk_return()
endif()


dk_findLibrary(CoreAudio)
