#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ dl ############
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
elseif(RASPBERRY)
	dk_lib	(dl)
endif()
