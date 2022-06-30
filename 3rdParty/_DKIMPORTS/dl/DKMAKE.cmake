if(WIN)
	return()
endif()

ANDROID_dk_depend(android-ndk)

if(ANDROID)
	dk_findLibrary(dl)
endif()