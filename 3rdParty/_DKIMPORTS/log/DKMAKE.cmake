if(NOT ANDROID)
	dk_undepend(log)
	dk_return()
endif()

dk_depend(android-ndk)

#dk_findLibrary(log)
