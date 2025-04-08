#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ conio-for-linux ############
# https://github.com/nowres/conio-for-linux.git
dk_load(dk_builder)
if(NOT UNIX_HOST)
	dk_undepend(conio-for-linux)
	dk_return()
endif()

### DEPEND ###
dk_depend(ncurses)

### IMPORT ###
dk_import(https://github.com/nowres/conio-for-linux/archive/c2ee58ef.zip)

### LINK ###
dk_include(${CONIO_FOR_LINUX})
