include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/IOKit

if(NOT APPLE)
	dk_undepend(iokit)
	dk_return()
endif()


dk_findLibrary(IOKit)
