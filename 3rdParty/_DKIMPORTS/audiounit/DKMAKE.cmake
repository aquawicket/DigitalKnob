# https://developer.apple.com/documentation/audiounit

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(AudioUnit)
