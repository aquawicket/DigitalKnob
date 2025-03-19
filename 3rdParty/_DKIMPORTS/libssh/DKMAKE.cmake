#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libssh ############
# https://github.com/libssh/libssh-mirror

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/libssh/libssh-mirror/archive/ac6d2fad.zip)


# TODO
