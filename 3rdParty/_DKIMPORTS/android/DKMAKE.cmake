if(NOT ANDROID)
	dk_undepend(android)
	dk_return()
endif()

dk_depend(android-ndk)

dk_findLibrary(android)
