include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://developer.apple.com/documentation/audiotoolbox

if(NOT APPLE)
	dk_undepend(audio_toolbox)
	dk_return()
endif()

dk_findLibrary(AudioToolbox)
