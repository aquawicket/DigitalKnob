# https://developer.apple.com/documentation/IOKit

if(NOT MAC_HOST)
	return()
endif()


dk_findLibrary(IOKit)
