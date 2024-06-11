include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT ANDROID)
	dk_undepend(log)
	dk_return()
endif()

dk_depend(android-ndk)

dk_findLibrary(log NO_HALT)
