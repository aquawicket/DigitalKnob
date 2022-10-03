# https://developer.apple.com/documentation/corevideo

if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(CoreVideo)
