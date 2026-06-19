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


############ conio-for-linux ############
# https://github.com/nowres/conio-for-linux.git
# https://github.com/nowres/conio-for-linux/archive/c2ee58ef.zip

#if(NOT UNIX_HOST)
#	dk_disable(conio-for-linux)
#	dk_return()
#endif()

dk_depend(ncurses)

dk_import()

dk_include(${conio-for-linux})
