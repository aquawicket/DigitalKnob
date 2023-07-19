if(NOT UNIX)
	dk_undepend(dl)
	dk_return()
endif()

ANDROID_dk_depend(android-ndk)

dk_findLibrary(dl)

LINUX_dk_lib		(dl)
RASPBERRY_dk_lib	(dl)
