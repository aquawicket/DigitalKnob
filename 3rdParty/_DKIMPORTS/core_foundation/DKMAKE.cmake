# https://developer.apple.com/documentation/corefoundation

if(NOT APPLE)
	dk_return()
endif()

dk_findLibrary(CoreFoundation)
