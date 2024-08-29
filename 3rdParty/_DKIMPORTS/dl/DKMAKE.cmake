include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
if(NOT UNIX)
	dk_undepend(dl)
	dk_return()
endif()

ANDROID_TARGET_dk_depend(android-ndk)

dk_findLibrary(dl NO_HALT)

LINUX_TARGET_dk_lib		(dl)
RASPBERRY_TARGET_dk_lib	(dl)
