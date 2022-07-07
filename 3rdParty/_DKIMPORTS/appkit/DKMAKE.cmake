# https://developer.apple.com/documentation/appkit

if(NOT MAC)
	return()
endif()

dk_findLibrary(Appkit)
