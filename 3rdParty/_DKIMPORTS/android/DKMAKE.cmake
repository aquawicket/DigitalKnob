if(NOT ANDROID)
	dk_undepend(android)
	dk_return()
endif()

dk_depend(android-ndk)

if(NOT ANDROID_HOST)
	dk_findLibrary(android)
endif()
