# https://developer.apple.com/documentation/IOKit

if(NOT APPLE)
	dk_return()
endif()


dk_findLibrary(IOKit)
