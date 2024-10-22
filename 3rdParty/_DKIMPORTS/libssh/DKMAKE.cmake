#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libssh ############
# https://github.com/libssh/libssh-mirror

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libssh/libssh-mirror/archive/ac6d2fad.zip)


# TODO
