# https://developer.apple.com/documentation/coregraphics?language=objc

if(NOT APPLE)
	dk_undepend(core_services)
	dk_return()
endif()

dk_findLibrary(CoreServices)
