#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ lame ############
# https://sourceforge.net/p/lame/svn/HEAD/tree
# https://github.com/lameproject/lame.git
dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/lameproject/lame/archive/1f5cc948.zip)


# TODO
