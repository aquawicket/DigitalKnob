include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://developer.apple.com/documentation/metal?language=objc

if(NOT APPLE)
	dk_undepend(metal)
	dk_return()
endif()

dk_findLibrary(Metal)
