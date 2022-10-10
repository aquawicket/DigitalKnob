# https://developer.apple.com/documentation/appkit

if(NOT MAC)
	dk_undepend(appkit)
	return()
endif()

dk_findLibrary(Appkit)
