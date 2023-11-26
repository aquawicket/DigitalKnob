# https://developer.apple.com/documentation/corefoundation

if(NOT APPLE)
	dk_undepend(core_foundation)
	dk_return()
endif()

dk_findLibrary(CoreFoundation)
