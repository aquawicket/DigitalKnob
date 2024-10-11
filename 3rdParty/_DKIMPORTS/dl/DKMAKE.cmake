#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

if(NOT UNIX)
	dk_undepend(dl)
	dk_return()
endif()


if(ANDROID)
	dk_depend(android-ndk)
endif()


dk_findLibrary(dl NO_HALT)
if(LINUX)
	dk_lib	(dl)
endif()
if(RASPBERRY)
	dk_lib	(dl)
endif()