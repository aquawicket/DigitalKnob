if(NOT ANDROID)
	dk_undepend(android)
	return()
endif()

ANDROID_dk_depend(android-ndk)

dk_findLibrary(android)
