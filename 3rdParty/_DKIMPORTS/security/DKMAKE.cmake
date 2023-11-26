# https://developer.apple.com/documentation/security?language=objc

if(NOT APPLE)
	dk_undepend(security)
	dk_return()
endif()

dk_findLibrary(Security)
