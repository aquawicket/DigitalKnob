# https://developer.apple.com/documentation/avfaudio?language=objc

if(NOT APPLE)
	dk_undepend(avf_audio)
	dk_return()
endif()

dk_findLibrary(AVFAudio)
