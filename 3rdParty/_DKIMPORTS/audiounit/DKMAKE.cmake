# https://developer.apple.com/documentation/audiounit

if(NOT MAC)
	return()
endif()

dk_findLibrary(AudioUnit)
