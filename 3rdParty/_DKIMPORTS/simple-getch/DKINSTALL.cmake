#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### simple-getch ######
# https://github.com/mouuff/simple-getch
# https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip


dk_validate(host_triple "dk_host_triple()")
if(NOT UNIX_HOST)
	dk_undepend(simple-getch)
	dk_return()
endif()


#dk_import(https://github.com/mouuff/simple-getch.git)
dk_import(https://github.com/mouuff/simple-getch/archive/refs/heads/master.zip)


### LINK ###
dk_include		(${SIMPLE_GETCH}/getch/include)
dk_libDebug		(${SIMPLE_GETCH}/getch/libgetch.a)
dk_libRelease	(${SIMPLE_GETCH}/getch/libgetch.a)


### COMPILE ###
#DEBUG_dk_queueCommand	(../../make)
#RELEASE_dk_queueCommand(../../make)
dk_build(${SIMPLE_GETCH})
