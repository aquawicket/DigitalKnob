# https://developer.apple.com/documentation/audiotoolbox

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(AudioToolbox)
