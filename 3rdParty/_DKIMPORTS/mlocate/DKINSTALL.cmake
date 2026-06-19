#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ mlocate ############
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST OR Android)
	dk_disable(mlocate)
	dk_return()
endif()

dk_chdir(/usr)
dk_installPackage(mlocate)
dk_validate(sudo_exe "dk_depend(sudo_exe)")
dk_exec(${sudo_exe} updatedb)
