# https://developer.apple.com/documentation/coremotion?language=objc

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(CoreMotion)
