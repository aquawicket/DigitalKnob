#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libssh2 ############
# https://github.com/libssh2/libssh2.git

dk_load(dk_builder)

dk_import(https://github.com/libssh2/libssh2/archive/a8bc96c.zip)


# TODO