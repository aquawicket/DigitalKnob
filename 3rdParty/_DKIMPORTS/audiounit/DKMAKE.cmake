include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/audiounit?language=objc

if(NOT APPLE)
	dk_undepend(audiounit)
	dk_return()
endif()

dk_findLibrary(AudioUnit)
