#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ netsurf ############
# https://git.netsurf-browser.org/netsurf.git


dk_import(https://git.netsurf-browser.org/netsurf.git)