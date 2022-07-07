# https://developer.apple.com/documentation/coremotion?language=objc

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(CoreMotion)
