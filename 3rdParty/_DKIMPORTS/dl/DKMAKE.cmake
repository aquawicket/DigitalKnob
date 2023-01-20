if(NOT ANDROID)
	dk_undepend(dl)
	dk_return()
endif()

dk_depend(android-ndk)

dk_findLibrary(dl)
