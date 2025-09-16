#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ conio-for-linux ############
# https://github.com/nowres/conio-for-linux.git
dk_validate(Target_Config  "dk_Target_Config()")
if(NOT UNIX_HOST)
	dk_disable(conio-for-linux)
	dk_return()
endif()

### DEPEND ###
dk_depend(ncurses)

### IMPORT ###
dk_import(https://github.com/nowres/conio-for-linux/archive/c2ee58ef.zip)

### LINK ###
dk_include(${CONIO_FOR_LINUX})
