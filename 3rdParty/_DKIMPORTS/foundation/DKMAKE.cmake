include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/foundation?language=objc

if(NOT APPLE)
	dk_undepend(foundation)
	dk_return()
endif()


dk_findLibrary(Foundation)
