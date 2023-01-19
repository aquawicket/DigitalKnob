# https://developer.apple.com/documentation/audiotoolbox

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(AudioToolbox)
