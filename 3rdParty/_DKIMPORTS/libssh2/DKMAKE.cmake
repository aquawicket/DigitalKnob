#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/libssh2/libssh2.git


dk_import(https://github.com/libssh2/libssh2/archive/a8bc96c79491bd26d1e3e206dbba2cf4fc65baf8.zip)
#dk_import(https://github.com/libssh2/libssh2/archive/refs/heads/master.zip)


# TODO