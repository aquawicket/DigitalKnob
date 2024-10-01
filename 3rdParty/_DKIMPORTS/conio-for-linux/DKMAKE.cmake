#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/nowres/conio-for-linux.git

if(NOT UNIX_HOST)
	dk_undepend(conio-for-linux)
	dk_return()
endif()


### DEPEND ###
dk_depend(ncurses)


### IMPORT ###
dk_import(https://github.com/nowres/conio-for-linux/archive/c2ee58efcb93a4b13826f5a9f2361a27b22d65ce.zip)
#dk_import(https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip)



### LINK ###
dk_include(${CONIO_FOR_LINUX})
