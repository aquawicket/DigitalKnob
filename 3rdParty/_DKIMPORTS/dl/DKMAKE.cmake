#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
if(NOT UNIX)
	dk_undepend(dl)
	dk_return()
endif()

ANDROID_dk_depend(android-ndk)

dk_findLibrary(dl NO_HALT)

LINUX_dk_lib		(dl)
RASPBERRY_dk_lib	(dl)
