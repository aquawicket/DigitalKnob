# opensles

if(NOT ANDROID AND NOT IOS AND NOT IOSSIM)
	dk_undepend(opensles)
	return()
endif()

dk_findLibrary(OpenSLES)
