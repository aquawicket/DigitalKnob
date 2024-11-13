#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://www.mpg123.de/cgi-bin/scm/mpg123/?view=tar


### IMPORT ###
dk_import(https://www.mpg123.de/cgi-bin/scm/mpg123/?view=tar)


# TODO
