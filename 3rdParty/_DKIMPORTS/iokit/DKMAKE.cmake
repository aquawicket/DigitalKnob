# https://developer.apple.com/documentation/IOKit

if(NOT APPLE)
	dk_undepend(iokit)
	dk_return()
endif()


dk_findLibrary(IOKit)
