if(NOT ANDROID)
	dk_return()
endif()

dk_depend(android-ndk)

dk_findLibrary(dl)
