# https://developer.apple.com/documentation/corefoundation
if(NOT MAC_HOST)
	return()
endif()

dk_findLibrary(CoreFoundation)
