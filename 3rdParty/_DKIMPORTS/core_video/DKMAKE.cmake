# https://developer.apple.com/documentation/corevideo

if(NOT APPLE)
	dk_undepend(core_video)
	dk_return()
endif()

dk_findLibrary(CoreVideo)
