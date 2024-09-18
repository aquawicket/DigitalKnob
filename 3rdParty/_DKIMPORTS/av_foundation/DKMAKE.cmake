include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/AVFoundation?language=objc

if(NOT APPLE)
	dk_undepend(av_foundation)
	dk_return()
endif()

dk_findLibrary(AVFoundation)
