if(NOT ANDROID)
	return()
endif()

ANDROID_dk_depend(android-ndk)

dk_findLibrary(m)
