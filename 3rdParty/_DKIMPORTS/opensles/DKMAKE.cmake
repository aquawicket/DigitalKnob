include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# opensles

if(NOT ANDROID AND NOT IOS AND NOT IOSSIM)
	dk_undepend(opensles)
	dk_return()
endif()

dk_findLibrary(OpenSLES)
